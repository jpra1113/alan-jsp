<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:redirect 範例</title>
</head>

<body>
    <h2>10. c:redirect 重導向</h2>
    <p>這是一個重導向按鈕示範：</p>
    <button onclick="if(confirm('要重導向至首頁嗎？')) window.location.href='<c:url value=" /welcome" />'">
    執行重導向 (JS版本)
    </button>
    <%-- JSP 標籤式重導向一旦執行會立即跳轉 --%>
    <%-- <c:redirect url="/" /> --%>
</body>

</html>