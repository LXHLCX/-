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
import java.util.Enumeration;

@WebServlet(urlPatterns = "/AddBookServlet")
@MultipartConfig
public class AddBookServlet extends HttpServlet {
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
        //获取书名
        String bookName=request.getParameter("bookName");
        //书名为null的处理
        if(bookName==null||bookName.equals("")){
            out.print("<script type='text/javascript'>");
            out.print("alert('书籍名称不能为空');");
            out.print("window.location='addBook.jsp';");
            out.print("</script>");
            return;
        }
        //获取其他属性
        String introduction=request.getParameter("introduction");
        String classificationString=request.getParameter("classification");
        int classification=Integer.parseInt(classificationString);
        String author=request.getParameter("author");
        //插入数据库,并返回其他属性
        int bookId=-1;
        try {
            bookId=new BookDAO().insertNewBook(bookName,introduction,classification,author);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        System.out.println("是否获取了主键");
        //插入新的书籍时,主键有误
        if(bookId<=0){
            out.print("<script type='text/javascript'>");
            out.print("alert('书籍添加失败');");
            out.print("window.location='addBook.jsp';");
            out.print("</script>");
            return;
        }
        //创建文件夹
        File bookFolder= new File(request.getServletContext().getRealPath("/books")+"/"+bookId);
        System.out.println("书籍目录的绝对路径:"+bookFolder.getAbsolutePath());
        if(!bookFolder.exists()){
            bookFolder.mkdir();
            try {
                //将书籍目录更改到此处
                new BookDAO().updateFolder(bookId);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
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
