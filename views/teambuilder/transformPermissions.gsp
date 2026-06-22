<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name = "Layout" content="HeaderFooterWrapper">
    <title>Organizations</title>
    <script type="text/javascript">
    var xmlhttp;

    if (window.XMLHttpRequest) {
    	xmlhttp = new XMLHttpRequest();/*alert("Not Microsoft");*/
    } else {
    	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    	alert("javascript not found, falling back to activex");
    }


    function submitOrg(){
      let text = "Are you sure? Removing an Organization will remove roles built and assigned to users, and delete it's hierarchy."
       if(confirm(text) == true){
        console.log('You pressed OK');
       }else{
         console.log('You canceled.');
       }

        var organization = document.getElementById('Organization').value;
        var description = document.getElementById('Description').value;
        var creatorPidm = document.getElementById('creatorPidm').value;

        console.log("organization"+organization);
        console.log("description"+description);
        xmlhttp.open("POST", "submitOrg", true);
        xmlhttp.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
        if(creatorPidm != null){
        xmlhttp.send('organization='+organization+'&description='+description+'&creatorPidm='+creatorPidm);
        }else{
        xmlhttp.send('organization='+organization+'&description='+description);
        }
        xmlhttp.onreadystatechange = function() {
          if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
            processResults();
          }
          }

        function processResults() {
          if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            document.getElementById('organizationsContainer').innerHTML = xmlhttp.responseText;
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


    function submitTransform(){

      if(confirm("Are you sure? Apply transforms from large groups or roles onto one person can take sometime to undo, applying to large groups even more time consuming.")){console.log("confirm is true");

        xmlhttp1.open("POST", "combineAndApply", true);
        xmlhttp1.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");

        var sourceRolesHolder = [];
        var sourceRoles = document.getElementById('sourceRoles').options;
        for (var i = 0; i < sourceRoles.length; i++) {
          if (sourceRoles[i].selected) {
            sourceRolesHolder.push(sourceRoles[i].value);
          }
        }

        var sourcePeopleHolder = [];
        var sourcePeople = document.getElementById('sourcePeople').options;
        for (var i = 0; i < sourcePeople.length; i++) {
          if (sourcePeople[i].selected) {
            sourcePeopleHolder.push(sourcePeople[i].value);
          }
        }

        var targetRolesHolder = [];
        var targetRoles = document.getElementById('targetRoles').options;
        for (var i = 0; i < targetRoles.length; i++) {
          if (targetRoles[i].selected) {
            targetRolesHolder.push(targetRoles[i].value);
          }
        }

        var targetPeopleHolder = [];
        var targetPeople = document.getElementById('targetPeople').options;
        for (var i = 0; i < targetPeople.length; i++) {
          if (targetPeople[i].selected) {
            targetPeopleHolder.push(targetPeople[i].value);
          }
        }

        console.log("sourceRolesHolder: "+ sourceRolesHolder);
        console.log("sourcePeopleHolder: "+ sourcePeopleHolder);
        console.log("targetRolesHolder: "+ targetRolesHolder);
        console.log("targetPeopleHolder: "+ targetPeopleHolder);


        xmlhttp1.send('sourceRoles='+sourceRolesHolder+'&sourcePeople='+sourcePeopleHolder+"&targetRoles="+targetRolesHolder+"&targetPeople="+targetPeopleHolder);

        xmlhttp1.onreadystatechange = function() {
          if(xmlhttp1.readyState == 4 && xmlhttp1.status == 200){
            processResults();
          }
          }

        function processResults() {
          if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
            document.getElementById('message').innerHTML = xmlhttp1.responseText;
          }
          }
        }else{console.log('confirm is false');}
    }
    </script>
  </head>
  <body>
    <g:render template="teambuilderNav"/>
<div class="" style="width:85%;float:left;">


    <h1>Transform Permissions</h1>
    <h2>Select any combination of roles and persons to combine their permissions</h2>
    <h3>This is intended to be used to take all the permissions a person has from roles and personal and merge them into a new role or make a person the same across all permissions the same. This is not to be used to assign permission. Please use roles first, then add personal permissions for minor additions.</h3>
    <h4>Note: Roles selected only move their permission set. Persons select only move their person permission set. Not all permissoins from roles assigned to that person also. If recreating a complicated permission set only use this page to 'copy' personal permission to a new user and assign their roles normally.</h4>
    <div id="sourceHolder" style="float:left;display:block;width:50%;margin:0px;">
    <h2>Sources</h2>
    <div id=roleHolder style="float:left;display:block;">
    <label for="sourceRoles">Roles</label><br>
    <select id="sourceRoles" multiple>
      <g:each var="role" in="${rolesList}">
      <option value="${role.surId}">${role.organization}: ${role.roleName}</option>
      </g:each>
    </select>
    </div>

    <div id=peopleHolder style="float:left;display:block;">
    <label for="sourcePeople">People</label><br>
    <select id="sourcePeople" multiple>
      <g:each var="person" in="${peopleList}">
      <option value="${person.PIDM}">${person.FIRST_NAME} ${person.LAST_NAME}</option>
      </g:each>
    </select>
    </div>
    </div>


    <div id="targetHolder" style="float:left;display:block;width:50%;margin:0px;">
    <h2>Targets</h2>
    <div id=troleHolder style="float:left;display:block;">
    <label for="targetRoles">Roles</label><br>
    <select id="targetRoles" multiple>
      <g:each var="role" in="${rolesList}">
      <option value="${role.surId}">${role.organization}: ${role.roleName}</option>
      </g:each>
    </select>
    </div>

    <div id=tpeopleHolder style="float:left;display:block;">
    <label for="targetPeople">People</label><br>
    <select id="targetPeople" multiple>
      <g:each var="person" in="${peopleList}">
      <option value="${person.PIDM}">${person.FIRST_NAME} ${person.LAST_NAME}</option>
      </g:each>
    </select>
    </div>
    </div>

    <button type="button" name="button" onclick="submitTransform()">Submit Transform</button>
    <div id="message"></div>
</div>
  </body>
</html>
