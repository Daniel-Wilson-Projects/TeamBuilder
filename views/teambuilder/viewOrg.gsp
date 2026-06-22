<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name = "Layout" content="HeaderFooterWrapper">
    <title>Update Organization</title>
    <script type="text/javascript">
    var xmlhttp;

    if (window.XMLHttpRequest) {
    	xmlhttp = new XMLHttpRequest();/*alert("Not Microsoft");*/
    } else {
    	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    	alert("javascript not found, falling back to activex");
    }


    function updateOrg(){

        var organization = document.getElementById('Organization').value;
        var description = document.getElementById('Description').value;
        var orgId = "${viewOrg[0].surId}"
        console.log("organization"+organization);
        console.log("description"+description);
        xmlhttp.open("POST", "updateOrg", true);
        xmlhttp.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");

        xmlhttp.send('organization='+organization+'&description='+description+"&orgId="+orgId);

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


    <h1>Update Organization</h1>


    <!--Check for create privilege-->
    <label for="Organization">Organization</label><br><input id="Organization" type="text" name="" value="${viewOrg[0].organization}"><br>
    <label for="Description">Description</label><br><textarea id="Description" name="name" rows="4" cols="40" value="${viewOrg[0].description}">${viewOrg[0].description}</textarea><br>


    <br>
    <button type="button" name="button" onclick="updateOrg()">Update Organization</button>
    <div id="message"></div>
</div>
  </body>
</html>
