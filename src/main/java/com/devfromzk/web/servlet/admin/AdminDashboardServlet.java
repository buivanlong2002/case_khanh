package com.devfromzk.web.servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.devfromzk.dao.ProfileDAO;
import com.devfromzk.dao.BlogPostDAO;
import com.devfromzk.dao.ProjectDAO;
import com.devfromzk.dao.ContactMessageDAO;
import com.devfromzk.model.Profile;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(AdminDashboardServlet.class);
    private static final long serialVersionUID = 1L;
    private ProfileDAO profileDAO;
    private BlogPostDAO blogPostDAO;
    private ProjectDAO projectDAO;
    private ContactMessageDAO contactMessageDAO;

    @Override
    public void init() throws ServletException {
        profileDAO = new ProfileDAO();
        blogPostDAO = new BlogPostDAO();
        projectDAO = new ProjectDAO();
        contactMessageDAO = new ContactMessageDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        logger.info("AdminDashboardServlet: doGet START");
        Profile profile = profileDAO.getDefaultProfile();
        request.setAttribute("profileAdmin", profile);

        int totalBlogPosts = blogPostDAO.getTotalBlogPostCountAdmin();
        int totalProjects = projectDAO.getTotalProjectCount();
        int newMessagesCount = contactMessageDAO.getUnreadMessageCount();

        request.setAttribute("totalBlogPosts", totalBlogPosts);
        request.setAttribute("totalProjects", totalProjects);
        request.setAttribute("newMessagesCount", newMessagesCount);
        logger.info("AdminDashboardServlet: Forwarding to /admin/index.jsp");
        request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
        logger.info("AdminDashboardServlet: doGet END (should not be reached if forward is successful)");
    }
}