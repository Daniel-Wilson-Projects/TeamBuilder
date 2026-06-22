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


        console.log("organization"+organization);
        console.log("roleName"+roleName);
        console.log("roleDescription"+roleDescription);

        xmlhttp.open("POST", "submitRole", true);
        xmlhttp.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
        xmlhttp.send('organization='+organization+'&roleName='+roleName+'&roleDescription='+roleDescription);

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


    function fetchRoles(){
        var organizationSelected = document.getElementById('organizationSelected').value;
        console.log(organizationSelected);
        console.log(organizationSelected.length);

        if(organizationSelected.length != 0){
          console.log('length is not == 0');
          document.getElementById('inputForm').style = "display:block;"

        xmlhttp1.open("POST", "fetchRoles", true);
        xmlhttp1.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
        xmlhttp1.send('organization='+organizationSelected);

        xmlhttp1.onreadystatechange = function() {
          if(xmlhttp1.readyState == 4 && xmlhttp1.status == 200){
            processResults();
          }
          }

        function processResults() {
          if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
            document.getElementById('rolesContainer').innerHTML = xmlhttp1.responseText;
          }
          }

        }else{
            document.getElementById('rolesContainer').innerHTML = "";
            document.getElementById('inputForm').style = "display:none;"

        }
    }



    var xmlhttp2;

    if (window.XMLHttpRequest) {
      xmlhttp2 = new XMLHttpRequest();/*alert("Not Microsoft");*/
    } else {
      xmlhttp2 = new ActiveXObject("Microsoft.XMLHTTP");
      alert("javascript not found, falling back to activex");
    }


    function removeRole(roleId){
      if(confirm("Are you sure? Deleting this role will unassign it from being to all users.")){console.log("confirm is true");
      var organizationSelected = document.getElementById('organizationSelected').value;
        xmlhttp2.open("POST", "removeRole", true);
        xmlhttp2.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");

        xmlhttp2.send('roleId='+roleId+'&organization='+organizationSelected);

        xmlhttp2.onreadystatechange = function() {
          if(xmlhttp2.readyState == 4 && xmlhttp2.status == 200){
            processResults();
          }
        }

        function processResults() {
          if (xmlhttp2.readyState == 4 && xmlhttp2.status == 200) {
            document.getElementById('rolesContainer').innerHTML = xmlhttp2.responseText;
          }
        }

      }else{console.log('confirm is false');}

    }

    function test(){
      if(confirm()){console.log("confirm is true");}else{console.log('confirm is false');}
    }
    </script>
  </head>
  <body>
    <g:render template="teambuilderNav"/>
    <div id="mainContent" style="width:85%;float:left;">

    <h1>Roles</h1>

    <h2>Select a Organization to view its roles.</h2>

    <label for="organizationSelected">Organization</label> <select id="organizationSelected" onchange="fetchRoles()" style="width:50%;">
      <option value=""></option>
      <g:each var="org" in="${orgList}">
        <option value="${org.id}">Owner: ${org.SPRIDEN_FIRST_NAME} ${SPRIDEN_LAST_NAME}: ${org.ORGANIZATION}: ${org.DESCRIPTION}</option>
      </g:each>
    </select>


    <!--Check for view privilege-->
  <div id="rolesContainer">

  </div>

    <!--Check for create privilege-->
    <br>
    <div id="inputForm" class="inputForm" style="display:none;">
      <label for="roleName">Role Name</label><br><input id="roleName" type="text" name="" value=""><br>
      <label for="roleDescription">Role Description</label><br><textarea id="roleDescription" name="name" rows="4" cols="40"></textarea><br>
      <button type="button" name="button" onclick="submitRole()">Submit Role</button>
      <button type="button" name="button" onclick="test()">Test</button>
    </div>





    </div>
  </body>
</html>
