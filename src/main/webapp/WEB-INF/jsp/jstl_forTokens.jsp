<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:forTokens 範例</title>
</head>

<body>
    <h2>12. c:forTokens 字串分割</h2>
    <p>原始字串: ${csvTags}</p>
    <ul>
        <c:forTokens items="${csvTags}" delims="," var="tag">
            <li>標籤：<span style="background: #eee; padding: 2px 5px;">${tag}</span></li>
        </c:forTokens>
    </ul>
</body>

</html>