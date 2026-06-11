<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<head>
    <title>c:choose 範例</title>
</head>

<body>
    <h2>3. 多重條件判斷</h2>
    <p>當前角色：${userRole}</p>
    <c:choose>
        <c:when test="${userRole == 'ADMIN'}">
            <button>進入管理後台</button>
        </c:when>
        <c:when test="${userRole == 'USER'}">
            <button>進入個人中心</button>
        </c:when>
        <c:otherwise>
            <p>請登入以查看功能</p>
        </c:otherwise>
    </c:choose>
</body>

</html>