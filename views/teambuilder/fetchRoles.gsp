<table>
  <thead>
    <tr>
      <th>Access</th>
      <th>Role Name</th>
      <th>Description</th>
      <th>Activity Date</th>
    </tr>
  </thead>
  <tbody>

    <g:if test="${rolesList != null}">

      <g:each var="role" in="${rolesList}">
        <tr>
          <td>
            <g:if test="${permissionsPidmList.createableCreatorPidms.contains(role.CREATOR_PIDM)}">
    <!--      Createable -->
            </g:if>

            <g:if test="${permissionsPidmList.readableCreatorPidms.contains(role.CREATOR_PIDM)}">
    <!--      Readable -->
            </g:if>
            <g:if test="${permissionsPidmList.updateableCreatorPidms.contains(role.CREATOR_PIDM)}">
    <!--      Updateable -->
            <a href="<g:createLink action="viewRole" params="[roleId:"${role.ID}"]"/>">Update</a>
            </g:if>
            <g:if test="${permissionsPidmList.deleteableCreatorPidms.contains(role.CREATOR_PIDM)}">
    <!--    Deleteable -->
            <button onclick="removeRole('${role.ID}')">Remove Role</button>
            </g:if>
          </td>
          <td>${role.ROLE_NAME}</td>
          <td>${role.ROLE_DESCRIPTION}</td>
          <td><g:formatDate format="yyyy-MM-dd" date="${role.ACTIVITY_DATE}"/></td>
        </tr>
      </g:each>

    </g:if>

  </tbody>
</table>
