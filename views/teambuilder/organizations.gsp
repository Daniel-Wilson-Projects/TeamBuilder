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


    function removeOrg(orgId){

      if(confirm("Are you sure? Deleting this organization will remove all of it's roles and remove it from all assigned users and remove this organizations hierarchy.")){

        console.log("confirm is true");

        xmlhttp1.open("POST", "removeOrg", true);
        xmlhttp1.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");

        xmlhttp1.send('orgId='+orgId);

        xmlhttp1.onreadystatechange = function() {
          if(xmlhttp1.readyState == 4 && xmlhttp1.status == 200){
            processResults();
          }
          }

        function processResults() {
          if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
            document.getElementById('organizationsContainer').innerHTML = xmlhttp1.responseText;
          //  location.reload();
          }
          }
        }else{console.log('confirm is false');}
    }
    </script>
  </head>
  <body>
    <g:render template="teambuilderNav"/>
    <div class="" style="width:85%;float:left;">


    <h1>Organizations</h1>

    <!--Check for view privilege-->
  <div id="organizationsContainer">
    <table>
      <thead>
        <tr>
          <th>Access</th>
          <th>Organization</th>
          <th>Description</th>
          <th>Activity Date</th>
          <th>Creator</th>
        </tr>
      </thead>
      <tbody>
        <g:each var="org" in="${orgList}">
          <tr>
            <td>

              <g:if test="${permissionsPidmList.createableCreatorPidms.contains(org.CREATOR_PIDM)}">
      <!--      Createable -->
              </g:if>
              <g:if test="${permissionsPidmList.readableCreatorPidms.contains(org.CREATOR_PIDM)}">
      <!--      Readable -->
              </g:if>
              <g:if test="${permissionsPidmList.updateableCreatorPidms.contains(org.CREATOR_PIDM)}">
      <!--      Updateable -->
              <a href="<g:createLink action="viewOrg" params="[orgId:"${org.ID}"]"/>">Update</a>
              </g:if>
      <!--      Deleteable -->
              <g:if test="${permissionsPidmList.deleteableCreatorPidms.contains(org.CREATOR_PIDM)}"><button onclick="removeOrg('${org.ID}')">Remove Org</button>
              </g:if>
            </td>
            <td>${org.ORGANIZATION}</td>
            <td>${org.DESCRIPTION}</td>
            <td><g:formatDate format="yyyy-MM-dd" date="${org.ACTIVITY_DATE}"/></td>
            <td>${org.SPRIDEN_FIRST_NAME} ${org.SPRIDEN_LAST_NAME}</td>
          </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  <br>
    <!--Check for create privilege-->
    <label for="Organization">Organization</label><br><input id="Organization" type="text" name="" value=""><br>
    <label for="Description">Description</label><br><textarea id="Description" name="name" rows="4" cols="40"></textarea><br>

    <!--If proxeyList is 1 the user can only creat for themselves, so we hide the create as selector letting user detection on controller tag them as the creator-->

    <g:if test="${proxeyList.size() >= 1}">
    <label for="creatorPidm">Create As</label><br> <select id="creatorPidm"><g:each var="proxey" in="${proxeyList}"><option value="${proxey.SPRIDEN_PIDM}">${proxey.SPRIDEN_FIRST_NAME} ${proxey.SPRIDEN_LAST_NAME}</option>
    </g:each>
    </select>
    </g:if>


    <br>
    <button type="button" name="button" onclick="submitOrg()">Submit Organization</button>

</div>
  </body>
</html>
