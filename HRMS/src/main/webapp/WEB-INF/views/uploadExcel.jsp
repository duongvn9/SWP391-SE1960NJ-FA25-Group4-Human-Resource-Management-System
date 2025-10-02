<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Import Attendance</title>
  </head>
  <body>
    <h2>Upload Attendance Excel File</h2>

    <form action="uploadExcel" method="post" enctype="multipart/form-data">
      <input type="file" name="excelFile" accept=".xlsx,.xls" required />
      <button type="submit">Upload</button>
    </form>

    <p style="color: green">${message}</p>
  </body>
</html>
