<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name = "Layout" content="HeaderFooterWrapper">
    <title>Applications</title>
    <script type="text/javascript">
    var xmlhttp;

    if (window.XMLHttpRequest) {
    	xmlhttp = new XMLHttpRequest();/*alert("Not Microsoft");*/
    } else {
    	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    	alert("javascript not found, falling back to activex");
    }


    function submitApp(){


        var applicationName = document.getElementById('applicationName').value;
        var applicationDescription = document.getElementById('applicationDescription').value;

        console.log("applicationName"+applicationName);
        console.log("applicationDescription"+applicationDescription);
        xmlhttp.open("POST", "submitApplication", true);
        xmlhttp.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");

        xmlhttp.send('applicationName='+applicationName+'&applicationDescription='+applicationDescription);

        xmlhttp.onreadystatechange = function() {
          if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
            processResults();
          }
          }

        function processResults() {
          if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            document.getElementById('appContainer').innerHTML = xmlhttp.responseText;
          }
        }




    }


    </script>
  </head>
  <body>
    <g:render template="teambuilderNav"/>
    <div class="" style="width:85%;float:left;">


    <h1>Applications</h1>

    <!--Check for view privilege-->
  <div id="appContainer">
    <table>
      <thead>
        <tr>
          <th>Application Name</th>
          <th>Application Description</th>
          <th>Activity Date</th>
        </tr>
      </thead>
      <tbody>
        <g:each var="app" in="${applicationsList}">
          <tr>
            <td>${app.APPLICATION_NAME}</td>
            <td>${app.APPLICATION_DESCRIPTION}</td>
            <td><g:formatDate format="yyyy-MM-dd" date="${app.ACTIVITY_DATE}"/></td>
          </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  <br>
    <!--Check for create privilege-->
    <label for="applicationName">Application Name</label><br><input id="applicationName" type="text" name="" value=""><br>
    <label for="applicationDescription">Application Description</label><br><textarea id="applicationDescription" name="name" rows="4" cols="40"></textarea><br>




    <br>
    <button type="button" name="button" onclick="submitApp()">Submit Application</button>

</div>
  </body>
</html>
