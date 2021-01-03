package servlet;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/CheckAccountServlet")
public class CheckAccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out=response.getWriter();
        String type=request.getParameter("type");
        String account=request.getParameter("account");
        Integer userId=null;
        try {
            userId=Integer.parseInt(account);
        }catch (Exception e){
            out.print("应为正整数");
        }
        if("emailAjaxValidate".equals(type)){
            if(userId==null){
                out.print("空");
                return;
            }else if(userId<0){
                out.print("应为正整数");
                return;
            }
            boolean flag=false;
            try {
                flag=UserDAO.isRegisted(userId);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            if(flag==true){
                out.print("账号重复");
                return;
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
