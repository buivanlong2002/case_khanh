package com.devfromzk.web.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.devfromzk.dao.ProfileDAO;
import com.devfromzk.dao.ProjectDAO;
import com.devfromzk.dao.BlogPostDAO;
import com.devfromzk.model.Profile;
import com.devfromzk.model.Project;
import com.devfromzk.model.BlogPost;
import java.util.ArrayList;
import java.util.List;

@WebServlet("")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProfileDAO profileDAO;
    private ProjectDAO projectDAO;
    private BlogPostDAO blogPostDAO;

    private static final int MAX_FEATURED_PROJECTS = 3;
    private static final int MAX_RECENT_BLOG_POSTS = 3;

    @Override
    public void init() throws ServletException {
        profileDAO = new ProfileDAO();
        projectDAO = new ProjectDAO();
        blogPostDAO = new BlogPostDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Profile profile = profileDAO.getDefaultProfile();
        request.setAttribute("profile", profile);
        request.setAttribute("pageTitle", profile != null ? profile.getName() + " - Trang Chủ" : "Trang Chủ");
        request.setAttribute("activePage", "home");

        List<Project> allProjects = projectDAO.getAllProjects();
        List<Project> featuredProjects = new ArrayList<>();
        if (allProjects != null && !allProjects.isEmpty()) {
            int limit = Math.min(allProjects.size(), MAX_FEATURED_PROJECTS);
            featuredProjects = allProjects.subList(0, limit);
        }
        request.setAttribute("featuredProjects", featuredProjects);

        List<BlogPost> allPublishedBlogPosts = blogPostDAO.getAllPublishedBlogPosts();
        List<BlogPost> recentBlogPosts = new ArrayList<>();
        if (allPublishedBlogPosts != null && !allPublishedBlogPosts.isEmpty()) {
            int limit = Math.min(allPublishedBlogPosts.size(), MAX_RECENT_BLOG_POSTS);
            recentBlogPosts = allPublishedBlogPosts.subList(0, limit);
        }
        request.setAttribute("recentBlogPosts", recentBlogPosts);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}