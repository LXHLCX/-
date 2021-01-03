package filter;

import servlet.*;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter(
        servletNames = {
                "servlet.AddBookServlet",
                "servlet.AddPassageServlet",
                "servlet.CheckAccountServlet",
                "servlet.CheckNickServlet",
                "servlet.CheckPasswordServlet",
                "servlet.CollectionServlet",
                "servlet.DeleteAccountServlet",
                "servlet.DeleteBookServlet",
                "servlet.DeleteCollectionServlet",
                "servlet.DeletePassageServlet",
                "servlet.ExportServlet",
                "servlet.LoginServlet",
                "servlet.RegisteredServlet",
                "servlet.UpdateBookServlet"
        }//过滤发往ApplicantLoginServlet的请求
)
public class ChangeEncodingFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        System.out.println("是否进入了过滤器");
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
