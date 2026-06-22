<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">

    <title>Create Team</title>
    <style media="screen">
    body {
    font-family: Arial;
}

ul.tree li {
    list-style-type: none;
    position: relative;
}

ul.tree li ul {
    display: none;
}

ul.tree li.open > ul {
    display: block;
}

ul.tree li a {
    color: black;
    text-decoration: none;
}

ul.tree li a:before {
    height: 1em;
    padding:0 .1em;
    font-size: .8em;
    display: block;
    position: absolute;
    left: -1.3em;
    top: .2em;
}

ul.tree li > a:not(:last-child):before {
    content: '+';
}

ul.tree li.open > a:not(:last-child):before {
    content: '-';
}
.tree{ display:grid;}
ul li {display:block;

}
    </style>

  </head>
  <body>
    <g:render template="teambuilderNav"/>

    <!--grantee, granteeTitle, grantor, grantorTitle, organization, organizationDesc, application, grantedObject, grantable, privilege-->



<!-- Reference
    <ul class="tree">
  <li><a href="#">Part 1</a>
    <ul>
      <li><a href="#">Item A</a>
        <ul>
          <li>Sub-item 1</li>
          <li>Sub-item 2</li>
          <li>Sub-item 3</li>
        </ul>
      </li>
      <li><a href="#">Item B</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item C</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item D</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item E</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
    </ul>
  </li>

  <li><a href="#">Part 2</a>
    <ul>
      <li><a href="#">Item A</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item B</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item C</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item D</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item E</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
    </ul>
  </li>

  <li><a href="#">Part 3</a>
    <ul>
      <li><a href="#">Item A</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item B</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item C</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item D</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
      <li><a href="#">Item E</a>
        <ul>
          <li><a href="#">Sub-item 1</a></li>
          <li><a href="#">Sub-item 2</a></li>
          <li><a href="#">Sub-item 3</a></li>
        </ul>
      </li>
    </ul>
  </li>
</ul>
-->
    <script type="text/javascript">
    var tree = document.querySelectorAll('ul.tree a:not(:last-child)');
    for(var i = 0; i < tree.length; i++){
        tree[i].addEventListener('click', function(e) {
            var parent = e.target.parentElement;
            var classList = parent.classList;
            if(classList.contains("open")) {
                classList.remove('open');
                var opensubs = parent.querySelectorAll(':scope .open');
                for(var i = 0; i < opensubs.length; i++){
                    opensubs[i].classList.remove('open');
                }
            } else {
                classList.add('open');
            }
        });
    }

    //refrence for when I need to start adding saved data to the list.
    function function1() {
      var ul = document.getElementById("list");
      var li = document.createElement("li");
      li.appendChild(document.createTextNode("Four"));
      ul.appendChild(li);
    }


    </script>
  </body>
</html>
