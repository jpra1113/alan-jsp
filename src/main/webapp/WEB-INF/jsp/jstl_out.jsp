<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:out 範例</title>
</head>

<body>
    <h2>4. c:out 安全輸出</h2>
    <p>原始內容 (含腳本): ${unsafeContent}</p>

    <p>預設防護 (escapeXml="true"):
        <c:out value="${unsafeContent}" />
    </p>

    <p>關閉防護 (escapeXml="false"):
        <c:out value="${unsafeContent}" escapeXml="false" />
    </p>
</body>

</html>