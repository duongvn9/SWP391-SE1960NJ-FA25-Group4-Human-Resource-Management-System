<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Kháng nghị chấm công</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            .container {
                max-width: 600px;
                margin: auto;
            }
            label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
            }
            input, textarea {
                width: 100%;
                padding: 6px;
                margin-top: 4px;
                box-sizing: border-box;
            }
            .btn {
                margin-top: 15px;
                padding: 8px 16px;
                cursor: pointer;
                background: #28a745;
                color: #fff;
                border: none;
            }
            .message {
                margin-top: 15px;
                color: green;
            }
            .error {
                margin-top: 15px;
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Kháng nghị chấm công</h2>

            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="error">${errorMessage}</div>
            </c:if>

            <form action="submitCorrection" method="post" enctype="multipart/form-data">
                <!-- Thông tin nhân viên -->
                <label>Tên nhân viên:</label>
                <input type="text" name="userName" value="${userName}" readonly/>

                <label>ID nhân viên:</label>
                <input type="text" name="userId" value="${userId}" readonly/>

                <!-- Thông tin bản ghi -->
                <label>Ngày/Giờ chấm công:</label>
                <input type="text" name="checkedAt" value="${log.checkedAt}" readonly/>

                <label>Check Type:</label>
                <input type="text" name="checkType" value="${log.checkType}" readonly/>

                <label>Ghi chú hiện tại:</label>
                <textarea name="note" readonly>${log.note}</textarea>

                <!-- Form kháng nghị -->
                <label>Lý do kháng nghị:</label>
                <textarea name="reason" required></textarea>

                <label>Ngày/Giờ sửa (nếu cần):</label>
                <input type="datetime-local" name="correctedAt"/>

                <label>File minh chứng (nếu có):</label>
                <input type="file" name="attachment"/>

                <button type="submit" class="btn">Gửi kháng nghị</button>
            </form>
        </div>
    </body>
</html>
