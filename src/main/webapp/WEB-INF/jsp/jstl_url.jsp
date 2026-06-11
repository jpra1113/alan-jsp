<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:url 範例</title>
</head>

<body>
    <h2>6. c:url 路徑處理</h2>
    <c:url value="/css/main.css" var="cssUrl" />
    <p>產生的絕對路徑: ${cssUrl}</p>
    <a href="<c:url value='/' />">回首頁</a>
</body>

</html>