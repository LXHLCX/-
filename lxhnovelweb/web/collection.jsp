<%--
  Created by IntelliJ IDEA.
  User: 李湘晖
  Date: 2020/12/30
  Time: 9:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="bean.Book" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="bean.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.Collection" %>
<%@ page import="dao.CollectionDAO" %>
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
        <div class="ywtop_con"><b>公告：</b>书友们，“笔趣阁”最新域名“www.5ibiquge.com”。请您牢记本站网址并加入收藏，手机也可直接访问，会自动进入手机站！
            <div class="nri">
                <a id="translatelink" style="color:red;" href="bookManager.jsp" title="管理员">管理员</a>
            </div>
        </div>
    </div>
    <div class="header">
        <div class="header_logo">
            <a href="index.jsp" title="笔趣阁"><img src="images/笔趣阁logo.jpg" width="240"/></a>
        </div>
        <script>
            // panel();
        </script>
<%--        <div class="header_search">--%>
<%--            <form name="form" method="post" action="/home/search" id="sform" target="_blank"><input type="hidden"--%>
<%--                                                                                                    name="action"--%>
<%--                                                                                                    value="search"><input--%>
<%--                    type="text" placeholder="可搜书名，请您少字也别输错字" value="" name="q" class="search" id="wd" baidusug="2">--%>
<%--                <button id="sss" type="submit"> 搜 索</button>--%>
<%--            </form>--%>
<%--        </div>--%>
        <div class="userpanel">&nbsp;
            <%
                if (user == null) {
                    out.print("<form action=\"/lxhnovelweb_war_exploded/LoginServlet\" method=\"post\" id=\"loginForm\" style=\"display: inline\">\n" +
                            "\t\t\t\t\t\t<div>账号: <input type=\"text\" name=\"userId\"></div>\n" +
                            "\t\t\t\t\t\t<div>密码: <input type=\"password\" name=\"password\"></div>\n" +
                            "\t\t\t\t\t\t<div>\n" +
                            "\t\t\t\t\t\t\t<input type=\"submit\" value=\"登录\">\n" +
                            "\t\t\t\t\t\t\t<input type=\"button\" value=\"去注册\" onclick=\"goRegister();\">\n" +
                            "\t\t\t\t\t\t</div>\n" +
                            "\t\t\t\t\t</form>\n" +
                            "\t\t\t\t\t<form action=\"/lxhnovelweb_war_exploded/RegisteredServlet\" method=\"post\" id=\"registerForm\" style=\"display:none\">\n" +
                            "\t\t\t\t\t\t<div>昵称: <input type=\"text\" name=\"nickName\" onblur=\"ajaxValidate('CheckNickServlet',this,'label_one','nickName')\"></div>\n" +
                            "\t\t\t\t\t\t<div><label style=\"color:red\" id=\"label_one\"></label></div>\n" +
                            "\t\t\t\t\t\t<div>账号: <input type=\"text\" name=\"userId\" onblur=\"ajaxValidate('CheckAccountServlet',this,'label_two','account')\"></div>\n" +
                            "\t\t\t\t\t\t<div><label style=\"color:red\" id=\"label_two\"></label></div>\n" +
                            "\t\t\t\t\t\t<div>密码: <input type=\"password\" name=\"password\" id=\"\" onblur=\"ajaxValidate('CheckPasswordServlet',this,'label_three','password')\"></div>\n" +
                            "\t\t\t\t\t\t<div><label style=\"color:red\" id=\"label_three\"></label></div>\n" +
                            "\t\t\t\t\t\t<div>\n" +
                            "\t\t\t\t\t\t\t<input type=\"submit\" value=\"注册\">\n" +
                            "\t\t\t\t\t\t\t<input type=\"button\" value=\"去登录\" onclick=\"goLogin();\">\n" +
                            "\t\t\t\t\t\t</div>\n" +
                            "\t\t\t\t\t</form>\n");
                } else {
                    out.print("<div>账号:");
                    out.print(user.getUserId());
                    out.print("</div>\n" +
                            "\t\t\t\t\t<div>昵称:");
                    out.print(user.getNickName());
                    out.print("</div>");
                    out.print("<div><a href=\"/lxhnovelweb_war_exploded/ExportServlet\">退出</a></div>");
                }
            %>

        </div>
    </div>
    <p id="dividion" style="height: 150px"></p>
    <div class="nav">
        <ul>
            <li>
                <a href="index.jsp" title="笔趣阁">笔趣阁</a>
            </li>
            <li>
                <a href="classification.jsp?classification=1">玄幻小说</a>
            </li>
            <li>
                <a href="classification.jsp?classification=2">修真小说</a>
            </li>
            <li>
                <a href="classification.jsp?classification=3">都市小说</a>
            </li>
            <li>
                <a href="classification.jsp?classification=4">历史小说</a>
            </li>
            <li>
                <a href="classification.jsp?classification=5">网游小说</a>
            </li>
            <li>
                <a href="classification.jsp?classification=6">科幻小说</a>
            </li>
            <li>
                <a href="collection.jsp">我的收藏</a>
            </li>
        </ul>
    </div>
    <div id="main">
        <div id="hotcontent">
            <div class="l" style="height: 100%;width: 1043px">
                <%
                    ArrayList<Collection> collectionArrayList = null;
                    collectionArrayList = CollectionDAO.getAllCollection(user.getUserId());
                    Book tempBook = null;
                    for (int i=0;i<collectionArrayList.size();i++) {
                        tempBook = new BookDAO().getBookById(collectionArrayList.get(i).getBookId());
                %>
                <div class="item">
                    <div class="image">
                        <a href="<%="directory.jsp?bookId="+tempBook.getBookId()%>"
                           title="<%="笔趣阁 "+tempBook.getBookName()%>"><img
                                src="<%="books/bookCover/"+tempBook.getCover()%>"
                                alt="笔趣阁 元尊" width="120" height="150"
                                onerror="this.src='books/bookCover/nocover.jpg'"/></a>
                    </div>
                    <dl>
                        <dt>
                            <span><%=tempBook.getAuthor()%></span>
                            <a href="<%="directory.jsp?bookId="+tempBook.getBookId()%>"><%=tempBook.getBookName()%></a>
                            &nbsp;&nbsp;<a style="color: red" href="<%="/lxhnovelweb_war_exploded/DeleteCollectionServlet?URL=collection.jsp&bookId="+tempBook.getBookId()%>">取消收藏</a>
                        </dt>
                        <dd>
                            <%=tempBook.getIntroduction()%>
                        </dd>
                    </dl>
                    <div class="clear"></div>
                </div>
                <%
                    }
                %>
            </div>
            <div class="clear"></div>
        </div>

        <div id="firendlink">
            友情连接：
            <a href="index.jsp" target="_blank">笔趣阁</a>
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