<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">

    <title>View Teams</title>


  </head>
  <body>
    <g:render template="teambuilderNav"/>

    <table>
      <thead>
        <tr>
          <th>Your Access</th>
          <th>Organization</th>
          <th>Description</th>
          <th>Owner</th>
          <th>Activity Date</th>
        </tr>
      </thead>
      <tbody>
        <g:each var="team" in="${teams}">
        <tr>
          <td>
          <g:if test="${team.owner}">

          </g:if>
          </td>
          <td>${team.organization}</td>
          <td>${team.organizationDesc}</td>
          <td>${team.owner}</td>
          <td>${team.activityDate}</td>
        </tr>
        </g:each>
      </tbody>
    </table>

  </body>
</html>
