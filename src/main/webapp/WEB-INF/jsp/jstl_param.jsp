<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:param 範例</title>
</head>

<body>
    <h2>7. c:param 參數傳遞</h2>
    <c:url value="/search" var="searchUrl">
        <c:param name="keyword" value="JSTL教學" />
        <c:param name="page" value="1" />
    </c:url>
    <p>生成的帶參數 URL: ${searchUrl}</p>
</body>

</html>