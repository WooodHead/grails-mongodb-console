
<div class="title">
    <div class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown">
            {{currentDB}}
            <b class="caret"></b>
        </a>
        <ul class="dropdown-menu" role="menu">
            <li><a ng-click="selectdb(currentDB)"> Collection</a></li>
            <li class="divider"></li>
            <li><a ng-click="copyDB()"><i class="icon-repeat"></i> Copy DB</a></li>
            <li><a ng-click="dropDB()"><i class="icon-trash"></i> Drop DB</a></li>
            <li class="divider"></li>
            <li><a ng-click="createCol('create-new-col')"><i class="icon-plus"></i> Create Collection</a></li>
            <li class="divider"></li>
            <li><a ng-click=""><i class="icon-download-alt"></i> Import</a></li>
            <li><a ng-click=""><i class="icon-share"></i> Export</a></li>
        </ul>
    </div>
    <span class="divider"></span>
    <span ng-show="!renamingCol">{{currentCollection}}</span>

    <div class="rename input-append" ng-show="renamingCol">
        <div class="btn-group">
            <input type="text" class="span4" id="rename-new-col" ng-model="renColName" value="{{renColName}}" />
            <button class="btn btn-primary" ng-click="validateColnameChange()">
                <i class="icon-white icon-ok"></i>
            </button>
            <button class="btn" ng-click="cancel()">
                <i class="icon-remove"></i>
            </button>
        </div>
    </div>

</div>

<div ng-show="currentCollection" class="page-actions" style="margin-bottom:10px">
    <a class="btn" ng-click="renameCol('rename-new-col')"><i class="icon-edit"></i> Rename Collection</a>
    <a class="btn" ng-click="dropCol()"><i class="icon-trash"></i> Drop Collection</a>
    <a class="btn" ng-click="createDoc()"><i class="icon-plus"></i> New document</a>
    <a class="btn" ng-click=""><i class="icon-share"></i> Export results</a>
    <a class="btn" ng-click=""><i class="icon-th-list"></i> Ensure Index</a>
    <a class="btn" ng-click=""><i class="icon-refresh"></i> Re-index</a>
</div>

<g:render template="/document/find" />
<g:render template="/mviewer/paginator" model="[varTotal: 'totalCount']" />

<div class="main">
    <div class="document-entry editable-{{editMode}} doc-{{$index}}" ng-repeat="document in documents" ng-class="{active: editMode}">
        <div class="head" ng-init="editMode = false">
            <label>
                <input type="checkbox" value="{{document._id.toString()}}"/>
                Object ID : <span class="mongo-object-id">{{document._id.toString()}}</span>
            </label>
            <div class="actions">
                <a ng-click="setEditable('json-document-'+document._id.toString(), !editMode); editMode = !editMode" ng-class="{active: editMode}"><i class="icon-pencil"></i></a>
                <a ng-click="deleteDocument(document._id.toString())"><i class="icon-trash"></i></a>
            </div>
        </div>

        <pre id="json-document-{{document._id.toString()}}" ng-class="{active: editMode}" class="prettyprint json limited pre" ng-bind-html-unsafe="document | commonJson"></pre>

        <div class="foot" ng-show="editMode">
            <div class="extra"></div>
            <a ng-click="submitChange('json-document-'+document._id.toString(), document._id.toString(), document)" class="btn btn-primary"><i class="icon-ok icon-white"></i> Save</a>
            <a ng-click="cancel()" class="btn"><i class="icon-remove"></i> Cancel</a>
        </div>
    </div>
</div>