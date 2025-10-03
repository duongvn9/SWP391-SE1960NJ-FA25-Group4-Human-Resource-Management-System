<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Attendance Import</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            .container {
                max-width: 1000px;
                margin: auto;
            }
            .error {
                color: red;
                margin: 10px 0;
            }
            .message {
                color: green;
                margin: 10px 0;
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
                margin-top: 20px;
            }
            .btn {
                padding: 6px 12px;
                cursor: pointer;
            }
            .btn-upload {
                background: #007bff;
                color: #fff;
                border: none;
            }
            .btn-import {
                background: #28a745;
                color: #fff;
                border: none;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Attendance Import</h2>

            <!-- Form Upload Excel (Preview) -->
            <form action="uploadExcel" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="preview"/>
                <input type="file" name="excelFile" accept=".xls,.xlsx" required>
                <button type="submit" class="btn btn-upload">Upload & Preview</button>
            </form>

            <!-- Hiển thị thông báo -->
            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="error">${errorMessage}</div>
            </c:if>

            <!-- Preview dữ liệu sau khi upload -->
            <c:if test="${not empty previewData}">
                <h3>Preview Attendance Data</h3>
                <form action="uploadExcel" method="post">
                    <input type="hidden" name="action" value="save"/>
                    <table>
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Check Type</th>
                                <th>Checked At</th>
                                <th>Source</th>
                                <th>Note</th>
                                <th>Period ID</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${previewData}">
                                <tr>
                                    <td>${row.userId}</td>
                                    <td>${row.checkType}</td>
                                    <td>${row.checkedAt}</td>
                                    <td>${row.source}</td>
                                    <td>${row.note}</td>
                                    <td>${row.periodId}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="actions">
                        <button type="submit" class="btn btn-import">Save / Import</button>
                    </div>
                </form>
            </c:if>
        </div>
    </body>
</html>
