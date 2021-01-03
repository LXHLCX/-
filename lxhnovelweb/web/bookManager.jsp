<%--
  Created by IntelliJ IDEA.
  User: 李湘晖
  Date: 2020/12/30
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="bean.Book" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="bean.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.UserDAO" %>
<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%
    User user = null;
    user = (User) session.getAttribute("user");
    if (user == null) {
        out.print("<script type='text/javascript'>");
        out.print("alert('请先登录');");
        out.print("window.location='index.jsp';");
        out.print("</script>");
        return;
    }
    if (user.getAdministrator() == 0) {
        out.print("<script type='text/javascript'>");
        out.print("alert('非管理员不能进入');");
        out.print("window.location='index.jsp';");
        out.print("</script>");
        return;
    }
%>
<!doctype html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta http-equiv="Cache-Control" content="no-transform"/>
    <title>笔趣阁</title>
    <meta name="keywords" content="笔趣阁,新笔趣阁无弹窗,笔趣阁5200,新笔趣阁5200小说网,biquge"/>
    <meta name="description"
          content="笔趣阁是广大书友最值得收藏的网络小说阅读网，新笔趣阁5200网站收录了当前最火热的网络小说，新笔趣阁小说网免费提供高质量的小说最新章节，是广大网络小说爱好者必备的免费小说阅读网。"/>
<%--    <link rel="canonical" href="css/index.css"/>--%>
    <!--<meta name="applicable-device" content="pc">
<meta http-equiv="mobile-agent" content="format=html5; url=https://m.5ibiquge.com/">-->
    <link rel="stylesheet" href="css/index.css"/>
    <script src="js/index.js"></script>
    <script type="text/javascript" src="js/index_two.js"></script>
    <script type="text/javascript" src="js/userPanel.js"></script>
    <script>
        var znsid = '';
    </script>
</head>

<body>
<div id="wrapper">
    <script>
        // login();
    </script>
    <div class="ywtop">
        <div class="ywtop_con"><b><a style="color: red" href="addBook.jsp">添加书籍</a></b>
            <div class="nri">
                <a style="color:red;" href="index.jsp" title="返回主页面">返回主页面</a>
                <a style="color:red;" href="AccountManager.jsp" title="账号管理">账号管理</a>
            </div>
        </div>
    </div>
    <div id="main">
        <div id="hotcontent">
            <div  class="l" style="height: 100%;width: 1043px">
                <%
                    ArrayList<Book> bookArrayList=new BookDAO().getAllBooks();
                    for(Book book:bookArrayList){
                %>
                <div class="item">
                    <div class="image">
                        <a href="<%="directory.jsp?bookId="+book.getBookId()%>"
                           title="<%="笔趣阁 "+book.getBookName()%>"><img src="<%="books/bookCover/"+book.getCover()%>"
                                                                       alt="笔趣阁 元尊" width="120" height="150"
                                                                       onerror="this.src='books/bookCover/nocover.jpg'"/></a>
                    </div>
                    <dl>
                        <dt>
                            <span><%=book.getAuthor()%></span>
                            <a href="<%="directory.jsp?bookId="+book.getBookId()%>"><%=book.getBookName()%></a>
                        </dt>
                        <dd>
                            <div><a href="<%="/lxhnovelweb_war_exploded/DeleteBookServlet?bookId="+book.getBookId()%>" style="color: red">删除书籍</a></div>
                            <div><a href="<%="updateBook.jsp?bookId="+book.getBookId()%>" style="color: red">更改书籍</a></div>
                            <div><a href="<%="passageManager.jsp?bookId="+book.getBookId()%>" style="color: red">章节修改</a></div>
                        </dd>
                    </dl>
                    <div class="clear"></div>
                </div>
                <%
                    }
                %>
                <div class="clear"></div>
            </div>
            <div class="footer">
                <div class="footer_link"></div>
                <div class="footer_cont">
                    <script>
                        footer();
                    </script>
                    <script>
                        var _hmt = _hmt || [];
                        (function () {
                            var hm = document.createElement("script");
                            hm.src = "https://hm.baidu.com/hm.js?e45e25bcd9627f13bb770c5053593286";
                            var s = document.getElementsByTagName("script")[0];
                            s.parentNode.insertBefore(hm, s);
                        })();
                    </script>
                    <script>
                        (function () {
                            var bp = document.createElement('script');
                            var curProtocol = window.location.protocol.split(':')[0];
                            if (curProtocol === 'https') {
                                bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';
                            } else {
                                bp.src = 'http://push.zhanzhang.baidu.com/push.js';
                            }
                            var s = document.getElementsByTagName("script")[0];
                            s.parentNode.insertBefore(bp, s);
                        })();
                    </script>
                    <script>
                        (function () {
                            var src = "https://jspassport.ssl.qhimg.com/11.0.1.js?d182b3f28525f2db83acfaaf6e696dba";
                            document.write('<script src="' + src + '" id="sozz"><\/script>');
                        })();
                    </script>
                </div>
            </div>
        </div>
</body>
</html>