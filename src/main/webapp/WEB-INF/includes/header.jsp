<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle ne null ? pageTitle : 'Website Cá Nhân'}"/></title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/tsparticles@2.10.1/tsparticles.bundle.min.js"></script>

    <script>
        const appContextPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body>
<header class="header-area">
    <div class="container">
        <nav class="navbar navbar-expand-lg navbar-light">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <span class="logo-text">
                        <c:set var="profileNameForLogo" value="${profile.name}"/>
                        <c:if test="${not empty profileNameForLogo}">
                            <c:set var="namePartsLogo" value="${fn:split(profileNameForLogo, ' ')}" />
                            <c:set var="firstNameInitialLogo" value="${fn:substring(namePartsLogo[0], 0, 1)}" />
                            <c:set var="lastNameInitialLogo" value="" />
                            <c:if test="${fn:length(namePartsLogo) > 1}">
                                <c:set var="lastNameInitialLogo" value="${fn:substring(namePartsLogo[fn:length(namePartsLogo)-1], 0, 1)}" />
                            </c:if>
                            <c:out value="${firstNameInitialLogo}${lastNameInitialLogo}"/>
                        </c:if>
                        <c:if test="${empty profileNameForLogo}">NGK</c:if>
                    </span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link ${activePage == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/">
                            <i class="fas fa-home"></i> Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activePage == 'about' ? 'active' : ''}" href="${pageContext.request.contextPath}/about">
                            <i class="fas fa-user"></i> Giới Thiệu
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activePage == 'projects' ? 'active' : ''}" href="${pageContext.request.contextPath}/projects">
                            <i class="fas fa-briefcase"></i> Dự Án
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activePage == 'blog' ? 'active' : ''}" href="${pageContext.request.contextPath}/blog">
                            <i class="fas fa-newspaper"></i> Blog
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activePage == 'contact' ? 'active' : ''}" href="${pageContext.request.contextPath}/contact">
                            <i class="fas fa-envelope"></i> Liên Hệ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activePage == 'admin' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin">
                            <i class="fas fa-user-shield"></i> Admin
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</header>

<div id="preloader">
    <div class="preloader-content-centered">
        <div class="preloader-logo-text-bar">
            <c:set var="profileNameForPreloader" value="${profile.name}"/>
            <c:if test="${not empty profileNameForPreloader}">
                <c:set var="namePartsPreloader" value="${fn:split(profileNameForPreloader, ' ')}" />
                <c:set var="firstNameInitialPreloader" value="${fn:substring(namePartsPreloader[0], 0, 1)}" />
                <c:set var="lastNameInitialPreloader" value="" />
                <c:if test="${fn:length(namePartsPreloader) > 1}">
                    <c:set var="lastNameInitialPreloader" value="${fn:substring(namePartsPreloader[fn:length(namePartsPreloader)-1], 0, 1)}" />
                </c:if>
                <c:out value="${firstNameInitialPreloader}${lastNameInitialPreloader}"/>
            </c:if>
            <c:if test="${empty profileNameForPreloader}">NGK</c:if>
        </div>
        <div class="preloader-bar-container-simple">
            <div class="preloader-bar-simple"></div>
        </div>
    </div>
</div>