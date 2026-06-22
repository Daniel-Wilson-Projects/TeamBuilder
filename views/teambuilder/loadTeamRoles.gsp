<g:if test="${selectedPidm != ''}">
<g:each var="role" in="${teamRoles}">
<label for="${role.roleName}">${role.roleName}</label><input type="checkbox" id="${role.roleName}" name="${role.roleName}" value="${role.id}" onchange="updateAssignedRole('${role.roleName}',${role.id},${selectedPidm})" <g:each var="pRole" in="${selectedPersonsRoles}"><g:if test="${role.id.toString() == pRole.tbRolesId.toString()}">checked</g:if></g:each>><br>
</g:each>
</g:if>
