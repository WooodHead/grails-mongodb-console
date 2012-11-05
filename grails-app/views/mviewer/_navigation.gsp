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
                <p class="navbar-text pull-right">
                    Current database <a href="#" class="navbar-link">{{currentDB}}</a>
                </p>
                <ul class="nav">
                    <li class="{{isHome()}}"><a ng-click="homepage()">Home</a></li>
                    %{--
                    <li class="dropdown">
                        <a href="#db" class="dropdown-toggle" data-toggle="dropdown">A random menu <b class="caret"></b>
                        </a>

                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                            <li><a href="#"><i class="icon-list"></i> Do something</a></li>
                            <li><a href="#"><i class="icon-plus"></i> Do something else</a></li>
                            <li class="divider"></li>
                            <li class="nav-header">Something(s)</li>
                        </ul>
                    </li>
                    --}%
                    <li><a href="#gridfs">GridFS</a></li>
                    <li><a href="#administrative">Administrative data</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>