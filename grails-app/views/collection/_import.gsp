<div class="modal hide fade" id="importData">
  <div class="modal-header">
    <button type="button" class="close" ng-click="cancel()">&times;</button>
    <h4>Import data into a collection</h4>
  </div>
  <form id="uploadfile" class="form-horizontal" method="POST" enctype="multipart/form-data" data-url="${createLink(controller: 'mviewer', action:'importData')}"
        drop-zone="#importData"
        file-upload>
    <div class="modal-content">
        <div class="control-group">
          <label class="control-label" for="import-data-col">Collection name</label>
          <div class="controls">
            %{--TODO : For some reasons, the value is not bind properly on type="hidden" input...--}%
            <input type="text" style="display:none;" name="dbname" value="{{currentDB()}}"/>
            <input type="text" id="import-data-col" ng-model="colToUpload" name="colname" value="{{colToUpload}}" required/>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="import-data-file">File</label>
          <div class="controls">
            <span class="btn btn-success fileinput-button" onclick="$('#import-data-file').focus()">
              <i class="icon-plus icon-white"></i>
              <span>Select file...</span>
              <input style="opacity: 0" type="file" id="import-data-file" name="importFile"/>
            </span>
            <ul>
              <li ng-repeat="file in fileList()">
                {{file.name}}
              </li>
            </ul>
          </div>
        </div>
    </div>

    <div class="modal-footer">
      <a class="btn btn-primary" ng-click="submit()"><i class="icon-ok icon-white"></i> Import</a>
      <a class="btn cancel" ng-click="cancel()"><i class="icon-remove"></i> Cancel</a>
    </div>
  </form>
</div>