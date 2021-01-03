package servlet;

import bean.Book;
import bean.User;
import utils.DBUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/DeleteCollectionServlet")
public class DeleteCollectionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=UTF-8");
        User user= (User) request.getSession().getAttribute("user");
        String bookIdString=request.getParameter("bookId");
        Integer bookId= Book.BookStringToBookId(bookIdString);
        PrintWriter out=response.getWriter();
        if(user==null){
            out.print("<script type='text/javascript'>");
            out.print("alert('请先登录');");
            out.print("window.location='index.jsp';");
            out.print("</script>");
            return;
        }
        if(bookId==null){
            out.print("<script type='text/javascript'>");
            out.print("alert('没有找到书籍');");
            out.print("window.location='index.jsp';");
            out.print("</script>");
            return;
        }
        String sql="delete from collection where userId="+user.getUserId()+" and bookId="+bookId;
        DBUtils dbUtils=null;
        try {
            dbUtils=new DBUtils();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try {
            dbUtils.update(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if(request.getParameter("URL").equals("directory.jsp"))
            response.sendRedirect("directory.jsp?bookId="+bookId);
        else if(request.getParameter("URL").equals("collection.jsp"))
            response.sendRedirect("collection.jsp");
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
