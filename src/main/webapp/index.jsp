<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Hero Section -->
<section class="hero-area" id="home">
    <div id="tsparticles-background"></div>
    <div class="container">
        <div class="row align-items-center" style="min-height: 90vh; min-height: 90dvh;">
            <div class="col-lg-10 col-md-12 mx-auto text-center">
                <div class="hero-text-animated">
                    <h1 class="animated-name">
                        <span class="name-word word-ngo">
                            <span class="char">N</span><span class="char">G</span><span class="char">Ô</span>
                        </span>
                        <span class="name-word word-gia">
                            <span class="char">G</span><span class="char">I</span><span class="char">A</span>
                        </span>
                        <span class="name-word word-khanh">
                            <span class="char">K</span><span class="char">H</span><span class="char">Á</span><span class="char">N</span><span class="char">H</span>
                        </span>
                    </h1>
                    <p class="animated-subtitle lead">
                        <c:out value="${profile.position}"/>
                        <c:if test="${not empty profile.companyName}">
                            - <c:out value="${profile.companyName}"/>
                        </c:if>
                    </p>
                    <div class="hero-btns">
                        <a href="#about" class="hero-btn">Tìm Hiểu Thêm</a>
                        <a href="${pageContext.request.contextPath}/contact" class="hero-btn outline">Liên Hệ Ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <a href="#about" class="scroll-down" aria-label="Scroll to about section">
        <i class="fas fa-chevron-down"></i>
    </a>
</section>

<!-- About Section Preview -->
<section class="about-area section-padding" id="about">
    <div class="container">
        <div class="section-title text-center" data-aos="fade-up">
            <h2>Về Tôi</h2>
        </div>
        <div class="row align-items-center">
            <div class="col-lg-5" data-aos="fade-right" data-aos-delay="100">
                <div class="about-img">
                    <img src="${not empty profile.photoUrl ? (profile.photoUrl.startsWith('http') ? profile.photoUrl : pageContext.request.contextPath.concat(profile.photoUrl)) : pageContext.request.contextPath.concat('/resources/images/default-profile-full.jpg')}"
                         alt="Ảnh của ${profile.name}"
                         onerror="this.src='${pageContext.request.contextPath}/resources/images/default-profile-full-placeholder.jpg'; this.onerror=null;">
                </div>
            </div>
            <div class="col-lg-7" data-aos="fade-left" data-aos-delay="200">
                <div class="about-content">
                    <h3><c:out value="${profile.name}"/></h3>
                    <h4><c:out value="${profile.position}"/></h4>
                    <p class="text-muted">
                        <c:choose>
                            <c:when test="${fn:length(profile.bio) > 250}">
                                <c:out value="${fn:substring(profile.bio, 0, 250)}"/>...
                            </c:when>
                            <c:otherwise>
                                <c:out value="${profile.bio}"/>
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <div class="about-info mt-3">
                        <div class="info-box">
                            <span><i class="fas fa-envelope me-2 text-primary"></i>Email:</span>
                            <span><a href="mailto:${profile.email}"><c:out value="${profile.email}"/></a></span>
                        </div>
                        <div class="info-box">
                            <span><i class="fas fa-phone me-2 text-primary"></i>Điện thoại:</span>
                            <span><a href="tel:${profile.phoneNumber}"><c:out value="${profile.phoneNumber}"/></a></span>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/about" class="btn btn-primary mt-4">Xem Thông Tin Chi Tiết</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Featured Services/Features Section -->
<section class="features-area section-padding bg-light" id="features">
    <div class="container">
        <div class="section-title text-center" data-aos="fade-up">
            <h2>Lĩnh Vực Hoạt Động Chính</h2>
        </div>
        <div class="row">
            <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100"><div class="feature-box"><div class="feature-icon"><i class="fas fa-building"></i></div><h4>Giải Pháp Công Nghệ</h4><p>Nghiên cứu, phát triển và triển khai các giải pháp công nghệ tiên tiến như AI, IoT, Big Data và nền tảng số, giúp doanh nghiệp chuyển đổi số toàn diện và nâng cao năng lực cạnh tranh.</p></div></div>
            <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200"><div class="feature-box"><div class="feature-icon"><i class="fas fa-industry"></i></div><h4>Hạ Tầng Số & Phát Triển Công Nghiệp</h4><p>Tư vấn, đầu tư và triển khai hệ sinh thái công nghệ tại các khu công nghiệp thông minh – thúc đẩy sản xuất tự động, kết nối dữ liệu và tối ưu chuỗi cung ứng.</p></div></div>
            <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300"><div class="feature-box"><div class="feature-icon"><i class="fas fa-chart-line"></i></div><h4>Đầu Tư & Tài Chính Số</h4><p>Cung cấp giải pháp đầu tư tài chính ứng dụng công nghệ (Fintech), hỗ trợ phân tích dữ liệu, tối ưu hóa danh mục đầu tư và quản trị rủi ro theo thời gian thực.</p></div></div>
        </div>
    </div>
</section>

<c:if test="${not empty featuredProjects}">
    <section class="projects-preview-area section-padding" id="projects-preview">
        <div class="container">
            <div class="section-title text-center" data-aos="fade-up">
                <h2>Dự Án Tiêu Biểu</h2>
            </div>
            <div class="row">
                <c:forEach items="${featuredProjects}" var="project" varStatus="loop">
                    <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="${100 * loop.index}">
                            <%-- Thêm class h-100 và mb-4 (margin bottom) cho cột --%>
                        <div class="project-item-preview h-100">
                            <div class="project-img">
                                <c:set var="contextPath" value="${pageContext.request.contextPath}" />
                                <c:set var="imageSourceProject">
                                    <c:choose>
                                        <c:when test="${not empty project.imageUrl}">
                                            <c:if test="${fn:startsWith(project.imageUrl, 'http')}">
                                                <c:out value="${project.imageUrl}"/>
                                            </c:if>
                                            <c:if test="${not fn:startsWith(project.imageUrl, 'http')}">
                                                <c:out value="${contextPath}${project.imageUrl}"/>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <c:out value="${contextPath}/resources/images/default-project.jpg"/>
                                        </c:otherwise>
                                    </c:choose>
                                </c:set>
                                <img src="${imageSourceProject}"
                                     alt="<c:out value='${project.title}'/>"
                                     onerror="this.src='${contextPath}/resources/images/default-project-placeholder.jpg'; this.onerror=null;">
                                <div class="project-overlay">
                                    <a href="${pageContext.request.contextPath}/projects/detail?id=${project.id}" class="stretched-link" aria-label="Xem chi tiết dự án ${project.title}">
                                        <i class="fas fa-plus"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="project-content">
                                <span class="project-category"><c:out value="${project.category}"/></span>
                                <h4><a href="${pageContext.request.contextPath}/projects/detail?id=${project.id}"><c:out value="${project.title}"/></a></h4>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="text-center mt-5" data-aos="fade-up">
                <a href="${pageContext.request.contextPath}/projects" class="btn btn-outline-primary">Xem Tất Cả Dự Án</a>
            </div>
        </div>
    </section>
</c:if>

<c:if test="${not empty recentBlogPosts}">
    <section class="blog-preview-area section-padding bg-light" id="blog-preview">
        <div class="container">
            <div class="section-title text-center" data-aos="fade-up">
                <h2>Bài Viết Mới Nhất</h2>
            </div>
            <div class="row">
                <c:forEach items="${recentBlogPosts}" var="post" varStatus="loop">
                    <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="${100 * loop.index}">
                        <div class="blog-post-preview h-100">
                            <div class="blog-img">
                                <c:set var="contextPath" value="${pageContext.request.contextPath}" />
                                <c:set var="imageSource">
                                    <c:choose>
                                        <c:when test="${not empty post.imageUrl}">
                                            <c:if test="${fn:startsWith(post.imageUrl, 'http')}">
                                                <c:out value="${post.imageUrl}"/>
                                            </c:if>
                                            <c:if test="${not fn:startsWith(post.imageUrl, 'http')}">
                                                <c:out value="${contextPath}${post.imageUrl}"/>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <c:out value="${contextPath}/resources/images/default-blog.jpg"/>
                                        </c:otherwise>
                                    </c:choose>
                                </c:set>
                                <img src="${imageSource}"
                                     alt="<c:out value='${post.title}'/>"
                                     onerror="this.src='${contextPath}/resources/images/default-blog-placeholder.jpg'; this.onerror=null;">
                            </div>
                            <div class="blog-content">
                                <div class="blog-meta">
                                    <span><i class="fas fa-calendar-alt"></i> <fmt:formatDate value="${post.createdDate}" pattern="dd/MM/yyyy"/></span>
                                    <span><i class="fas fa-folder"></i> <c:out value="${post.category}"/></span>
                                </div>
                                <h4><a href="${pageContext.request.contextPath}/blog/post?id=${post.id}"><c:out value="${post.title}"/></a></h4>
                                <p>
                                    <c:choose>
                                        <c:when test="${fn:length(post.summary) > 100}">
                                            <c:out value="${fn:substring(post.summary, 0, 100)}"/>...
                                        </c:when>
                                        <c:otherwise>
                                            <c:out value="${post.summary}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <a href="${pageContext.request.contextPath}/blog/post?id=${post.id}" class="read-more-link">Đọc thêm <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="text-center mt-5" data-aos="fade-up">
                <a href="${pageContext.request.contextPath}/blog" class="btn btn-outline-primary">Xem Tất Cả Bài Viết</a>
            </div>
        </div>
    </section>
</c:if>

<section class="contact-cta section-padding">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8 text-center">
                <h2 data-aos="fade-up">Sẵn Sàng Hợp Tác?</h2>
                <p data-aos="fade-up" data-aos-delay="100" class="lead">
                    Nếu bạn có ý tưởng, dự án hoặc cần tư vấn chuyên sâu, đừng ngần ngại liên hệ. Tôi luôn sẵn lòng lắng nghe và đồng hành cùng bạn.
                </p>
                <a href="${pageContext.request.contextPath}/contact" class="btn btn-primary btn-lg mt-3" data-aos="fade-up" data-aos-delay="200">Liên Hệ Ngay</a>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/includes/footer.jsp" />