<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:set 範例</title>
</head>

<body>
    <h2>5. c:set 變數設定</h2>
    <c:set var="bonus" value="500" scope="page" />
    <p>設定在 Page 範圍的 bonus: ${bonus}</p>
</body>

</html>