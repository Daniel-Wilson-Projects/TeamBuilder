<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <g:each var="action" in="${applicationsActionsList}">
    <tr>
    <td>${action.ACTION_NAME}</td>
    <td>${action.ACTION_DESCRIPTION}</td>
    </tr>
    </g:each>  
  </tbody>
</table>
