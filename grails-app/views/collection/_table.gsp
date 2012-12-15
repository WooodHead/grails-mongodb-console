<div class="title-buttons">

    <div class="title">
        <span>{{currentDB}}</span>
    </div>

    <div class="nav-buttons" ng-show="currentDB && !currentCollection">
        <a class="btn btn-icon" ng-click="copyDB()"><i class="icon-repeat"></i> Copy DB</a>
        <a class="btn btn-icon" ng-click="createCol('create-new-col')"><i class="icon-plus"></i> Create Collection</a>
        <a class="btn btn-icon" ng-click=""><i class="icon-download-alt"></i> Import</a>
        <a class="btn btn-icon" ng-click=""><i class="icon-share"></i> Export</a>
    </div>
</div>

<p ng-show="collections.length==0">This database is empty. <a ng-click="createCol('create-new-col')">Create a collection</a>.</p>
<div class="main" ng-show="collections.length>0">
    <table class="table table-striped table-clickable">
        <thead>
        <tr>
            <th width="10px">&nbsp;</th>
            <th>Name</th>
            <th width="40px">&nbsp;</th>
        </tr>
        </thead>
        <tbody>

        <tr ng-repeat="collection in collections">
            <td width="10px">
                <input type="checkbox" />
            </td>
            <td ng-click="selectCollection(collection)"><a href="${createLink(controller:'mongo')}/{{currentDB}}/{{collection}}" ng-click="selectCollection(collection)">{{collection}}</a></td>
            <td width="10px" nowrap="nowrap">
                <a><i class="icon-edit"></i></a>
                <a><i class="icon-trash"></i></a>
            </td>
        </tr>
        </tbody>
    </table>
</div>