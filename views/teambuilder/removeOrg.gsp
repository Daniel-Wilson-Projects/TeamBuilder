<table>
  <thead>
    <tr>
      <th>Example Access Checks</th>
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
          Createable
          </g:if>

          <g:if test="${permissionsPidmList.readableCreatorPidms.contains(org.CREATOR_PIDM)}">
          Readable
          </g:if>
          <g:if test="${permissionsPidmList.updateableCreatorPidms.contains(org.CREATOR_PIDM)}">
          Updateable
          </g:if>
          <g:if test="${permissionsPidmList.deleteableCreatorPidms.contains(org.CREATOR_PIDM)}"><button onclick="removeOrg(${org.ID})">Remove Org</button>
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
