<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Login</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
  <style>
    body {
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
      font-family: var(--body-font);
    }
    .login-card {
      max-width: 400px;
      width: 100%;
      padding: 40px 32px 32px 32px;
      box-shadow: var(--box-shadow);
      border-radius: var(--border-radius);
      background: #fff;
      border-top: 6px solid var(--secondary-color);
      position: relative;
      margin: 32px 0;
      animation: fadeInUp 0.7s cubic-bezier(.39,.575,.565,1) both;
    }
    @keyframes fadeInUp {
      0% { opacity: 0; transform: translateY(40px); }
      100% { opacity: 1; transform: translateY(0); }
    }
    .login-card h2 {
      text-align: center;
      margin-bottom: 24px;
      color: var(--primary-color);
      font-family: var(--heading-font);
      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
    }
    .login-card label {
      color: var(--primary-color);
      font-weight: 500;
      font-family: var(--body-font);
    }
    .login-card .form-control {
      border-radius: var(--border-radius);
      border: 1px solid var(--border-color);
      font-size: 1rem;
      padding: 10px 14px;
      background: var(--section-bg-light);
      color: var(--text-color);
      transition: border-color 0.2s;
    }
    .login-card .form-control:focus {
      border-color: var(--secondary-color);
      box-shadow: 0 0 0 2px rgba(var(--secondary-color-rgb), 0.15);
      background: #fff;
    }
    .login-card .btn-primary {
      background: var(--secondary-color);
      border: none;
      border-radius: 30px;
      font-weight: 600;
      font-family: var(--body-font);
      letter-spacing: 1px;
      padding: 12px 0;
      font-size: 1.1rem;
      box-shadow: 0 4px 16px rgba(var(--secondary-color-rgb), 0.10);
      transition: background 0.2s, box-shadow 0.2s;
    }
    .login-card .btn-primary:hover {
      background: var(--primary-color);
      color: #fff;
      box-shadow: 0 8px 24px rgba(var(--primary-color), 0.12);
    }
    .login-card .alert {
      border-radius: var(--border-radius);
      font-size: 0.98rem;
      margin-bottom: 18px;
    }
    .login-card .form-group label {
      margin-bottom: 6px;
    }
    .login-card .form-group {
      margin-bottom: 18px;
    }
    .login-card .form-control::placeholder {
      color: #b0b0b0;
      opacity: 1;
    }
    .login-card .login-footer {
      text-align: center;
      margin-top: 18px;
      color: var(--text-color);
      font-size: 0.97rem;
    }
    .login-card .login-footer a {
      color: var(--secondary-color);
      text-decoration: underline;
      transition: color 0.2s;
    }
    .login-card .login-footer a:hover {
      color: var(--primary-color);
    }
  </style>
</head>
<body>
<div class="login-card">
  <h2>Admin Login</h2>
  <c:if test="${not empty loginError}">
    <div class="alert alert-danger" role="alert">
      <c:out value="${loginError}"/>
    </div>
  </c:if>
  <form action="${pageContext.request.contextPath}/admin/login" method="post">
    <input type="hidden" name="org.apache.catalina.filters.CSRF_NONCE" value="${sessionScope['org.apache.catalina.filters.CSRF_NONCE']}">
    <div class="form-group mb-3">
      <label for="username">Tên đăng nhập:</label>
      <input type="text" class="form-control" id="username" name="username" required autofocus placeholder="Nhập tên đăng nhập">
    </div>
    <div class="form-group mb-3">
      <label for="password">Mật khẩu:</label>
      <input type="password" class="form-control" id="password" name="password" required placeholder="Nhập mật khẩu">
    </div>
    <button type="submit" class="btn btn-primary btn-block w-100">Đăng nhập</button>
    <div class="login-footer mt-3">
      <span>Quay lại <a href="${pageContext.request.contextPath}/">Trang chủ</a></span>
    </div>
  </form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>