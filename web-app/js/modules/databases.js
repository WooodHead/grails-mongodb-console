function DBListCtrl($scope, $http, $timeout, mongodb) {
    $scope.creatingDB = false;
    $scope.copyingDB = false;
    $scope.renamingCol = false;
    $scope.creatingCol = false;
    $scope.newDbname = null;
    $scope.newColname = null;
    $scope.renColName = null;

    $scope.currentDB = null;
    $scope.currentDBSize = 0;
    $scope.totalSize = 0;
    $scope.currentCollection = null;

    $scope.databases = {};
    $scope.collections = [];
    $scope.documents = [];
    $scope.totalCount = 0;

    $scope.init = function(selectedDB, selectedCol) {
        mongodb.listDatabases().success(function(data) {
            $scope.databases = data.databases;
            $scope.totalSize = data.totalSize;
            if(selectedDB != null) {
                $scope.selectdb(selectedDB);
            }
            if(selectedCol != null) {
                $scope.selectCollection(selectedCol);
            }
        });
    };

    $scope.focus = function(inputId) {
        $timeout(function() {
            $('input#'+inputId).attr('tabindex', -1).focus();
        }, 10);
    };

    $scope.populateDocuments = function(data) {
        if(data.results != null) {
            $scope.documents = data.results;
        } else {
            if(data != null) {
                $scope.documents = data;
            } else {
                $scope.documents = [];
            }
        }

        if(data.totalCount != null) {
            $scope.totalCount = data.totalCount;
        } else {
            $scope.totalCount = $scope.documents.length;
        }
    };

    $scope.selectdb = function(dbname) {
        $scope.cancel();
        $scope.currentDB = dbname;
        $scope.currentDBSize = $scope.databases[dbname].sizeOnDisk;
        $scope.currentCollection = null;
        $scope.documents = [];
        $scope.populateDocuments([]);

        mongodb.use(dbname).success(function(data) {
            $scope.collections = data;
        });

    };

    $scope.selectCollection = function(colname, params) {
        $scope.cancel();
        $scope.currentCollection = colname;
        $scope.renColName = colname;
        var args = {};
        var offset = params != undefined ?params.offset : null;
        var max = params != undefined ? params.max : null;

        mongodb[colname].find().skip(offset).limit(max).exec(function(data) {
            $scope.populateDocuments(data);
        }, function(data){alert(data);});
    };

    $scope.createDB = function() {
        $scope.cancel();
        $scope.creatingDB = true;
    };

    $scope.copyDB = function() {
        $scope.cancel();
        $scope.copyingDB = true;
    };

    $scope.renameCol = function(inputId) {
        $scope.cancel();
        $scope.renamingCol = true;
        $scope.focus(inputId);
    };

    $scope.createCol = function(inputId) {
        $scope.cancel();
        $scope.documents = [];
        $scope.creatingCol = true;
        $scope.focus(inputId);

    };

    $scope.validateDBCreation = function() {
        var newDbname = $scope.newDbname;

        mongodb.createDatabase(newDbname)
            .success(function(data) {
                $scope.currentDB = newDbname;
                $scope.currentCollection = null;
                $scope.cancel();
                $scope.databases = data.databases;
                $scope.populateDocuments([]);
                mongodb($scope.currentDB).success(function(data) {
                    $scope.collections = data;
                });
            });
    };

    $scope.validateColnameChange = function() {
        var newColname = $scope.renColName;
        mongodb[$scope.currentCollection].renameCollection(newColname)
            .success(function(data) {
                $scope.currentCollection = newColname;
                $scope.cancel();
                mongodb($scope.currentDB).success(function(data) {
                    $scope.collections = data;
                });
            });
    };

    $scope.validateCreateCollection = function() {
        var newColname = $scope.newColname;
        mongodb.createCollection(newColname)
            .success(function(data) {
                $scope.currentCollection = newColname;
                $scope.cancel();
                mongodb($scope.currentDB).success(function(data) {
                    $scope.collections = data;
                });
            }).error(function(data){
                alert(data);
            });
    };

    $scope.dropCol = function() {
        if(confirm("This action cannot be undone. Drop the collection '" + $scope.currentCollection + "' from the db '"+$scope.currentDB + "'?")) {
            mongodb[$scope.currentCollection].dropCollection()
                .success(function(data) {
                    $scope.currentCollection = null;
                    $scope.cancel();
                    mongodb($scope.currentDB).success(function(data) {
                        $scope.collections = data;
                    });
                });
        }
    };

    $scope.dropDB = function() {
        if(confirm("This action cannot be undone. Drop the database '"+$scope.currentDB + "'?")) {
            mongodb.dropDatabase()
                .success(function(data) {
                    $scope.currentDB = null;
                    $scope.currentCollection = null;
                    $scope.currentDBSize = 0;
                    $scope.cancel();
                    $scope.databases = data.databases;
                    $scope.collections = [];
                    $scope.populateDocuments([]);
                });
        }
    };

    $scope.cancel = function() {
        $scope.creatingDB = false;
        $scope.copyingDB = false;
        $scope.renamingCol = false;
        $scope.creatingCol = false;
        $scope.renColName = $scope.currentCollection;
        $scope.newColname = null;
        $scope.newDbname = null;
    };

    $scope.activeDB = function(db) {
        if(db.name == $scope.currentDB) {
            return 'active';
        } else {
            return '';
        }
    };

    $scope.activeCollection = function(collection) {
        if(collection == $scope.currentCollection) {
            return 'active';
        } else {
            return '';
        }
    };

    $scope.isDbSelected = function() {
        if($scope.currentDB && !$scope.currentCollection) {
            return 'active';
        } else {
            return '';
        }
    };

    $scope.$on('PaginationChangeEvent', function(event, params){
        $scope.selectCollection($scope.currentCollection, params);
    });
}

function parseMongoJson(data, headerGetter) {
    return MongoJSON.parse(data, mongoJsonReviver);
}