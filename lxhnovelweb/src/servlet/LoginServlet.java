package servlet;

import bean.User;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean flag=true;
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=UTF-8");
        String userIdString =request.getParameter("userId");
        String password=request.getParameter("password");
        Integer userId=null;
        try {
            userId=Integer.parseInt(userIdString);//账号转换为数字是否成功
        }catch (Exception e){
            flag=false;
        }
        //账号输入正确,查询数据库检查账号和密码是否正确
        if(flag){
            try {
                flag= UserDAO.login(userId,password);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
        //如果此时flag依然为true,说明账号和密码输入正确,应该登录成功
        PrintWriter out=response.getWriter();
        if(flag){
            User user=null;
            try {
                user=UserDAO.getUserByUserId(userId);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            request.getSession().setAttribute("user",user);
            response.sendRedirect("index.jsp");
        }else{
            out.print("<script type='text/javascript'>");
            out.print("alert('登录失败,即将跳转到主页面');");
            out.print("window.location='index.jsp';");
            out.print("</script>");
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
//    userId
//            password
//    nickName
//            administrator
