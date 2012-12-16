<ul class="well" ng-show="currentDB()">
    <li class="well-mongo dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown">
            Databases
            <i class="icon-white icon-chevron-right"></i>
        </a>
        <ul class="dropdown-menu">
            <li><a ng-click="createDB()"><i class="icon-plus"></i> Create DB</a></li>
            <li><a ng-click="createDB()"><i class="icon-download-alt"></i> Import DB</a></li>
            <li class="divider"></li>
            <li ng-repeat="db in databases()" ng-class="{active: db.name == currentDB()}">
                <a href="#/mongo/{{db.name}}">
                    <strong>{{db.name}}</strong> <em>({{db.sizeOnDisk | fileSize}})</em><br/>
                    <span class="extra"></span>
                </a>
            </li>
        </ul>
    </li>
    <li class="well-db" ng-class="{active:currentDB() && !currentCollection()}">
        <a href="#/mongo/{{currentDB()}}">
            {{currentDB()}} ({{ currentDBSize() | fileSize }})<br/>
            <span ng-show="collections().length>0">Collections ({{collections().length}})</span>
            <span ng-show="collections().length==0">Empty</span>
            <span class="extra"></span>
        </a>
    </li>
    <li ng-repeat="collection in collections()" class="item-collection" ng-class="{active:collection == currentCollection()}">
        <a href="#/mongo/{{currentDB()}}/{{collection}}">
            {{collection}}
            <span class="extra"></span>
        </a>
    </li>
</ul>
<ul class="well" ng-show="!currentDB()">
    <li>
        <span>
            Mongo v2.2.0<br>
            Master shard<br>
            Uptime : 120 days<br>
            192.168.34.1:27017<br>
        </span>
    </li>
</ul>
