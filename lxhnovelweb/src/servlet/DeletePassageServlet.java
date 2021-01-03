package servlet;

import bean.Book;
import bean.Passage;
import bean.User;
import dao.PassageDAO;
import utils.DeleteFolder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/DeletePassageServlet")
public class DeletePassageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        //设置编码
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=UTF-8");
        //获取用户,判断用户是否登录和是否拥有权限
        User user=null;
        user= (User) request.getSession().getAttribute("user");
        PrintWriter out=response.getWriter();
        if(user==null){
            out.print("<script type='text/javascript'>");
            out.print("alert('请先登录');");
            out.print("window.location='index.jsp';");
            out.print("</script>");
            return;
        }
        if(user.getAdministrator()!=1){
            out.print("<script type='text/javascript'>");
            out.print("alert('非管理员,没有权限');");
            out.print("window.location='index.jsp';");
            out.print("</script>");
            return;
        }
        //获取bookId和passageNumber
        Integer bookId= Book.BookStringToBookId(request.getParameter("bookId"));
        Integer passageNumber= Passage.passageNumberStringToPassageNumber(request.getParameter("passageNumber"));
        //如果bookId和passageNumber中存在null
        if(bookId==null||passageNumber==null){
            out.print("<script type='text/javascript'>");
            out.print("alert('章节不存在');");
            out.print("window.location='passageManager.jsp?bookId="+bookId+"';");
            out.print("</script>");
            return;
        }
        //删除章节对应的文件
        System.out.println(request.getServletContext().getRealPath("/books/"+bookId+"/"+passageNumber+".txt"));
        File file=new File(request.getServletContext().getRealPath("/books/"+bookId+"/"+passageNumber+".txt"));
        if(file.exists())
            DeleteFolder.delete(file);
        //删除数据库中的信息
        try {
            new PassageDAO().deletePassage(bookId,passageNumber);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        //回到章节管理
        response.sendRedirect("passageManager.jsp?bookId="+bookId);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
