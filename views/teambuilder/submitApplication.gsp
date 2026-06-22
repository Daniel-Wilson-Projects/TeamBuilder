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
