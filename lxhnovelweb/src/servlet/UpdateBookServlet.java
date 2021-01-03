package servlet;

import bean.Book;
import bean.User;
import dao.BookDAO;

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

@WebServlet(urlPatterns = "/UpdateBookServlet")
@MultipartConfig
public class UpdateBookServlet extends HttpServlet {
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
        //用书籍编号获取书籍
        Integer bookId= Book.BookStringToBookId(request.getParameter("bookId"));
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
            out.print("alert('没有找到相关书籍');");
            out.print("window.location='bookManager.jsp';");
            out.print("</script>");
            return;
        }
        System.out.println(book);
        System.out.println("书名:"+request.getParameter("bookName"));
        System.out.println("作者:"+request.getParameter("author"));
        System.out.println("分类:"+request.getParameter("classification"));
        System.out.println("简介:"+request.getParameter("introduction"));
        //书籍名不能为空
        if(request.getParameter("bookName")==null||request.getParameter("bookName").equals("")){
            out.print("<script type='text/javascript'>");
            out.print("alert('书籍名不能为空');");
            out.print("window.location='bookManager.jsp?bookId="+book.getBookId()+"';");
            out.print("</script>");
            return;
        }
        //对书籍库中的书籍信息进行修改
        book.setBookName(request.getParameter("bookName"));
        book.setIntroduction(request.getParameter("introduction"));
        book.setClassification(Integer.parseInt(request.getParameter("classification")));
        book.setAuthor(request.getParameter("author"));
        try {
            new BookDAO().updateBook(book);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        //上传书籍封面
        Part part=request.getPart("cover");//获取文件
        String fileName=part.getSubmittedFileName();//获取文件名
        if(fileName!=null&&!fileName.equals("")){
            String newFileName=bookId+fileName.substring(fileName.lastIndexOf("."));//新文件名
            String filePath=request.getServletContext().getRealPath("/books/bookCover");//保存路径
            String oldCoverPath=filePath+"/"+newFileName;//看是否有重名的文件
            File oldFileCover=new File(oldCoverPath);
            if(oldFileCover.exists())//有重名文件就删除
                oldFileCover.delete();
            part.write(filePath+"/"+newFileName);//保存
            //更改数据库中书籍封面的连接
            try {
                new BookDAO().updateCover(newFileName,bookId);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("bookManager.jsp");
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
