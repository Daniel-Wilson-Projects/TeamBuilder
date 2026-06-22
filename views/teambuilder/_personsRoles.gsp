<g:each var="pRoles" in="${personsRolesList}">
<g:if test="${pRoles.id == node.spriden_pidm}">${pRoles.ROLE_NAME}

</g:if>

</g:each>
