<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // 進階教學：在 Page 作用域設定屬性 (這是 JSP 唯一能設定 PageScope 的地方)
    pageContext.setAttribute("pageData", "Page 專屬資料 (僅限此頁面)");
    pageContext.setAttribute("conflictVar", "來自 [Page] 的最高優先權");
%>
<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <title>Day 1-2: 四大作用域進階實戰</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/lifecycle.css">
    <style>
        .highlight-box {
            background: #fff3cd;
            border: 2px dashed #ffc107;
            padding: 15px;
            margin: 10px 0;
            border-radius: 8px;
        }

        .code-inline {
            background: #f8f9fa;
            padding: 2px 5px;
            border-radius: 4px;
            font-family: monospace;
            color: #e83e8c;
        }
    </style>
</head>

<body>
    <div class="card">
        <div class="card-header">🚀 作用域深度分析儀表板</div>
        <div class="scope-grid">
            <div class="scope-item" style="border-left-color: #9b59b6;">
                <div class="scope-title">Page Scope</div>
                <div class="scope-value">${pageScope.pageData != null ? '已就緒' : '空'}</div>
                <small>${pageScope.pageData}</small>
            </div>
            <div class="scope-item" style="border-left-color: #3498db;">
                <div class="scope-title">Request Scope</div>
                <div class="scope-value">${requestScope.requestData != null ? '已傳遞' : '空'}</div>
                <small>${requestScope.requestData}</small>
            </div>
            <div class="scope-item" style="border-left-color: #2ecc71;">
                <div class="scope-title">Session Scope</div>
                <div class="scope-value">${sessionScope.sessionData != null ? '已持久' : '空'}</div>
                <small>${sessionScope.sessionData}</small>
            </div>
            <div class="scope-item" style="border-left-color: #f1c40f;">
                <div class="scope-title">Application Scope</div>
                <div class="scope-value">${applicationScope.applicationData != null ? '全域共用' : '空'}</div>
                <small>${applicationScope.applicationData}</small>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header">🧪 EL 尋找順序實驗室 (優先權測試)</div>
        <div class="highlight-box">
            <p><strong>目前測試變數：</strong> <span class="code-inline">conflictVar</span></p>
            <p><strong>EL 自動搜尋結果：</strong> <span class="badge" style="font-size: 1rem;">${conflictVar}</span></p>
            <hr>
            <p style="font-size: 0.9rem; color: #666;">
                搜尋順序演示：<br>
                1. 檢查 Page (${pageScope.conflictVar != null ? '✅' : '❌'}) <br>
                2. 檢查 Request (${requestScope.conflictVar != null ? '✅' : '❌'}) <br>
                3. 檢查 Session (${sessionScope.conflictVar != null ? '✅' : '❌'}) <br>
                4. 檢查 Application (${applicationScope.conflictVar != null ? '✅' : '❌'})
            </p>
        </div>
    </div>

    <div class="card">
        <div class="card-header">📦 進階資料結構讀取 (EL Deep Dive)</div>
        <table>
            <thead>
                <tr>
                    <th>資料類型</th>
                    <th>EL 語法</th>
                    <th>取得內容</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><span class="badge" style="background:#34495e">List (Index)</span></td>
                    <td><code>\${requestScope.courseTags[0]}</code></td>
                    <td>${requestScope.courseTags[0]}</td>
                </tr>
                <tr>
                    <td><span class="badge" style="background:#34495e">Map (Key)</span></td>
                    <td><code>\${sessionScope.detailedUser['level']}</code></td>
                    <td>${sessionScope.detailedUser['level']}</td>
                </tr>
                <tr>
                    <td><span class="badge" style="background:#34495e">Map (Dot)</span></td>
                    <td><code>\${detailedUser.region}</code></td>
                    <td>${detailedUser.region}</td>
                </tr>
                <tr>
                    <td><span class="badge" style="background:#e67e22">Context Path</span></td>
                    <td><code>\${pageContext.request.contextPath}</code></td>
                    <td><code>${pageContext.request.contextPath}</code></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="card">
        <div class="card-header">🛠️ 作用域互動管理</div>
        <p>模擬 Session 操作：</p>
        <div style="display: flex; gap: 10px;">
            <button onclick="location.reload()">重新整理 (測試 Request 存續)</button>
            <button class="secondary"
                onclick="location.href='${pageContext.request.contextPath}/learning/jsp/lifecycle/logout'">銷毀 Session
                (測試登出)</button>
        </div>
        <p style="margin-top: 15px; font-size: 0.85rem; color: #7f8c8d;">
            提示：嘗試開啟「無痕視窗」造訪此頁面，觀察哪些資料會消失（Session），哪些會依然存在（Application）。
        </p>
    </div>

    <div style="font-size: 0.8rem; color: #95a5a6; text-align: center; margin-top: 30px;">
        系統啟動時間：${applicationScope.serverStartTime} | 當前 Session ID: <code>${pageContext.session.id}</code>
    </div>
</body>

</html>