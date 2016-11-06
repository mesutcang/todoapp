<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="selection"><spring:message code='todo.default.selection'/></c:set>
<fmt:parseNumber var="defaultSelection" type="number" value="${selection}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><spring:message code="todo.add.title"></spring:message></title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<c:if test="${not empty msg}">
    <div class="alert alert-danger">
        <strong>${msg}</strong>
    </div>
</c:if>
<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/"><spring:message code="todo.app.name"></spring:message></a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li>
                    <a href="/todo-list"><spring:message code="todo.list.todo"></spring:message> </a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <c:if test="${pageContext.request.userPrincipal.name != null}">
                        <form id="logoutForm" method="POST" action="${contextPath}/logout">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                        <a onclick="document.forms['logoutForm'].submit()">Logout</a>
                    </c:if>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container" style="margin-top: 50px;">
    <form:form id="todoForm" method="POST" action="/todo/save" modelAttribute="todoForm">
        <table class="table table-bordered">
            <tbody>

            <spring:bind path="description">
            <tr>
                <th><spring:message code="todo.description"></spring:message></th>
                <td>
                    <form:input type="text" class="form-control" path="description"></form:input>
                    <form:errors path="description" cssStyle="color: red"/>
                </td>
            </tr>
            </spring:bind>

            <spring:bind path="priority">
            <tr>
                <th><spring:message code="todo.priority"></spring:message></th>
                <td>
                    <c:forEach items="${priorities}" var="priority">
                        <label class="radio-inline">
                            <c:choose>
                                <c:when test="${defaultSelection == priority.id}">
                                    <form:radiobutton path="priority" value="${priority.id}"
                                                      data-status="${priority}" checked="true"/>${priority.name}
                                    <form:errors path="priority" cssStyle="color: red"/>
                                </c:when>
                                <c:otherwise>
                                    <form:radiobutton path="priority" value="${priority.id}"
                                                      data-status="${priority}"/>${priority.name}
                                    <form:errors path="priority" cssStyle="color: red"/>
                                </c:otherwise>
                            </c:choose>
                        </label>
                    </c:forEach>
                </td>
            </tr>
            </spring:bind>

            <tr>
                <td colspan="2">
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
                </td>
            </tr>

        </table>
    </form:form>
    <a href="/" class="btn btn-success">Main Page</a>
</div>

<script src="${contextPath}/resources/js/jquery-1.11.1.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
