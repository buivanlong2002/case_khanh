<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Lỗi Máy Chủ Nội Bộ</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body { display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 100vh; background-color: #f8f9fa; text-align: center; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .error-code { font-size: 120px; font-weight: bold; color: #ffc107; }
        .error-message { font-size: 24px; margin-bottom: 20px; }
        .error-description { font-size: 16px; color: #6c757d; margin-bottom: 30px; }
    </style>
</head>
<body>
<div class="error-code">500</div>
<div class="error-message">Ối! Đã có lỗi xảy ra ở phía máy chủ.</div>
<div class="error-description">
    Chúng tôi đang làm việc để khắc phục sự cố này. <br>
    Vui lòng thử lại sau hoặc quay về trang chủ.
</div>
<a href="${pageContext.request.contextPath}/" class="btn btn-primary">
    <i class="fas fa-home mr-2"></i>Về Trang Chủ
</a>
</body>
</html>