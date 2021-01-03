package listener;

import bean.Book;
import bean.Passage;
import dao.BookDAO;
import dao.PassageDAO;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebListener()
public class ReadTimesListener implements ServletRequestListener {//用于记录书籍的访问数量

    @Override
    public void requestDestroyed(ServletRequestEvent servletRequestEvent) {

    }

    @Override
    public void requestInitialized(ServletRequestEvent servletRequestEvent) {
        HttpServletRequest request= (HttpServletRequest) servletRequestEvent.getServletRequest();
        if(request.getRequestURI().equals("/lxhnovelweb_war_exploded/passage.jsp")){//如果是访问passage.jsp的请求
            //获取bookId和passageNumber
            String bookIdString=request.getParameter("bookId");
            String passageNumberString=request.getParameter("passageNumber");
            Integer bookId= Book.BookStringToBookId(bookIdString);
            Integer passageNumber= Passage.passageNumberStringToPassageNumber(passageNumberString);
            if(bookId==null||passageNumber==null) return;//没有这两个属性,则直接结束
            //判断该文章是否存在
            Passage passage=null;
            try {
                passage=new PassageDAO().getOnePassageByBookIdPassageId(bookId,passageNumber);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            if(passage==null)return;
            //如果文章存在,则改变书籍的阅读次数
            try {
                BookDAO.readTimeAdd(bookId,passageNumber);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
    }
}
