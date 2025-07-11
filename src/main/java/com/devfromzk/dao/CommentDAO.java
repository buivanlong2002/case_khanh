package com.devfromzk.dao;
import com.devfromzk.model.Comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CommentDAO {
    private static final Logger logger = LoggerFactory.getLogger(CommentDAO.class);
    private Comment extractCommentFromResultSet(ResultSet rs) throws SQLException {
        Comment comment = new Comment();
        comment.setId(rs.getInt("id"));
        comment.setBlogPostId(rs.getInt("blog_post_id"));
        comment.setParentCommentId(rs.getObject("parent_comment_id", Integer.class));
        comment.setAuthorName(rs.getString("author_name"));
        comment.setAuthorEmail(rs.getString("author_email"));
        comment.setContent(rs.getString("content"));
        comment.setCreatedDate(rs.getTimestamp("created_date"));
        comment.setStatus(rs.getString("status"));
        return comment;
    }
    public List<Comment> getApprovedCommentsByPostId(int blogPostId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.*, bp.title as blog_post_title FROM comments c JOIN blog_posts bp ON c.blog_post_id = bp.id WHERE c.blog_post_id = ? AND c.status = 'approved' ORDER BY c.created_date ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, blogPostId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    comments.add(extractCommentFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            logger.error("Lỗi SQL khi thực hiện : {}", e.getMessage(), e);
        }
        return comments;
    }
    public boolean saveComment(Comment comment) {
        String sql = "INSERT INTO comments (blog_post_id, parent_comment_id, author_name, author_email, content, created_date, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        boolean rowInserted = false;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, comment.getBlogPostId());
            if (comment.getParentCommentId() != null) {
                stmt.setInt(2, comment.getParentCommentId());
            } else {
                stmt.setNull(2, java.sql.Types.INTEGER);
            }
            stmt.setString(3, comment.getAuthorName());
            stmt.setString(4, comment.getAuthorEmail());
            stmt.setString(5, comment.getContent());
            stmt.setTimestamp(6, new Timestamp(comment.getCreatedDate().getTime()));
            stmt.setString(7, comment.getStatus() != null ? comment.getStatus() : "pending");
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                rowInserted = true;
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        comment.setId(generatedKeys.getInt(1));
                    }
                }
            }
        } catch (SQLException e) {
            logger.error("Lỗi SQL khi thực hiện : {}", e.getMessage(), e);
        }
        return rowInserted;
    }
    public List<Comment> getAllCommentsAdmin() {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.*, bp.title as blog_post_title FROM comments c LEFT JOIN blog_posts bp ON c.blog_post_id = bp.id ORDER BY c.created_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Comment comment = extractCommentFromResultSet(rs);
                comments.add(comment);
            }
        } catch (SQLException e) {
            logger.error("Lỗi SQL khi thực hiện getALlcomment {}", e.getMessage(), e);
        }
        return comments;
    }
    public Comment getCommentById(int commentId) {
        Comment comment = null;
        String sql = "SELECT * FROM comments WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, commentId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    comment = extractCommentFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            logger.error("Lỗi SQL khi thực hiện : {}", e.getMessage(), e);
        }
        return comment;
    }
    public boolean updateCommentStatus(int commentId, String newStatus) {
        String sql = "UPDATE comments SET status = ? WHERE id = ?";
        boolean rowUpdated = false;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, commentId);
            rowUpdated = stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Lỗi SQL khi thực hiện : {}", e.getMessage(), e);
        }
        return rowUpdated;
    }
    public boolean updateCommentContent(int commentId, String newContent) {
        String sql = "UPDATE comments SET content = ? WHERE id = ?";
        boolean rowUpdated = false;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newContent);
            stmt.setInt(2, commentId);
            rowUpdated = stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Lỗi SQL khi thực hiện : {}", e.getMessage(), e);
        }
        return rowUpdated;
    }
    public boolean deleteComment(int commentId) {
        String sql = "DELETE FROM comments WHERE id = ?";
        boolean rowDeleted = false;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, commentId);
            rowDeleted = stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Lỗi SQL khi thực hiện : {}", e.getMessage(), e);
        }
        return rowDeleted;
    }
}