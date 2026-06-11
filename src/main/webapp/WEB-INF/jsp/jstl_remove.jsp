<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:remove 範例</title>
</head>

<body>
    <h2>8. c:remove 移除變數</h2>
    <p>移除前: ${tempMsg}</p>
    <c:remove var="tempMsg" />
    <p>移除後: ${tempMsg} (應為空)</p>
</body>

</html>