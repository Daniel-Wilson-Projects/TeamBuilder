<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name = "Layout" content="HeaderFooterWrapper">
    <title>Update Role</title>
    <script type="text/javascript">
    var xmlhttp;

    if (window.XMLHttpRequest) {
    	xmlhttp = new XMLHttpRequest();/*alert("Not Microsoft");*/
    } else {
    	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    	alert("javascript not found, falling back to activex");
    }


    function updateRole(){

        var roleName = document.getElementById('roleName').value;
        var roleDescription = document.getElementById('roleDescription').value;
        var roleId = "${viewRole[0].surId}"
        console.log("roleName"+roleName);
        console.log("roleDescription"+roleDescription);
        xmlhttp.open("POST", "updateRole", true);
        xmlhttp.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");

        xmlhttp.send('roleName='+roleName+'&roleDescription='+roleDescription+"&roleId="+roleId);

              xmlhttp.onreadystatechange = function() {
          if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
            processResults();
          }
          }

        function processResults() {
          if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            document.getElementById('message').innerHTML = xmlhttp.responseText;
          }
          }

        }


    </script>
  </head>
  <body>
    <g:render template="teambuilderNav"/>
    <div class="" style="width:85%;float:left;">


    <h1>Update Role</h1>


    <!--Check for create privilege-->
    <label for="roleName">Role Name</label><br><input id="roleName" type="text" name="" value="${viewRole[0].roleName}"><br>
    <label for="roleDescription">Role Description</label><br><textarea id="roleDescription" name="name" rows="4" cols="40" value="${viewRole[0].roleDescription}">${viewRole[0].roleDescription}</textarea><br>


    <br>
    <button type="button" name="button" onclick="updateRole()">Update Role</button>
    <div id="message"></div>
</div>
  </body>
</html>
