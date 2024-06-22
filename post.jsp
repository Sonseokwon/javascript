<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="mypackage.CommentDAO, mypackage.Comment, mypackage.PostDAO, mypackage.Post" %>
<%
    int postId = Integer.parseInt(request.getParameter("postId"));
    PostDAO postDAO = new PostDAO();
    Post post = postDAO.getPostById(postId);
    if(request.getMethod().equals("POST")) {
        String action = request.getParameter("action");
        CommentDAO commentDAO = new CommentDAO();
        if(action.equals("create")) {
            String content = request.getParameter("content");
            commentDAO.createComment(postId, (String)session.getAttribute("username"), content);
        } else if(action.equals("delete")) {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            commentDAO.deleteComment(commentId);
        }
    }
    CommentDAO commentDAO = new CommentDAO();
    List<Comment> comments = commentDAO.getCommentsByPostId(postId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post</title>
</head>
<body>
    <h1><%= post.getContent() %></h1>
    <form method="post">
        <input type="hidden" name="action" value="create">
        <textarea name="content" placeholder="Write a comment..." required></textarea>
        <button type="submit">Comment</button>
    </form>
    <%
        for(Comment comment : comments) {
            out.println("<div>");
            out.println("<p>" + comment.getContent() + "</p>");
            if(comment.getUsername().equals(session.getAttribute("username"))) {
                out.println("<form method='post'>");
                out.println("<input type='hidden' name='commentId' value='" + comment.getId() + "'>");
                out.println("<input type='hidden' name='action' value='delete'>");
                out.println("<button type='submit'>Delete</button>");
                out.println("</form>");
            }
            out.println("</div>");
        }
    %>
</body>
</html>