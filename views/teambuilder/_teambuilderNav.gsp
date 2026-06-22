<nav class="globalNavOff" id="globalNav">

<div id="Home">
  <a href="https://wp.missouristate.edu/">
    <span></span><span>Home</span>
  </a>
</div>

<div class="skip-nav"><a href="#MainContent" class="item hidden">Skip to content column</a></div>

<ul>
    <li>Welcome, ( <sec:username/> ) <a id="logout" href="${createLink(controller: 'logout')}">Logout</a><sec:ifNotLoggedIn>Please Log In</sec:ifNotLoggedIn></li>
    <li><strong><p>Team Builder</p></strong></li>

<sec:ifAnyGranted roles="ROLE_ADMIN">
    <li><a href='${createLink(action:'organizations')}'>Organizations</a></li>
</sec:ifAnyGranted>


<sec:ifAnyGranted roles="ROLE_ADMIN">
    <li><a href='${createLink(action:'roles')}'>Roles</a></li>
</sec:ifAnyGranted>

<sec:ifAnyGranted roles="ROLE_ADMIN">
    <li><a href='${createLink(action:'buildTeam')}'>Build Team</a></li>
</sec:ifAnyGranted>

<sec:ifAnyGranted roles="ROLE_ADMIN">
    <li><a href='${createLink(action:'applications')}'>Applications</a></li>
</sec:ifAnyGranted>

<sec:ifAnyGranted roles="ROLE_ADMIN">
    <li><a href='${createLink(action:'applicationActions')}'>Application Actions</a></li>
</sec:ifAnyGranted>

<sec:ifAnyGranted roles="ROLE_ADMIN">
    <li><a href='${createLink(action:'personPermissions')}'>Person Permissions</a></li>
</sec:ifAnyGranted>

<sec:ifAnyGranted roles="ROLE_ADMIN">
    <li><a href='${createLink(action:'rolePermissions')}'>Role Permissions</a></li>
</sec:ifAnyGranted>
<!--
<sec:ifAnyGranted roles="ROLE_ADMIN">
    <li><a href='${createLink(action:'transformPermissions')}'>Transform Permissions</a></li>
</sec:ifAnyGranted>
-->
</ul>

<!--
<h2>Additional Links</h2>
    <ul>
      <li><a href="https://www.examplelink.edu/bog/">Example</a></li>
      <li><a href="https://www.examplelink.edu/bog/">Example</a></li>
      <li><a href="https://www.examplelink.edu/bog/">Example</a></li>
      <li><a href="https://www.examplelink.edu/bog/">Example</a></li>
      <li><a href="https://www.examplelink.edu/bog/">Example</a></li>
    </ul>

  -->
</nav>
