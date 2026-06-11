<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:forEach 範例</title>
</head>

<body>
    <h2>1. c:forEach 遍歷集合</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>名稱</th>
            <th>價格</th>
        </tr>
        <c:forEach var="item" items="${advList}">
            <tr>
                <td>${item.id}</td>
                <td>${item.name}</td>
                <td>${item.price}</td>
            </tr>
        </c:forEach>
    </table>
</body>

</html>