<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name = "Layout" content="HeaderFooterWrapper">
    <title>Applications Actions</title>
    <script type="text/javascript">

    var xmlhttp;

    if (window.XMLHttpRequest) {
    	xmlhttp = new XMLHttpRequest();/*alert("Not Microsoft");*/
    } else {
    	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    	alert("javascript not found, falling back to activex");
    }


    function submitApplicationAction(){

        var appId = document.getElementById('applicationSelected').value;
        var actionName = document.getElementById('actionName').value;
        var actionDescription = document.getElementById('actionDescription').value;

        console.log("actionName"+actionName);
        console.log("actionDescription"+actionDescription);
        xmlhttp.open("POST", "submitApplicationAction", true);
        xmlhttp.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");

        xmlhttp.send('actionName='+actionName+'&actionDescription='+actionDescription+'&appId='+appId);
        xmlhttp.onreadystatechange = function() {
          if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
            processResults();
          }
          }

        function processResults() {
          if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            document.getElementById('actionsContainer').innerHTML = xmlhttp.responseText;
            //needs to update list of actions for the application list.




          }
        }


    }


    var xmlhttp1;

    if (window.XMLHttpRequest) {
      xmlhttp1 = new XMLHttpRequest();/*alert("Not Microsoft");*/
    } else {
      xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
      alert("javascript not found, falling back to activex");
    }


    function fetchApplicationActions(){
        var appId = document.getElementById('applicationSelected').value;
        console.log(appId);
        console.log(appId.length);

        if(applicationSelected.length != 0){
          console.log('length is not == 0');
          document.getElementById('inputForm').style = "display:block;"

        xmlhttp1.open("POST", "fetchApplicationActions", true);
        xmlhttp1.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
        xmlhttp1.send('appId='+appId);

        xmlhttp1.onreadystatechange = function() {
          if(xmlhttp1.readyState == 4 && xmlhttp1.status == 200){
            processResults();
          }
          }

        function processResults() {
          if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
            document.getElementById('actionsContainer').innerHTML = xmlhttp1.responseText;
          }
          }

        }else{
            document.getElementById('actionsContainer').innerHTML = "";
            document.getElementById('inputForm').style = "display:none;"

        }
    }




    </script>
  </head>
  <body>
    <g:render template="teambuilderNav"/>
    <div class="" style="width:85%;float:left;">


    <h1>Applications Actions</h1>
    <h2>WARNING: Creating Applications and Actions is intended to be done before granting permission sets on them. They are not meant to be renamed/changed. Their names are used a keys in the grail_json data, to maintain it being human readable. If a app/action's permission set is no longer needed remove entries by removeing the roles/permission first to remove all entries in json files.<h2>


        <h2>Select a Application to view its actions.</h2>

        <label for="applicationSelected">Application</label> <select id="applicationSelected" onchange="fetchApplicationActions()" style="width:50%;">
          <option value=""></option>
          <g:each var="app" in="${applicationsList}">
            <option value="${app.id}">${app.APPLICATION_NAME}</option>
          </g:each>
        </select>

    <!--Check for view privilege-->
  <div id="actionsContainer">

  </div>
  <br>
  <div id="inputForm">


    <!--Check for create privilege-->
    <label for="actionName">Action Name</label><br><input id="actionName" type="text" name="" value=""><br>
    <label for="actionDescription">Action Description</label><br><textarea id="actionDescription" name="name" rows="4" cols="40"></textarea><br>
  </div>



    <br>
    <button type="button" name="button" onclick="submitApplicationAction()">Submit Application Action</button>

</div>
  </body>
</html>
