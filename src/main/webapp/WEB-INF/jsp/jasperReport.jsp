<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="common/header.jsp" />

<!DOCTYPE html>
<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <title>報表 - 保單查詢與檢視</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/lifecycle.css">
    <style>
        #reportFrameContainer {
            display: none;
            margin-top: 15px;
        }

        #reportFrame {
            width: 100%;
            height: 700px;
            border: 1px solid #ddd;
        }
    </style>
</head>

<body>

    <div class="card">
        <div class="card-header">🔎 透過客戶名稱查詢</div>
        <form action="${pageContext.request.contextPath}/jasperReport" method="get">
            <div style="display:flex; gap:10px; align-items:center;">
                <div style="flex:1;">
                    <label>客戶名稱</label>
                    <input type="text" name="name" value="${searchName}" placeholder="輸入客戶名稱關鍵字" />
                </div>
                <div>
                    <button type="submit">搜尋</button>
                </div>
            </div>
        </form>
    </div>

    <div class="card">
        <div class="card-header">📋 查詢結果</div>
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>姓名</th>
                        <th>年齡</th>
                        <th>保費</th>
                        <th>動作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${customers}">
                        <tr>
                            <td>
                                <c:out value="${c.id}" />
                            </td>
                            <td>
                                <c:out value="${c.name}" />
                            </td>
                            <td>
                                <c:out value="${c.age}" />
                            </td>
                            <td>
                                <c:out value="${c.premium}" />
                            </td>
                            <td>
                                <button type="button" onclick="showPolicies(${c.id})">顯示保單</button>
                                <button type="button" onclick="loadReport(${c.id})">檢視報表</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="card" id="policiesCard" style="display:none;">
        <div class="card-header">保單清單</div>
        <div class="table-responsive">
            <table id="policiesTable">
                <thead>
                    <tr>
                        <th>保單號碼</th>
                        <th>類別</th>
                        <th>保額</th>
                        <th>保費</th>
                        <th>起保</th>
                        <th>迄保</th>
                        <th>狀態</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>

    <div id="reportFrameContainer">
        <div class="card">
            <div class="card-header">PDF 檢視</div>
            <iframe id="reportFrame" src="" title="報表檢視"></iframe>
        </div>
    </div>

    <script>
        const base = '${pageContext.request.contextPath}';

        function showPolicies(customerId) {
            fetch(base + '/jasperReport/policies?customerId=' + customerId)
                .then(resp => resp.json())
                .then(data => {
                    const tbody = document.querySelector('#policiesTable tbody');
                    tbody.innerHTML = '';
                    if (!data || data.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="7" style="text-align:center">沒有保單資料</td></tr>';
                        document.getElementById('policiesCard').style.display = 'block';
                        return;
                    }
                    data.forEach(p => {
                        const tr = document.createElement('tr');
                        tr.innerHTML = `<td>${p.policyNumber || ''}</td>` +
                            `<td>${p.type || ''}</td>` +
                            `<td>${p.sumInsured || ''}</td>` +
                            `<td>${p.premiumAmount || ''}</td>` +
                            `<td>${p.startDate || ''}</td>` +
                            `<td>${p.endDate || ''}</td>` +
                            `<td>${p.status || ''}</td>`;
                        tbody.appendChild(tr);
                    });
                    document.getElementById('policiesCard').style.display = 'block';
                })
                .catch(err => {
                    alert('取得保單資料失敗');
                });
        }

        function loadReport(customerId) {
            document.getElementById('reportFrame').src = base + '/jasperReport/view?customerId=' + customerId;
            document.getElementById('reportFrameContainer').style.display = 'block';
            window.scrollTo(0, document.getElementById('reportFrameContainer').offsetTop - 20);
        }
    </script>

</body>

</html>