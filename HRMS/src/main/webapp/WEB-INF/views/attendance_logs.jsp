<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Attendance Log</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            .container {
                max-width: 1000px;
                margin: auto;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
            }
            .actions {
                margin: 15px 0;
            }
            .btn {
                padding: 6px 12px;
                cursor: pointer;
                border: none;
            }
            .btn-export {
                background: #007bff;
                color: #fff;
            }
            .btn-pdf {
                background: #dc3545;
                color: #fff;
            }
            .btn-claim {
                background: #ffc107;
                color: #000;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Attendance Log</h2>

            <!-- Nút Export -->
            <div class="actions">
                <form action="exportAttendance" method="get" style="display:inline;">
                    <input type="hidden" name="format" value="excel"/>
                    <button type="submit" class="btn btn-export">Export Excel</button>
                </form>
                <form action="exportAttendance" method="get" style="display:inline; margin-left:10px;">
                    <input type="hidden" name="format" value="pdf"/>
                    <button type="submit" class="btn btn-pdf">Export PDF</button>
                </form>
            </div>

            <!-- Bảng Attendance Log -->
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Ngày/Giờ</th>
                        <th>Check Type</th>
                        <th>Ghi chú</th>
                        <th>Kháng nghị</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="log" items="${logs}">
                        <tr>
                            <td>${log.userId}</td>
                            <td>${log.checkedAt}</td>
                            <td>${log.checkType}</td>
                            <td>${log.note}</td>
                            <td>
                                <form action="appeal" method="post">
                                    <input type="hidden" name="logId" value="${log.id}"/>
                                    <button type="submit" class="btn btn-claim">Kháng nghị</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
