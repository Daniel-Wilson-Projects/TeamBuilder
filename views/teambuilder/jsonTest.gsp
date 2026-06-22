<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name = "Layout" content="HeaderFooterWrapper">
    <title>Roles</title>
    <style media="screen">
      .inputForm{ display:block;float:left;}
      .inputForm label{ display:block;float:left;}
      #mainContent{float:left;display:block;}
    </style>
    <script type="text/javascript">
    var items = ${raw(items)};








  //  const myObj1 = JSON.parse(items);

    const myJSON = '{"name":"John", "age":30, "car":null}';
    const myObj = JSON.parse(myJSON);
    x = myObj.name;
    </script>
  </head>
  <body>
    <g:render template="teambuilderNav"/>
    <div id="mainContent">
${items2}

    </div>
  </body>
</html>
