<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name = "Layout" content="HeaderFooterWrapper">
    <title>Roles</title>
    <style media="screen">
      .inputForm{ display:block;float:left;}
      .inputForm label{ display:block;float:left;}
      #mainContent{float:left;display:block;}
      .container { border:2px solid #ccc; width:300px; height: 100px; overflow-y: scroll; }
      .subTable tr:nth-child(even) {
  background-color: #f2f2f2;
}
    </style>
    <script type="text/javascript">
    var xmlhttp;

    if (window.XMLHttpRequest) {
    	xmlhttp = new XMLHttpRequest();/*alert("Not Microsoft");*/
    } else {
    	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    	alert("javascript not found, falling back to activex");
    }


    function submitRole(){
        var organization = document.getElementById('organizationSelected').value
        var roleName = document.getElementById('roleName').value;
        var roleDescription = document.getElementById('roleDescription').value;
        var roleOrder = document.getElementById('roleOrder').value;

        console.log("organization"+organization);
        console.log("roleName"+roleName);
        console.log("roleDescription"+roleDescription);
        console.log("roleOrder"+roleOrder);

        xmlhttp.open("POST", "submitRole", true);
        xmlhttp.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
        xmlhttp.send('organization='+organization+'&roleName='+roleName+'&roleDescription='+roleDescription+'&roleOrder='+roleOrder);

        xmlhttp.onreadystatechange = function() {
          if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
            processResults();
          }
          }

        function processResults() {
          if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            document.getElementById('rolesContainer').innerHTML = xmlhttp.responseText;
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


    function fetchActions(){
        var applicationSelected = document.getElementById('applicationSelected').value;
        console.log(applicationSelected);
        console.log(applicationSelected.length);
        var personSelected = document.getElementById('peopleList').value;
        console.log("personSelected"+personSelected);
        if(applicationSelected.length != 0){
          console.log('length is not == 0');


        xmlhttp1.open("POST", "fetchActions", true);
        xmlhttp1.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
        xmlhttp1.send('application='+applicationSelected+'&personSelected='+personSelected);

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

        }
    }
    var currentSelectedPerson = "";
    function personSelected(){
      var test = document.getElementById('peopleList').value;
      //if(personSelected == test){}

      if(test.length != 0){
        console.log('test is not null');
        document.getElementById('permissionsContainer').style = "display:block;";
        fetchActions();
    //    document.getElementById('actionsContainer').style = "display:block;"
      }else{
        document.getElementById('permissionsContainer').style = "display:none;";
        document.getElementById('actionsContainer').innerHTML = "";
        document.getElementById('applicationSelected').selectedIndex = 0;
      }
    }



    var xmlhttp2;

    if (window.XMLHttpRequest) {
      xmlhttp2 = new XMLHttpRequest();/*alert("Not Microsoft");*/
    } else {
      xmlhttp2 = new ActiveXObject("Microsoft.XMLHTTP");
      alert("javascript not found, falling back to activex");
    }

    function updateJsonArray(path){
      console.log("path"+path);
      var fixedPath = path.split('.');
      console.log("fixedPath"+fixedPath);

      //  var current = {};
      //console.log("fixedPath[fixedPath.length-1]: "+fixedPath[fixedPath.length-1]);

//EXAMPLE
/*
a={};
b=a;
list=['one','two','three','four'];
for (var q in list){
  console.log("before: " + JSON.stringify(b));
  a[list[q]]={};
  a=a[list[q]];
  console.log("after: " + JSON.stringify(b));

};
a="['yada','bobo']";
console.log(JSON.stringify(b));
*/

    //if parent key not checked, go ahead and check it because having a sub key implies you have the parent key.



      var personSelected = document.getElementById('peopleList').value;
    //  console.log("layer1"+layer1);
    //  console.log("layer2"+layer2);
    //  console.log("layer3"+layer3);
    //  console.log(`${'${layer1}'}.${'${layer2}'}.${'${layer3}'}`);
      var group = document.getElementsByName(path);
      var updateString = [];
      console.log("group:"+group);
      console.log(group);
      console.log(JSON.stringify(group));

      //to make sure if parent isn't checked and a permission is checked that the parent is made true = CHECKED;
      var anyPermissionsChecked = false;


      for (var i = 0; i < group.length; i++) {
        if(group[i].checked == true)
        updateString.push(group[i].value)
        anyPermissionsChecked = true;
      }
      var updateStringJoined = updateString.join()
      console.log("updateStringJoined: "+updateStringJoined);
      updateStringJoinedFinal = "["+updateStringJoined+"]"

      var a={}; //current
      var b=a; //gobal

      for (var i = 0; i < fixedPath.length; i++) {

        if(i != fixedPath.length - 1){
        a[fixedPath[i]]={};
        a=a[fixedPath[i]];

        }else{
          console.log('last step');
          a[fixedPath[i]]=updateString;
        }
      }

      var finalForm = JSON.stringify(b);
      console.log('finalForm: '+finalForm);

      //after all permissions processed the var anyPermissionsChecked will be up to date.
      if(anyPermissionsChecked == true){
      document.getElementById(path).checked = true;
      }

        xmlhttp2.open("POST", "updateJsonArray", true);
        xmlhttp2.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
        xmlhttp2.send('finalJsonUpdateString='+finalForm+'&personSelected='+personSelected);

        xmlhttp2.onreadystatechange = function() {
          if(xmlhttp2.readyState == 4 && xmlhttp2.status == 200){
            processResults();
          }
        }

        function processResults() {
          if (xmlhttp2.readyState == 4 && xmlhttp2.status == 200) {
         }
        }

    }



    var xmlhttp3;

    if (window.XMLHttpRequest) {
      xmlhttp3 = new XMLHttpRequest();/*alert("Not Microsoft");*/
    } else {
      xmlhttp3 = new ActiveXObject("Microsoft.XMLHTTP");
      alert("javascript not found, falling back to activex");
    }



    function updateJsonFullTreeArray(path){
      console.log("path"+path);
      var fixedPath = path.split('.');
      console.log("fixedPath"+fixedPath);

      var personSelected = document.getElementById('peopleList').value;
      var group = document.getElementsByName(path);
      var updateString = [];
      console.log("group:"+group);
      console.log(group);
      console.log(JSON.stringify(group));

      var toBeMadeNullList = [];

      for (var i = 0; i < group.length; i++) {
        if(group[i].checked == true){
        updateString.push(group[i].value);
        }else{
        updateString.push(group[i].value);
        toBeMadeNullList.push(group[i].value);
        }
      }
      //Call cleaner function and pass list of checkoxes to be cleaned from it.
      //toBeMadeNullList
      console.log("toBeMadeNullList: "+toBeMadeNullList);
//need to isolate this. it works once but it mucks up the status and saves too much.

      for (var k = 0; k < toBeMadeNullList.length; k++) {
        var departmentToUncheck = document.getElementsByName(path+'.'+toBeMadeNullList[k]);
        console.log("path+'.'+toBeMadeNullList[k]: "+path+'.'+toBeMadeNullList[k]);
        console.log("departmentToUncheck: "+ departmentToUncheck);
        console.log(departmentToUncheck);
        for (var h = 0; h < departmentToUncheck.length; h++) {
          if(departmentToUncheck[h].checked = true){
            //This should change the checked status and change the visual graphic to unchecked, but also will do ajax saves to update the records.
            departmentToUncheck[h].checked = false;
          }
        }
      }
      // need to check for the if a permission is checked without the parent targetobjects key checked. (the permission save handles the json fine, just need to update user interface.)
      //has to be in the other json save on click.



      var departmentGroups = {};
      console.log("updateString:"+updateString);
      for (var i = 0; i < updateString.length; i++) {
        console.log("updateString[i]: "+updateString[i]+ " "+i);

        var departmentGroup = document.getElementsByName(path+'.'+updateString[i]);
        var permissionsChecked = [];
        console.log("departmentGroup: "+departmentGroup);
        console.log("updateString[i]: " + updateString[i]);
        console.log("toBeMadeNullList: "+toBeMadeNullList);
        //check for keys to be made null
        if(toBeMadeNullList.includes(updateString[i])){
          console.log("toBeMadeNullList includes "+updateString[i]);
          departmentGroups[updateString[i]] = null;
        }else{
          for (var j = 0; j < departmentGroup.length; j++) {
            if(departmentGroup[j].checked == true){
              permissionsChecked.push(departmentGroup[j].value);
            }
          departmentGroups[updateString[i]] = permissionsChecked;
          }
        }
      }
      console.log("departmentGroups: "+ JSON.stringify(departmentGroups));

      var fullDepartmentsAndGroupsUpdateString = departmentGroups;

      var updateStringJoined = updateString.join()
      console.log("updateStringJoined: "+updateStringJoined);
      updateStringJoinedFinal = "["+updateStringJoined+"]"

      var a={}; //current
      var b=a; //gobal

      for (var i = 0; i < fixedPath.length; i++) {

        if(i != fixedPath.length - 1){
        a[fixedPath[i]]={};
        a=a[fixedPath[i]];

        }else{
          console.log('last step');
          a[fixedPath[i]] = fullDepartmentsAndGroupsUpdateString;
        }
      }

      var finalForm = JSON.stringify(b);
      console.log('finalForm: '+finalForm);



        xmlhttp3.open("POST", "updateJsonArray", true);
        xmlhttp3.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
        xmlhttp3.send('finalJsonUpdateString='+finalForm+'&personSelected='+personSelected);

        xmlhttp3.onreadystatechange = function() {
          if(xmlhttp3.readyState == 4 && xmlhttp3.status == 200){
            processResults();
          }
        }

        function processResults() {
          if (xmlhttp3.readyState == 4 && xmlhttp3.status == 200) {
         }
        }

    }



        var xmlhttp4;

        if (window.XMLHttpRequest) {
          xmlhttp4 = new XMLHttpRequest();/*alert("Not Microsoft");*/
        } else {
          xmlhttp4 = new ActiveXObject("Microsoft.XMLHTTP");
          alert("javascript not found, falling back to activex");
        }


//I think all should follow this format - it limits the size of the json string sent to mergepatch to only the data key and it's children permissions and not the entire data key arrary like the others - That was done not fully understanding mergepatch limits and interactions.
        function updateJsonParentandChildrenArray(path){
          // path is the parent's input field ID
          // path is also the childrens name of checkboxes.
          console.log("path"+path);
          var fixedPath = path.split('.');

          //removing one layer of the path to save proper in the json

          console.log("fixedPath"+fixedPath);
          var jsonKey = fixedPath[fixedPath.length-1]
          fixedPath.pop();
          var personSelected = document.getElementById('peopleList').value;


          var parentElement = document.getElementById(path);
          var childrenElements = document.getElementsByName(path);

          //cleaning and settings checkboxes.
          for (var k = 0; k < childrenElements.length; k++) {
            if(parentElement.checked == false){
              childrenElements[k].checked = false;
            }
          }

          var parentUpdateString = {};
          var childUpdateArray = [];
          //look for checked true and build update string for save.
          if(parentElement.checked == true){


            for (var l = 0; l < childrenElements.length; l++) {
              if(childrenElements[l].checked == true){
                childUpdateArray.push(childrenElements[l].value);
              }

            }
            parentUpdateString[jsonKey] = childUpdateArray;

          }else{
            parentUpdateString[jsonKey] = null;
          }

          console.log("parentUpdateString: "+ JSON.stringify(parentUpdateString));

          var a={}; //current
          var b=a; //gobal

          for (var i = 0; i < fixedPath.length; i++) {

            if(i != fixedPath.length - 1){
            a[fixedPath[i]]={};
            a=a[fixedPath[i]];

            }else{
              console.log('last step');
              a[fixedPath[i]] = parentUpdateString;
            }
          }

          var finalForm = JSON.stringify(b);
          console.log('finalForm: '+finalForm);

            xmlhttp3.open("POST", "updateJsonArray", true);
            xmlhttp3.setRequestHeader("Content-type",
                "application/x-www-form-urlencoded");
            xmlhttp3.send('finalJsonUpdateString='+finalForm+'&personSelected='+personSelected);

            xmlhttp3.onreadystatechange = function() {
              if(xmlhttp3.readyState == 4 && xmlhttp3.status == 200){
                processResults();
              }
            }

            function processResults() {
              if (xmlhttp3.readyState == 4 && xmlhttp3.status == 200) {
             }

            }

          }









    </script>
  </head>
  <body>
    <g:render template="teambuilderNav"/>
    <div id="mainContent" style="margin:0px;width:85%;">

    <h1>Person Permissions</h1>

    <h2>Select a person to view/grant/remove permissions</h2>
     <select id="peopleList" onchange="personSelected()">
       <option value=""></option>
       <g:each var="person" in="${peopleList}">
        <option value="${person.pidm}">
          <g:if test="${person.pref_first_name != null}">${person.pref_first_name} ${person.last_name}</g:if><g:else>${person.first_name} ${person.last_name}</g:else>
        </option>
       </g:each>
     </select>

    <div id="permissionsContainer" style="display:none">
    <h2>Select a Application to view its permissions.</h2>

    <label for="applicationSelected">Application</label> <select id="applicationSelected" onchange="fetchActions()">
      <option value=""></option>
      <g:each var="app" in="${applicationsList}">
        <option value="${app.id}">${app.applicationName}: ${app.applicationDescription}</option>
      </g:each>
    </select>
  </div>

    <!--Check for view privilege-->
  <div id="actionsContainer">

  </div>

    <!--Check for create privilege-->

    <div id="inputForm" class="inputForm" style="display:none;">
      <label for="roleName">Role Name</label> <input id="roleName" type="text" name="" value=""><br>
      <label for="roleDescription">Role Description</label> <textarea id="roleDescription" name="name" rows="4" cols="40"></textarea><br>
      <label for="roleOrder">Role Order</label> <input type="number" id="roleOrder" type="text" name="" value="" min="0">
      <br>
      <button type="button" name="button" onclick="submitRole()">Submit Role</button>
    </div>





    </div>
  </body>
</html>
