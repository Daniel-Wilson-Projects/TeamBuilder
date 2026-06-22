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

    var teamList = "";

    function loadTeam(){
        var selectedOrganization = document.getElementById('organizationSelected').value

        if(selectedOrganization != ""){

          AddTopNode.style.display = 'block';

        }else{
          AddTopNode.style.display = 'none';
          teamContainer.innerHTML = "";
        }

        if(selectedOrganization != ""){

        console.log("selectedOrganization"+selectedOrganization);

        xmlhttp.open("POST", "loadTeam", true);
        xmlhttp.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
        xmlhttp.send('selectedOrganization='+selectedOrganization);

        xmlhttp.onreadystatechange = function() {
          if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
            processResults();
          }
          }

        function processResults() {
          if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
          //  document.getElementById('teamContainer').innerHTML = xmlhttp.responseText;
              teamContainer.removeAttribute('data-processed');
              teamList = 'graph TD\n'+xmlhttp.responseText;
              teamContainer.innerHTML = teamList;
              teamContainer.classList.add("mermaid");
              console.log("teamList: "+teamList);

              mermaid.init(undefined,".mermaid");
        //    mermaid.render('thegraph',teamList,function(svgCode){teamContainer.innerHTML = svgCode});
              updateDesc();
          }
          }

    }



}


var xmlhttp5;

if (window.XMLHttpRequest) {
  xmlhttp5 = new XMLHttpRequest();/*alert("Not Microsoft");*/
} else {
  xmlhttp5 = new ActiveXObject("Microsoft.XMLHTTP");
  alert("javascript not found, falling back to activex");
}


function loadTeamRoles(){

    console.log('loadTeamRoles hit');

    var selectedOrganization = document.getElementById('organizationSelected').value
    console.log('selectedPidm: '+ selectedPidm);
    if(selectedOrganization != ""){

      AddTopNode.style.display = 'block';

    }else{
      AddTopNode.style.display = 'none';
    }

    if(selectedOrganization != ""){

    console.log("selectedOrganization"+selectedOrganization+"&selectedPidm="+selectedPidm);

    xmlhttp5.open("POST", "loadTeamRoles", true);
    xmlhttp5.setRequestHeader("Content-type",
        "application/x-www-form-urlencoded");
    xmlhttp5.send('selectedOrganization='+selectedOrganization+"&selectedPidm="+selectedPidm);

    xmlhttp5.onreadystatechange = function() {
      if(xmlhttp5.readyState == 4 && xmlhttp5.status == 200){
        processResults();
      }
      }

    function processResults() {
      if (xmlhttp5.readyState == 4 && xmlhttp5.status == 200) {
        document.getElementById('modalRoleSelect').innerHTML = xmlhttp5.responseText;

      }
      }

}



}

var xmlhttp6;

if (window.XMLHttpRequest) {
  xmlhttp6 = new XMLHttpRequest();/*alert("Not Microsoft");*/
} else {
  xmlhttp6 = new ActiveXObject("Microsoft.XMLHTTP");
  alert("javascript not found, falling back to activex");
}



function updateAssignedRole(roleNameId, selectedRole,selectedPidm){

    console.log('updateAssignedRole hit');
    //check if checked or unchecked to call a create or delete
    var checkmark = document.getElementById(roleNameId);
    var checkmarkStatus =''
    console.log(roleNameId);
    console.log(checkmarkStatus);
    console.log(selectedRole);
    if(checkmark.checked == true){
    console.log("checkmarkStatus is true");
    checkmarkStatus = 'true';
    }else{
    console.log("checkmarkStatus is else")
    checkmarkStatus = 'false';
    }

    xmlhttp6.open("POST", "updateAssignedRole", true);
    xmlhttp6.setRequestHeader("Content-type",
        "application/x-www-form-urlencoded");
    xmlhttp6.send('selectedRole='+selectedRole+"&selectedPidm="+selectedPidm+"&checkmarkStatus="+checkmarkStatus);

    xmlhttp6.onreadystatechange = function() {
      if(xmlhttp6.readyState == 4 && xmlhttp6.status == 200){
        processResults();
      }
      }

    function processResults() {
      if (xmlhttp6.readyState == 4 && xmlhttp6.status == 200) {
        document.getElementById('assignedRoleStatus').innerHTML = xmlhttp6.responseText;
        loadTeam()
      }
      }

}
  function updateDesc(){
    var a = document.getElementById('organizationSelected').value;
  //  console.log('a'+a);
    if(a != ""){
    var b = document.getElementById('org'+a).innerHTML;
    //console.log('b'+b);
    var c = document.getElementById('DisplayOrganizationDescription').innerHTML = b;
    }else{document.getElementById('DisplayOrganizationDescription').innerHTML = "";}

  }



    </script>
     <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
     <style media="screen">
     /* The Modal (background) */
.modal {
display: none; /* Hidden by default */
position: fixed; /* Stay in place */
z-index: 1; /* Sit on top */
left: 0;
top: 0;
width: 100%; /* Full width */
height: 100%; /* Full height */
overflow: auto; /* Enable scroll if needed */
background-color: rgb(0,0,0); /* Fallback color */
background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
background-color: #fefefe;
margin: 15% auto; /* 15% from the top and centered */
padding: 20px;
border: 1px solid #888;
width: 80%; /* Could be more or less, depending on screen size */
}

/* The Close Button */
.close {
color: #aaa;
float: right;
font-size: 28px;
font-weight: bold;
}

.close:hover,
.close:focus {
color: black;
text-decoration: none;
cursor: pointer;
}
/*
#mainContent  div  div  span {font-size:10px;}
#mainContent  div  div  {line-height: 1;}
*/
     </style>


  </head>
  <body>
    <g:render template="teambuilderNav"/>
    <div id="mainContent" style="width:85%;">

    <h1>Build Team</h1>

    <h2>Select a Organization to build it's team.</h2>

    <label for="organizationSelected">Organization</label> <select id="organizationSelected" onchange="loadTeam()">
      <option value=""></option>
      <g:each var="org" in="${orgList}">
        <option value="${org.id}">${org.organization}</option>
      </g:each>
    </select>
    <div id="DisplayOrganizationDescription" style="width:25%;"></div>
    <div id="orgDescList" style="display:none;">
      <g:each var="org" in="${orgList}">
        <div id="org${org.id}">${org.description}</div>
      </g:each>
    </div>

    <!-- Trigger/Open The Modal -->
<button id="AddTopNode" style="display:none;" onclick="addTopNode()">Add Top Node</button>

<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <span class="close" style="font-size:28px;" onclick="closeModal()">&times;</span>
    <span><strong>Assigned Person:</strong>
      <select id="modalSelectedPerson" onchange="updateNode()"><option value=""></option><g:each var="person" in="${peopleList}"><option value=${person.PIDM}>${person.FIRST_NAME} ${person.LAST_NAME}</option></g:each></select>
   </span><button onclick="removeNode()">Remove this Node</button><button onclick="addNode()">Add a Node</button><br><span><strong>Roles</strong></span><br><div id="assignedRoleStatus"></div>
   <span id="modalRoleSelect"></span>
  </div>

</div>

    <div id="teamContainer" >

    </div>



   <script>
  function testingInput(){
    console.log('testingInput hit');
  }
  mermaid.initialize({startOnLoad: false,securityLevel: 'loose'});
  </script>




    </div>
    <style media="screen">
      svg[id^="mermaid-"] { min-width: 200px; max-width: 100%; font-size: 20px; }
    </style>
    <script>
/*
    // Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on the button, open the modal
btn.onclick = function() {
 modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
 modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
 if (event.target == modal) {
   modal.style.display = "none";
 }
}
*/
function modelToggle(nodeId, nodePidm){
  selectedNode = nodeId;
  selectedPidm = nodePidm;
  console.log('nodeId: '+ nodeId);
  console.log('test');
  console.log('nodePidm: '+ nodePidm);
   myModal.style.display = "block";



  var selectedValue = document.getElementById('modalSelectedPerson').value = nodePidm;
  console.log("selectedValue: "+selectedValue);
  loadTeamRoles();
}

function closeModal(){
  myModal.style.display = "none";
  document.getElementById('modalRoleSelect').innerHTML = '';
}


var selectedNode = '';
var selectedPidm = '';



var xmlhttp1;

if (window.XMLHttpRequest) {
  xmlhttp1 = new XMLHttpRequest();/*alert("Not Microsoft");*/
} else {
  xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
  alert("javascript not found, falling back to activex");
}

function updateNode(){

      selectedPidm = document.getElementById('modalSelectedPerson').value;
      //selectedNode
      //document.getElementById('modalSelectedPerson').value
      var pidm = document.getElementById('modalSelectedPerson').value;

      xmlhttp1.open("POST", "tbUpdateNode", true);
      xmlhttp1.setRequestHeader("Content-type",
          "application/x-www-form-urlencoded");
      xmlhttp1.send('selectedNode='+selectedNode+'&selectedPidm='+pidm);

      xmlhttp1.onreadystatechange = function() {
        if(xmlhttp1.readyState == 4 && xmlhttp1.status == 200){
          processResults();
        }
        }

      function processResults() {
        if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
          teamContainer.innerHTML = '';
          teamContainer.removeAttribute('data-processed');
          teamList = 'graph TD\n'+xmlhttp1.responseText;
          teamContainer.innerHTML = teamList;
      //    teamContainer.classList.add("mermaid");
          console.log("teamList: "+teamList);

          mermaid.init(undefined,".mermaid");
          loadTeamRoles();
        }
        }
}

var xmlhttp2;

if (window.XMLHttpRequest) {
  xmlhttp2 = new XMLHttpRequest();/*alert("Not Microsoft");*/
} else {
  xmlhttp2 = new ActiveXObject("Microsoft.XMLHTTP");
  alert("javascript not found, falling back to activex");
}

function addNode(){

  xmlhttp2.open("POST", "tbAddNode", true);
  xmlhttp2.setRequestHeader("Content-type",
      "application/x-www-form-urlencoded");
  xmlhttp2.send('selectedNode='+selectedNode);

  xmlhttp2.onreadystatechange = function() {
    if(xmlhttp2.readyState == 4 && xmlhttp2.status == 200){
      processResults();
    }
    }

  function processResults() {
    if (xmlhttp2.readyState == 4 && xmlhttp2.status == 200) {


      teamContainer.innerHTML = '';
      teamContainer.removeAttribute('data-processed');
      teamList = 'graph TD\n'+xmlhttp2.responseText;
      teamContainer.innerHTML = teamList;
  //    teamContainer.classList.add("mermaid");
      console.log("teamList: "+teamList);

      mermaid.init(undefined,".mermaid");

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

function removeNode(){

  if(confirm("Removing this node will remove all nodes below it and strip this person and all persons assigned to nodes below them of their roles.")){


  xmlhttp3.open("POST", "tbRemoveNode", true);
  xmlhttp3.setRequestHeader("Content-type",
      "application/x-www-form-urlencoded");
  xmlhttp3.send('selectedNode='+selectedNode);

  xmlhttp3.onreadystatechange = function() {
    if(xmlhttp3.readyState == 4 && xmlhttp3.status == 200){
      processResults();
    }
    }

  function processResults() {
    if (xmlhttp3.readyState == 4 && xmlhttp3.status == 200) {
      teamContainer.innerHTML = '';
      teamContainer.removeAttribute('data-processed');
      teamList = 'graph TD\n'+xmlhttp3.responseText;
      teamContainer.innerHTML = teamList;
  //    teamContainer.classList.add("mermaid");
      console.log("teamList: "+teamList);

      mermaid.init(undefined,".mermaid");

    }
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

function addTopNode(){


  var selectedOrganization = document.getElementById('organizationSelected').value

  if(selectedOrganization != ""){

  xmlhttp4.open("POST", "tbAddTopNode", true);
  xmlhttp4.setRequestHeader("Content-type",
      "application/x-www-form-urlencoded");
  xmlhttp4.send('selectedOrganization='+selectedOrganization);

  xmlhttp4.onreadystatechange = function() {
    if(xmlhttp4.readyState == 4 && xmlhttp4.status == 200){
      processResults();
    }
    }

  function processResults() {
    if (xmlhttp4.readyState == 4 && xmlhttp4.status == 200) {
      teamContainer.innerHTML = '';
      teamContainer.removeAttribute('data-processed');
      teamList = 'graph TD\n'+xmlhttp4.responseText;
      teamContainer.innerHTML = teamList;
  //    teamContainer.classList.add("mermaid");
      console.log("teamList: "+teamList);

      mermaid.init(undefined,".mermaid");

    }
    }


  }

}

    </script>
  </body>
</html>
