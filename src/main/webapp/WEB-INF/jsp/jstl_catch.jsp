<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:catch 範例</title>
</head>

<body>
    <h2>11. c:catch 例外捕捉</h2>
    <c:catch var="ex">
        <% 
            int result = 10 / 0; 
        %>
    </c:catch>
    <c:if test="${not empty ex}">
        <p style="color: red;">發生錯誤: ${ex.message}</p>
    </c:if>
</body>

</html>