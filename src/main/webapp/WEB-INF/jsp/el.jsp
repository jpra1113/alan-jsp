<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <title>Day 1-3: EL 表達式實驗室</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/lifecycle.css">
    <style>
        .el-section { margin-bottom: 30px; }
        .token { color: #e83e8c; font-weight: bold; font-family: monospace; }
        .result-box { background: #f8f9fa; border: 1px solid #dee2e6; padding: 10px; border-radius: 4px; margin-top: 5px;}
    </style>
</head>

<body>
    <div class="card">
        <div class="card-header">🧪 EL 基礎運算與 Null 安全</div>
        <table>
            <thead>
                <tr>
                    <th>測試場景</th>
                    <th>EL 語法</th>
                    <th>執行結果</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>算術運算 (加法)</td>
                    <td><span class="token">\${10 + 20}</span></td>
                    <td>${10 + 20}</td>
                </tr>
                <tr>
                    <td>比較運算 (大於)</td>
                    <td><span class="token">\${testUser.age gt 18}</span></td>
                    <td>${testUser.age gt 18}</td>
                </tr>
                <tr>
                    <td>三元運算 (身分)</td>
                    <td><span class="token">\${testUser.age >= 18 ? '成人' : '未成年'}</span></td>
                    <td><span class="badge" style="background:#3498db">${testUser.age >= 18 ? '成人' : '未成年'}</span></td>
                </tr>
                <tr>
                    <td>空值判斷 (Empty List)</td>
                    <td><span class="token">\${empty emptyList}</span></td>
                    <td>${empty emptyList ? '✅ 是空的' : '❌ 不是空的'}</td>
                </tr>
                <tr>
                    <td>空值判斷 (Null Var)</td>
                    <td><span class="token">\${empty nullVar}</span></td>
                    <td>${empty nullVar ? '✅ 是空的' : '❌ 不是空的'}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="card">
        <div class="card-header">🌐 隱含物件偵測 (Implicit Objects)</div>
        <p>直接從請求中獲取資訊，無需透過 Controller：</p>
        <div class="scope-grid">
            <div class="scope-item">
                <div class="scope-title">URL 參數 (param.type)</div>
                <div class="scope-value">${not empty param.type ? param.type : '無參數'}</div>
                <small>試著在 URL 後加上 ?type=pro</small>
            </div>
            <div class="scope-item">
                <div class="scope-title">瀏覽器 (header)</div>
                <div class="scope-value" style="font-size: 0.8rem;">${header['User-Agent']}</div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header">🚀 EL 3.0+ 進階特性 (Lambda & Stream)</div>
        
        <div class="el-section">
            <p><strong>1. 字串串接 (String Concatenation):</strong></p>
            <div class="result-box">
                ${'歡迎回來，' += testUser.name += '！ 職位是：' += testUser.role}
            </div>
        </div>

        <div class="el-section">
            <p><strong>2. 集合建構 (Collection Construction):</strong></p>
            <div class="result-box">
                快速清單：${['Java', 'Spring', 'JSP']} <br>
                快速 Map：${{'key1': 'value1', 'key2': 12345}}
            </div>
        </div>

        <div class="el-section">
            <p><strong>3. Stream API (過濾出價格 > 20000 的產品):</strong></p>
            <ul>
                <c:forEach var="pName" items="${productList.stream().filter(p -> p.price > 20000).map(p -> p.name).toList()}">
                    <li>💎 高階產品：<span class="token">${pName}</span></li>
                </c:forEach>
            </ul>
        </div>

        <div class="el-section">
            <p><strong>4. Lambda 表達式 (即時計算折扣):</strong></p>
            <div class="result-box">
                <%-- 定義 Lambda --%>
                <c:set var="applyDiscount" value="${(p, r) -> p * r}" />
                原價 1000 元，打 75 折後為：<span class="badge" style="background:#e67e22">${applyDiscount(1000, 0.75)}</span>
            </div>
        </div>
    </div>

    <div style="font-size: 0.8rem; color: #95a5a6; text-align: center; margin-top: 30px;">
        EL 版本：3.0+ | 環境：Jakarta EE | 
        <a href="${pageContext.request.contextPath}/learning/jsp/el?type=standard" style="color: #3498db;">重整並帶入參數</a>
    </div>
</body>

</html>
