package servlet;

import bean.User;
import dao.CollectionDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/CollectionServlet")
public class CollectionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=UTF-8");
        User user=null;
        user= (User) request.getSession().getAttribute("user");
        String bookIdString=request.getParameter("bookId");
        PrintWriter out=response.getWriter();
        if(user==null){
            out.print("<script type='text/javascript'>");
            out.print("alert('收藏失败,请先登录');");
            out.print("window.location='directory.jsp?bookId="+bookIdString+"';");
            out.print("</script>");
            return;
        }
        if(bookIdString==null||bookIdString.equals("")){
            out.print("<script type='text/javascript'>");
            out.print("alert('无法找到书籍,即将返回主页面');");
            out.print("window.location='directory.jsp?bookId="+bookIdString+"';");
            out.print("</script>");
            return;
        }
        Integer bookId=null;
        try {
            bookId=Integer.parseInt(bookIdString);
        }catch (Exception e){
            out.print("<script type='text/javascript'>");
            out.print("alert('无法找到书籍,即将返回主页面');");
            out.print("window.location='index.jsp';");
            out.print("</script>");
            return;
        }
        try {
            CollectionDAO.collectionBook(user.getUserId(),bookId);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        response.sendRedirect("directory.jsp?bookId="+bookId);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
