<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="mypackage.PostDAO, mypackage.Post" %>
<%
    if(request.getMethod().equals("POST")) {
        String action = request.getParameter("action");
        PostDAO postDAO = new PostDAO();
        if(action.equals("create")) {
            String content = request.getParameter("content");
            postDAO.createPost((String)session.getAttribute("username"), content);
        } else if(action.equals("edit")) {
            int postId = Integer.parseInt(request.getParameter("postId"));
            String content = request.getParameter("content");
            postDAO.updatePost(postId, content);
        } else if(action.equals("delete")) {
            int postId = Integer.parseInt(request.getParameter("postId"));
            postDAO.deletePost(postId);
        }
    }
    PostDAO postDAO = new PostDAO();
    List<Post> posts = postDAO.getAllPosts();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
</head>
<<body>
    <form method="post">
        <input type="hidden" name="action" value="create">
        <textarea name="content" placeholder="Write something..." required></textarea>
        <button type="submit">Post</button>
    </form>
    <%
        for(Post post : posts) {
            out.println("<div>");
            out.println("<p>" + post.getContent() + "</p>");
            if(post.getUsername().equals(session.getAttribute("username"))) {
                out.println("<form method='post'>");
                out.println("<input type='hidden' name='postId' value='" + post.getId() + "'>");
                out.println("<input type='hidden' name='action' value='edit'>");
                out.println("<textarea name='content'>" + post.getContent() + "</textarea>");
                out.println("<button type='submit'>Edit</button>");
                out.println("</form>");
                out.println("<form method='post'>");
                out.println("<input type='hidden' name='postId' value='" + post.getId() + "'>");
                out.println("<input type='hidden' name='action' value='delete'>");
                out.println("<button type='submit'>Delete</button>");
                out.println("</form>");
            }
            out.println("</div>");
        }
    %>
</body>
</html>