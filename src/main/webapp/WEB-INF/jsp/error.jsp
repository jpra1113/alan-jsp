<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <title>系統發生錯誤</title>
    <style>
        body {
            font-family: sans-serif;
            padding: 50px;
            background: #f8f9fa;
            text-align: center;
        }

        .error-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: inline-block;
            max-width: 80%;
        }

        h1 {
            color: #e74c3c;
        }

        .msg {
            background: #fee;
            padding: 15px;
            border-left: 5px solid #e74c3c;
            text-align: left;
            margin: 20px 0;
            font-family: monospace;
        }

        .back-btn {
            text-decoration: none;
            color: white;
            background: #3498db;
            padding: 10px 20px;
            border-radius: 5px;
        }
    </style>
</head>

<body>
    <div class="error-container">
        <h1>⚠️ 糟了！系統發生錯誤</h1>
        <p>這是透過 JSP <code>errorPage</code> 機制捕捉到的例外狀況。</p>

        <div class="msg">
            <strong>錯誤訊息：</strong> <%= exception != null ? exception.getMessage() : "未知錯誤" %>
        </div>

        <%
            // 將錯誤詳細紀錄到伺服器日誌 (在 Termux/Console 中可以看到)
            if (exception != null) {
                application.log("JSP 發生未預期錯誤", exception);
            }
        %>

        <p>
            <a href="scriptlet" class="back-btn">返回範例首頁</a>
        </p>
    </div>
</body>

</html>