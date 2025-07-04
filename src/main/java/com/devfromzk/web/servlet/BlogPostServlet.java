package com.devfromzk.web.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.devfromzk.dao.BlogPostDAO;
import com.devfromzk.dao.ProfileDAO;
import com.devfromzk.dao.CommentDAO;
import com.devfromzk.model.BlogPost;
import com.devfromzk.model.Profile;
import com.devfromzk.model.Comment;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet("/blog/post")
public class BlogPostServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(BlogPostServlet.class);
    private static final long serialVersionUID = 1L;
    private BlogPostDAO blogPostDAO;
    private ProfileDAO profileDAO;
    private CommentDAO commentDAO;

    @Override
    public void init() throws ServletException {
        blogPostDAO = new BlogPostDAO();
        profileDAO = new ProfileDAO();
        commentDAO = new CommentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String postIdParam = request.getParameter("id");
        BlogPost blogPost = null;
        Profile profile = profileDAO.getDefaultProfile();
        request.setAttribute("profile", profile);

        int currentBlogPostIdForFilter = -1;

        if (postIdParam != null && !postIdParam.isEmpty()) {
            try {
                int postId = Integer.parseInt(postIdParam);
                blogPost = blogPostDAO.getBlogPostById(postId);
                currentBlogPostIdForFilter = postId;

                if (blogPost == null || !"published".equalsIgnoreCase(blogPost.getStatus())) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bài viết không tồn tại hoặc chưa được công khai.");
                    return;
                }
                request.setAttribute("blogPost", blogPost);

                List<Comment> comments = commentDAO.getApprovedCommentsByPostId(postId);
                request.setAttribute("commentsList", comments);

                request.setAttribute("pageTitle", blogPost.getTitle());
                if (profile != null) {
                    request.setAttribute("pageTitle", profile.getName() + " - " + blogPost.getTitle());
                }

            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID bài viết không hợp lệ.");
                return;
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không tìm thấy ID bài viết.");
            return;
        }

        final int effectivelyFinalCurrentPostId = currentBlogPostIdForFilter;

        List<BlogPost> allPublishedPostsForSidebar = blogPostDAO.getAllPublishedBlogPosts();
        Map<String, Long> categoriesCount = allPublishedPostsForSidebar.stream()
                .filter(p -> p.getCategory() != null && !p.getCategory().trim().isEmpty())
                .collect(Collectors.groupingBy(BlogPost::getCategory, Collectors.counting()));
        request.setAttribute("categoriesCount", categoriesCount);

        List<String> allTags = allPublishedPostsForSidebar.stream()
                .filter(p -> p.getTags() != null && !p.getTags().trim().isEmpty())
                .flatMap(p -> java.util.Arrays.stream(p.getTags().split(",")))
                .map(String::trim)
                .distinct()
                .collect(Collectors.toList());
        request.setAttribute("allTags", allTags);

        List<BlogPost> recentPosts = allPublishedPostsForSidebar.stream()
                .filter(p -> p.getId() != effectivelyFinalCurrentPostId)
                .limit(5)
                .collect(Collectors.toList());
        request.setAttribute("recentPosts", recentPosts);

        request.setAttribute("activePage", "blog");
        request.getRequestDispatcher("/blog-post.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Đảm bảo encoding cho POST data
        String action = request.getParameter("action");

        if ("addComment".equals(action)) {
            try {
                int postId = Integer.parseInt(request.getParameter("postId"));
                String authorName = request.getParameter("authorName");
                String authorEmail = request.getParameter("authorEmail");
                String content = request.getParameter("commentContent");
                String parentCommentIdStr = request.getParameter("parentCommentId");

                if (authorName == null || authorName.trim().isEmpty() || content == null || content.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/blog/post?id=" + postId + "&commentError=validation");
                    return;
                }

                Comment newComment = new Comment();
                newComment.setBlogPostId(postId);
                newComment.setAuthorName(authorName.trim());
                if (authorEmail != null && !authorEmail.trim().isEmpty()) {
                    newComment.setAuthorEmail(authorEmail.trim());
                }
                newComment.setContent(content.trim());
                newComment.setCreatedDate(new java.util.Date());
                newComment.setStatus("approved"); // Hoặc "pending" nếu bạn muốn duyệt

                if (parentCommentIdStr != null && !parentCommentIdStr.trim().isEmpty()) {
                    try {
                        newComment.setParentCommentId(Integer.parseInt(parentCommentIdStr));
                    } catch (NumberFormatException e) {
                    }
                }

                boolean saved = commentDAO.saveComment(newComment);
                if (saved) {
                    response.sendRedirect(request.getContextPath() + "/blog/post?id=" + postId + "&commentAdded=true#comments");
                } else {
                    response.sendRedirect(request.getContextPath() + "/blog/post?id=" + postId + "&commentAdded=false#comments");
                }

            } catch (NumberFormatException e) {
                String postIdParam = request.getParameter("postId");
                if (postIdParam != null && !postIdParam.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/blog/post?id=" + postIdParam + "&commentError=invalidPostId#comments");
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Post ID for comment.");
                }
            } catch (Exception e) {
                logger.error("Error while saving comment: {}", e.getMessage(), e);
                String postIdParam = request.getParameter("postId");
                response.sendRedirect(request.getContextPath() + "/blog/post?id=" + postIdParam + "&commentError=serverError#comments");
            }
        } else {
            doGet(request, response);
        }
    }
}