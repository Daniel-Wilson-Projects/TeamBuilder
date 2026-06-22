
<table style="width:100%">
  <thead>
    <tr>
      <th>Action Name/Web url</th>
      <th style="width:">Action Description</th>
      <th>Deparment - Target Object/Keys</th>
      <th>Division - Target Object/Keys</th>
      <th>Person - Target Object/Keys</th>
    </tr>
  </thead>
  <tbody>
    <g:each var="action" in="${applicationsActions}">
    <tr>
      <td style="width:5%;">${action.actionName}</td>
      <g:set var="proxey" value="${applicationSelected}" />
      <g:set var="proxeyActionName" value="${action.actionName.toString()}" />

      <td style="width:10%;">${action.actionDescription}</td>

      <td style="width:20%">
        <div class="container" style="width:100%;margin:0px;">

          <table class="subTable" style="margin: 0px;width: 100%;border-collapse: collapse;">
          <thead>
            <tr>
              <th style="width:20%;"></th>
              <th style="width:20%;"></th>
              <th style="width:20%;"></th>
              <th style="width:20%;"></th>
              <th style="width:20%;"></th>
            </tr>
          </thead>
          <tbody>

        <g:each var="department" in="${departmentList}" status="index">
        <tr>

        <td>
        <label for="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}">${department.STVDEPT_CODE}</label><input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}" name="targetObjects.${applicationSelected}.${action.actionName}.departments" value="${department.STVDEPT_CODE}" onchange="updateJsonParentandChildrenArray('targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}')"
       <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('departments')?.getAt(department.STVDEPT_CODE)?.isEmpty()  == false || groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('departments')?.getAt(department.STVDEPT_CODE) != null}">checked</g:if>>
        </td>
        <td>
       <label for="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}create">create</label>
         <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}create" name="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}" value="create" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}')"

         <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('departments')?.getAt(department.STVDEPT_CODE)}">
         <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('departments')?.getAt(department.STVDEPT_CODE)}.contains('create')">
         checked</g:if></g:if> >
        </td>


        <td>
         <label for="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}read">read</label>
         <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}read" name="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}" value="read" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}')"
         <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('departments')?.getAt(department.STVDEPT_CODE)}">
         <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('departments')?.getAt(department.STVDEPT_CODE).contains('read')}">
         checked</g:if></g:if> >
        </td>
        <td>
         <label for="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}update">update</label>
         <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}update" name="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}" value="update" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}')"
         <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('departments')?.getAt(department.STVDEPT_CODE)}">
         <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('departments')?.getAt(department.STVDEPT_CODE).contains('update')}">
         checked</g:if></g:if> >
        </td>
        <td>
         <label for="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}delete">delete</label>
         <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}delete" name="targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}" value="delete" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.departments.${department.STVDEPT_CODE}')"
         <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('departments')?.getAt(department.STVDEPT_CODE)}">
         <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('departments')?.getAt(department.STVDEPT_CODE).contains('delete')}">
         checked</g:if></g:if>>
        </td>
      </tr>
        </g:each>
      </tbody>
      </table>

        </div>
      </td>
      <td style="width:20%">
        <div class="container" style="width:100%;margin:0px;">
          <table class="subTable" style="margin: 0px;width: 100%;border-collapse: collapse;">
          <thead>
            <tr>
              <th style="width:20%;"></th>
              <th style="width:20%;"></th>
              <th style="width:20%;"></th>
              <th style="width:20%;"></th>
              <th style="width:20%;"></th>
            </tr>
          </thead>
          <tbody>


          <g:each var="division" in="${divisionList}" status="index">
          <tr>


        <td>
        <label for="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}">${division.STVDIVS_CODE} </label><input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}" name="targetObjects.${applicationSelected}.${action.actionName}.divisions" value="${division.STVDIVS_CODE}" onchange="updateJsonParentandChildrenArray('targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}')"
       <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('divisions')?.getAt(division.STVDIVS_CODE)?.isEmpty()  == false || groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('divisions')?.getAt(division.STVDIVS_CODE) != null}">checked</g:if>>
       </td>
       <td>
       <label for="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}create">create</label>
       <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}create" name="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}" value="create" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}')"
       <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('divisions')?.getAt(division.STVDIVS_CODE)}">
       <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('divisions')?.getAt(division.STVDIVS_CODE).contains('create')}">
       checked</g:if></g:if>>
       </td>

       <td>
       <label for="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}read">read</label>
       <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}read" name="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}" value="read" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}')"
       <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('divisions')?.getAt(division.STVDIVS_CODE)}">
       <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('divisions')?.getAt(division.STVDIVS_CODE).contains('read')}">
       checked</g:if></g:if>>
       </td>

       <td>
       <label for="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}update">update</label>
       <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}update" name="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}" value="update" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}')"
       <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('divisions')?.getAt(division.STVDIVS_CODE)}">
       <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('divisions')?.getAt(division.STVDIVS_CODE).contains('update')}">
       checked</g:if></g:if>>
       </td>

       <td>
       <label for="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}delete">delete</label>
       <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}delete" name="targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}" value="delete" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.divisions.${division.STVDIVS_CODE}')"
       <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('divisions')?.getAt(division.STVDIVS_CODE)}">
       <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('divisions')?.getAt(division.STVDIVS_CODE).contains('delete')}">
       checked</g:if></g:if>>
      </td>

      </tr>

        </g:each>
      </tbody>
      </table>

        </div>
      </td>
      <td style="width:25%">
        <div class="container" style="width:100%;margin:0px;">

          <table class="subTable" style="margin: 0px;width: 100%;border-collapse: collapse;">
          <thead>
            <tr>
              <th style="width:30%;"></th>
              <th style="width:17.5%;"></th>
              <th style="width:17.5%;"></th>
              <th style="width:17.5%;"></th>
              <th style="width:17.5%;"></th>
            </tr>
          </thead>
          <tbody>


          <g:each var="person" in="${peopleList}" status="index">
          <tr>
          <td>
            <label for="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}"> <g:if test="${person.pref_first_name != null}">${person.pref_first_name} ${person.last_name}</g:if><g:else>${person.first_name} ${person.last_name}</g:else></label><input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}" name="targetObjects.${applicationSelected}.${action.actionName}.population" value="${person.pidm}" onchange="updateJsonParentandChildrenArray('targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}')"
            <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('population')?.getAt(person.pidm.toString())?.isEmpty() == false || groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('population')?.getAt(person.pidm.toString()) != null}">checked</g:if>>
          </td>
          <td>
            <label for="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}create">create</label>
            <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}create" name="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}" value="create" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}')"
            <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('population')?.getAt(person.pidm.toString())}">
            <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('population')?.getAt(person.pidm.toString()).contains('create')}">
            checked</g:if></g:if>>
          </td>
          <td>
            <label for="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}read">read</label>
            <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}read" name="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}" value="read" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}')"
            <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('population')?.getAt(person.pidm.toString())}">
            <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('population')?.getAt(person.pidm.toString()).contains('read')}">
            checked</g:if></g:if>>
          </td>
          <td>
            <label for="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}update">update</label>
            <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}update" name="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}" value="update" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}')"
            <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('population')?.getAt(person.pidm.toString())}">
            <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('population')?.getAt(person.pidm.toString()).contains('update')}">
            checked</g:if></g:if>>
          </td>
          <td>
            <label for="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}delete">delete</label>
            <input type="checkbox" id="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}delete" name="targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}" value="delete" onchange="updateJsonArray('targetObjects.${applicationSelected}.${action.actionName}.population.${person.pidm}')"
            <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('population')?.getAt(person.pidm.toString())}">
            <g:if test="${groovyPermissionsJson?.getAt('targetObjects')?.getAt(applicationSelected)?.getAt(action.actionName)?.getAt('population')?.getAt(person.pidm.toString()).contains('delete')}">
            checked</g:if></g:if>>
          </td>
          </tr>
           </g:each>
         </tbody>
        </table>


        </div>
      </td>
    </tr>
    </g:each>
  </tbody>
</table>
