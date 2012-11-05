<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>

            <div id="logo">
                <a class="brand" href="#">Mongo Viewer Plugin</a>
            </div>

            <div class="nav-collapse collapse">
                <ul class="nav pull-right">
                    <li class="dropdown">
                        <a href="#db" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-leaf icon-white"></i> Mongo Instance Info <b class="caret"></b>
                        </a>

                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                            <li class="nav-header">
                                Mongo v2.2.0<br>
                                Master shard<br>
                                Uptime : 120 days<br>
                                192.168.34.1:27017<br>
                            </li>
                            <li><a href="#"><i class="icon-arrow-left"></i> More infos</a></li>
                            <li class="divider"></li>
                            <li><a href="#"><i class="icon-retweet"></i> Change server</a></li>
                            <li><a href="#"><i class="icon-list"></i> List replicas</a></li>
                        </ul>
                    </li>
                </ul>
                <ul class="nav">
                    <li ng-class="{active: !currentDB && !currentCollection && collections.length == 0}"><a ng-click="homepage()">MongoDB home</a></li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">Databases <b class="caret"></b></a>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu">
                            <li><a href="#" ng-click="createDB()"><i class="icon-plus"></i> Create DB</a></li>
                            <li><a href="#" ng-click="createDB()"><i class="icon-download-alt"></i> Import DB</a></li>
                            <li class="divider"></li>
                            <li ng-repeat="db in databases" class="item" ng-class="{active: db.name == currentDB}">
                                <a href="#" ng-click="selectdb(db.name)">
                                    <strong>{{db.name}}</strong> <em>({{db.sizeOnDisk | fileSize}})</em>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li><a href="#gridfs">GridFS</a></li>
                    <li><a href="#administrative">Administrative data</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>