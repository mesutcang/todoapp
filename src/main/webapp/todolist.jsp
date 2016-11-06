<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><spring:message code="todo.list"></spring:message> </title>

    <link type="text/css" href="${contextPath}/resources/css/common.css" rel="stylesheet">
    <link type="text/css" href="${contextPath}/resources/css/app.css" rel="stylesheet"/>
    <link type="text/css" href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet"/>
    <link type="text/css" href="${contextPath}/resources//css/jquery-ui.min.css" rel="stylesheet"/>
    <link type="text/css" href="${contextPath}/resources//css/colorbox.css" rel="stylesheet"/>
    <link type="text/css" href="${contextPath}/resources//css/fuelux.min.css" rel="stylesheet" />

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="loading-layout"></div>
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
                    <a href="/add"><spring:message code="todo.add.title"></spring:message> </a>
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

<div class="container">
    <div class="row" style="margin-top: 50px">
        <div class="col-lg-12">
            <div class="fuelux">
                <div class="repeater" id="repeaterIllustration">
                    <div class="repeater-header">
                        <div class="repeater-header-left">
                            <span class="repeater-title">Search Todo</span>
                            <div class="repeater-search">
                                <div class="search input-group">
                                    <input type="search" class="form-control" placeholder="Search Product"/>
                                    <span class="input-group-btn">
                                              <button class="btn btn-default" type="button">
                                                <span class="glyphicon glyphicon-search"></span>
                                                <span class="sr-only">Search</span>
                                              </button>
                                            </span>
                                </div>
                            </div>
                        </div>
                        <div class="repeater-header-right">
                            <div class="btn-group repeater-views" data-toggle="buttons">
                                <label class="btn btn-default active">
                                    <input name="repeaterViews" type="radio" value="list"><span
                                        class="glyphicon glyphicon-list"></span>
                                </label>
                                <label class="btn btn-default">
                                    <input name="repeaterViews" type="radio" value="thumbnail"><span
                                        class="glyphicon glyphicon-th"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="repeater-viewport">
                        <div class="repeater-canvas"></div>
                        <div class="loader repeater-loader"></div>
                    </div>
                    <div class="repeater-footer">
                        <div class="repeater-footer-left">
                            <div class="repeater-itemization">
                                        <span><span class="repeater-start"></span> - <span class="repeater-end"></span> of <span
                                                class="repeater-count"></span> items</span>
                                <div class="btn-group selectlist" data-resize="auto">
                                    <button type="button" class="btn btn-default dropdown-toggle"
                                            data-toggle="dropdown">
                                        <span class="selected-label">&nbsp;</span>
                                        <span class="caret"></span>
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">
                                        <li data-value="5"><a href="#">5</a></li>
                                        <li data-value="10" data-selected="true"><a href="#">10</a></li>
                                        <li data-value="20"><a href="#">20</a></li>
                                        <li data-value="50" data-foo="bar" data-fizz="buzz"><a href="#">50</a>
                                        </li>
                                        <li data-value="100"><a href="#">100</a></li>
                                    </ul>
                                    <input class="hidden hidden-field" name="itemsPerPage" readonly="readonly"
                                           aria-hidden="true" type="text"/>
                                </div>
                                <span>Per Page</span>
                            </div>
                        </div>
                        <div class="repeater-footer-right">
                            <div class="repeater-pagination">
                                <button type="button" class="btn btn-default btn-sm repeater-prev">
                                    <span class="glyphicon glyphicon-chevron-left"></span>
                                    <span class="sr-only">Previous Page</span>
                                </button>
                                <label class="page-label" id="myPageLabel">Page</label>
                                <div class="repeater-primaryPaging active">
                                    <div class="input-group input-append dropdown combobox">
                                        <input type="text" class="form-control" aria-labelledby="myPageLabel">
                                        <div class="input-group-btn">
                                            <button type="button" class="btn btn-default dropdown-toggle"
                                                    data-toggle="dropdown">
                                                <span class="caret"></span>
                                                <span class="sr-only">Toggle Dropdown</span>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-right"></ul>
                                        </div>
                                    </div>
                                </div>
                                <input type="text" class="form-control repeater-secondaryPaging"
                                       aria-labelledby="myPageLabel">
                                <span>of <span class="repeater-pages"></span></span>
                                <button type="button" class="btn btn-default btn-sm repeater-next">
                                    <span class="glyphicon glyphicon-chevron-right"></span>
                                    <span class="sr-only">Next Page</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery.cookie.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery.class.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery.numeric.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery.colorbox-min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/underscore-min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/fuelux.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/bootbox.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/app/BaseClass.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/app/Todo.js"></script>

</body>
</html>
