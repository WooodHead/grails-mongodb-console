<div class="modal hide fade" id="copyDB">
    <div class="modal-header">
        <button type="button" class="close" ng-click="cancel()">&times;</button>
        <h4>Copy a database</h4>
    </div>
    <div class="modal-content">
        <form class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="inputCopy">Name</label>
                <div class="controls">
                    <input type="text" id="inputCopy" value="{{currentDB}}-copy"/>
                </div>
            </div>
        </form>
    </div>
    <div class="modal-footer">
        <a class="btn btn-primary"><i class="icon-ok icon-white"></i> Rename</a>
        <a class="btn" ng-click="cancel()"><i class="icon-remove"></i> Cancel</a>
    </div>
</div>
