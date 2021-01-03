package servlet;

import bean.Book;
import bean.User;
import dao.BookDAO;
import dao.UserDAO;
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

@WebServlet(urlPatterns = "/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        //设置编码
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=UTF-8");
        //获取用户,判断用户是否登录和是否拥有权限
        User user = null;
        user = (User) request.getSession().getAttribute("user");
        PrintWriter out = response.getWriter();
        if (user == null) {
            out.print("<script type='text/javascript'>");
            out.print("alert('请先登录');");
            out.print("window.location='index.jsp';");
            out.print("</script>");
            return;
        }
        if (user.getAdministrator() != 1) {
            out.print("<script type='text/javascript'>");
            out.print("alert('非管理员,没有权限');");
            out.print("window.location='index.jsp';");
            out.print("</script>");
            return;
        }
        //获取bookId
        Integer bookId = Book.BookStringToBookId(request.getParameter("bookId"));
        if (bookId == null) {
            out.print("<script type='text/javascript'>");
            out.print("alert('没有书籍相关信息');");
            out.print("window.location='bookManager.jsp';");
            out.print("</script>");
            return;
        }
        //获取书籍
        Book book = null;
        try {
            book = new BookDAO().getBookById(bookId);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        //没有获取到书籍
        if (book == null) {
            out.print("<script type='text/javascript'>");
            out.print("alert('无法找到要删除的书籍');");
            out.print("window.location='bookManager.jsp';");
            out.print("</script>");
            return;
        }
        //删除书籍相关文件及文件夹
        DeleteFolder.delete(new File(request.getServletContext().getRealPath("/books") + "/" + book.getBookId()));//删除书籍内容
        //如果书籍封面不是默认封面,则将图片封面删除
        if (!book.getCover().equals("nocover.jpg"))
            DeleteFolder.delete(new File(request.getServletContext().getRealPath("/books") + "/bookCover/" + book.getCover()));//删除书籍封面
        //从数据库中删除书籍
        try {
            new BookDAO().deleteBookById(book.getBookId());
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        //返回书籍管理页面
        response.sendRedirect("bookManager.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
