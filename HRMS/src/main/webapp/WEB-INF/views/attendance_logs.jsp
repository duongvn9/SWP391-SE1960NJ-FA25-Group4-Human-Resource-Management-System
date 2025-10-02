<%@ page contentType="text/html;charset=UTF-8" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>Attendance Logs</title>
  </head>
  <body>
    <h2>Your Attendance Logs</h2>
    <table border="1">
      <tr>
        <th>Date & Time</th>
        <th>Type</th>
        <th>Source</th>
        <th>Note</th>
        <th>Period ID</th>
      </tr>
      <c:forEach var="log" items="${logs}">
        <tr>
          <td>${log.checkedAt}</td>
          <td>${log.checkType}</td>
          <td>${log.source}</td>
          <td>${log.note}</td>
          <td>${log.periodId}</td>
        </tr>
      </c:forEach>
    </table>
  </body>
</html>
