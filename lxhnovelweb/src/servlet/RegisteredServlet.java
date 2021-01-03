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

@WebServlet(urlPatterns = "/RegisteredServlet")
public class RegisteredServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean flag=true;
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=UTF-8");
        String userIdInt=request.getParameter("userId");
        String password=request.getParameter("password");
        String nickName=request.getParameter("nickName");
        String returnMsg="";
        if(userIdInt==null||userIdInt.equals("")){
            flag=false;
            returnMsg=returnMsg+"账号不能为空;";
        }
        if(password==null||password.equals("")){
            flag=false;
            returnMsg=returnMsg+"密码不能为空;";
        }
        if(password.length()>20){
            flag=false;
            returnMsg=returnMsg+"密码不得超过20字符;";
        }
        if(nickName==null||nickName.equals("")){
            flag=false;
            returnMsg=returnMsg+"昵称不能为空;";
        }
        if(nickName.length()>20){
            flag=false;
            returnMsg=returnMsg+"昵称不得超过20字符";
        }
        Integer userId=null;
        if(userIdInt!=null&&!userIdInt.equals("")){
            try {
                userId=Integer.parseInt(userIdInt);
            }catch (Exception e){
                flag=false;
                returnMsg=returnMsg+"账号必须为整数;";
            }
            if(userId!=null){
                boolean temp=false;
                try {
                    temp= UserDAO.isRegisted(userId);
                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                if(temp){
                    flag=false;
                    returnMsg=returnMsg+"账号重复;";
                }

            }
            if(userId<=0){
                flag=false;
                returnMsg=returnMsg+"账号必须为正整数";
            }
        }
        PrintWriter out=response.getWriter();
        if(flag){
            boolean isSave=true;
            User user=new User();
            user.setUserId(userId);
            user.setPassword(password);
            user.setNickName(nickName);
            try {
                isSave=UserDAO.registed(user);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            if(isSave){
                out.print("<script type='text/javascript'>");
                out.print("alert('填写合格,注册成功,即将跳转到主页面');");
                out.print("window.location='index.jsp';");
                out.print("</script>");
            }else{
                out.print("<script type='text/javascript'>");
                out.print("alert('填写合格,但由于数据库原因,暂时无法注册,为此深表歉意.即将跳转到主页面');");
                out.print("window.location='index.jsp';");
                out.print("</script>");
            }

        }else {
            out.print("<script type='text/javascript'>");
            out.print("alert('"+returnMsg+";即将跳转到主页面');");
            out.print("window.location='index.jsp';");
            out.print("</script>");
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
