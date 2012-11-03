package mongo.viewer

import grails.converters.JSON
import com.gmongo.GMongo
import com.mongodb.BasicDBObject
import com.mongodb.MongoException
import com.mongodb.DBObject

class MviewerController {

    GMongo mongo

    private mviewerSession(dbname = null, colname = null) {
        if(!session.mviewer) {
            session.mviewer = [:]
        }
        session.mviewer.currentDB = dbname
        session.mviewer.currentCol = colname
    }

    def test() {
    }

    def index() {
        [databases:mongo.mongo.getDatabaseNames()]
    }

    def listDb() {
        println "List databases"
        println mongo.getDB("admin").command("listDatabases")
        //render mongo.getDatabaseNames() as JSON
        def resp = mongo.getDB("admin").command("listDatabases")
        render ([totalSize: resp.totalSize,
                databases: resp?.databases?.inject([:]) { map, entry ->
                    map[entry.name] = entry
                    map
                }] as JSON)
    }

    def listCollections() {
        mviewerSession(params.dbname)
        render mongo.getDB(params.dbname).getCollectionNames() as JSON
    }

    def createDb() {
        mviewerSession(request.JSON.dbname)
        mongo.getDB(request.JSON.dbname).createCollection('default', [:])
        forward action: "listDb"
    }

    def copyDb() {
        def db = mongo.getDB(params.dbname)

        try {
            // todo
        }catch(e) {
            e.printStackTrace()
        }
    }

    def dropDb() {
        mviewerSession()
        mongo.getDB(request.JSON.dbname).dropDatabase()
        forward action: "listDb"
    }

    def createCollection() {
        String dbname = request.JSON.dbname
        String colname = request.JSON.newColname
        def db = mongo.getDB(dbname)
        try {
            db.createCollection(colname, [:])
            mviewerSession(request.JSON.dbname, request.JSON.newColname)
        }catch(MongoException mongoException) {
            render status: 500, text:mongoException.message
            return
        }
        forward action: 'listDocuments', params:[dbname:dbname, colname:colname]
    }

    def renameCollection() {
        def db = mongo.getDB(request.JSON.dbname)
        def col = db.getCollection(request.JSON.colname)

        try {
            col.rename(request.JSON.newColname)
            mviewerSession(request.JSON.dbname, request.JSON.newColname)
            render status: 200
        } catch(e) {
            e.printStackTrace()
            render status: 500
        }
    }

    def dropCollection() {
        def db = mongo.getDB(request.JSON.dbname)
        def col = db.getCollection(request.JSON.colname)

        try {
            col.drop()
            mviewerSession(request.JSON.dbname)
            render status: 200
        } catch(e) {
            e.printStackTrace()
            render status: 500
        }
    }

    def listDocuments() {
        def db = mongo.getDB(params.dbname)
        def col = db.getCollection(params.colname)

        mviewerSession(db, col)
        def cursor = col.find().limit(params.int('max') ?: 30).skip(params.int('offset') ?: 0);
        def results = cursor.inject([]) { coll, BasicDBObject entry ->
            def args = [:]
            for(key in entry.keySet()) {
                args[key] = marshallDocument(entry[key])
            }
            coll << args
            coll
        }

        def res = [results:results, totalCount:cursor.count()]
        render res as JSON
    }

    private marshallDocument(element){
        def res
        switch(element) {
            // Bytes are too much for display, the actual data is not sent to the client, we just send the
            // total size of the blob
            case byte[]:
                res = [$data:[size:element.size()]]
                break
            // ObjectId are composed of multiple field, which are then serialized into a uuid
            // The client only need the uuid
            case org.bson.types.ObjectId:
                res = [$oid:element.toString()]
                break
            // Marshall any element of a Collection
            case com.mongodb.BasicDBList:
                def list = []
                for(e in element) {
                    list << marshallDocument(e)
                }
                res = list
                break
            // DBRef are not resolve, we just show the collection name and the id of the entry
            // The client may ask for the specified entry afterward
            case com.mongodb.DBRef:
                com.mongodb.DBRef dbref = element
                res = [$ref:dbref.ref, $id:dbref.id]
                break
            // Embedded documents have their field marshalled individually
            case DBObject:
                def elem = [:]
                for (key in ((DBObject)element).keySet()) {
                    elem[key] = marshallDocument(element[key])
                }
                res = elem
                break
            default:
                res = element
                break
        }
        res
    }
}
