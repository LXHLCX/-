package servlet;

import bean.Book;
import bean.User;
import dao.BookDAO;
import dao.PassageDAO;
import utils.DBUtils;
import utils.DeleteFolder;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/AddPassageServlet")
@MultipartConfig
public class AddPassageServlet extends HttpServlet {
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
        //获取书籍,并判断书籍是否存在
        String bookIdString=request.getParameter("bookId");
        Integer bookId= Book.BookStringToBookId(bookIdString);
        Book book=null;
        try {
            book=new BookDAO().getBookById(bookId);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        if(book==null){
            out.print("<script type='text/javascript'>");
            out.print("alert('没有找到书籍');");
            out.print("window.location='bookManager.jsp';");
            out.print("</script>");
            return;
        }
        //获取章节名
        String passageName=request.getParameter("passageName");
        if(passageName==null||passageName.equals("")){
            out.print("<script type='text/javascript'>");
            out.print("alert('章节名不能为空');");
            out.print("window.location='passageManager.jsp?bookId="+book.getBookId()+"';");
            out.print("</script>");
            return;
        }
        //获取上传的文件
        Part part=request.getPart("newPassage");
        String fileName=part.getSubmittedFileName();
        //判断是否选择了文件上传
        if(fileName==null||fileName.equals("")){
            out.print("<script type='text/javascript'>");
            out.print("alert('没有上传文件');");
            out.print("window.location='passageManager.jsp?bookId="+book.getBookId()+"';");
            out.print("</script>");
            return;
        }
        //判断文件是否是txt文件
        if(!fileName.substring(fileName.lastIndexOf(".")).equals(".txt")){
            out.print("<script type='text/javascript'>");
            out.print("alert('上传文件不是txt文件');");
            out.print("window.location='passageManager.jsp?bookId="+book.getBookId()+"';");
            out.print("</script>");
            return;
        }
        //向数据库中插入章节信息,并返回自增的passageNumber
        int passageNumber=-1;
        try {
            passageNumber=new PassageDAO().inertNewPassage(book.getBookId(),passageName);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        //根据passageNumber设置新的文件名
        String newFileName=passageName+fileName.substring(fileName.lastIndexOf("."));
        //设置保存文件夹
        String directoryPath=request.getServletContext().getRealPath("/books/"+book.getBookId());
        //设置保存路径
        String savePath=directoryPath+"/"+newFileName;
        //判断该文件是否已经存在
        File temp=new File(savePath);
        //如果存在就删除他
        if(temp.exists()){
            DeleteFolder.delete(temp);
        }
        //保存文件
        part.write(savePath);
        //更新数据库信息
        try {
            new PassageDAO().updatePassagePosition(book.getBookId(),passageNumber,newFileName);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        //回到章节管理页面
        response.sendRedirect("passageManager.jsp?bookId="+book.getBookId());
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
