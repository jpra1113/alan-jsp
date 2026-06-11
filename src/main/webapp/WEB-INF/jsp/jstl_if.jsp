<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:if 範例</title>
</head>

<body>
    <h2>2. c:if 條件判斷</h2>
    <c:if test="${isLoggedIn}">
        <p style="color: green;">您已登入系統。</p>
    </c:if>
    <c:if test="${accountBalance > 10000}">
        <p>您的餘額充足 (大於 10,000)。</p>
    </c:if>
</body>

</html>