<%@ page import="bean.Book" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="bean.User" %>
<%@ page import="java.util.ArrayList" %>
<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%
    User user = null;
    user = (User) session.getAttribute("user");
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

    <!--<meta name="applicable-device" content="pc">
<meta http-equiv="mobile-agent" content="format=html5; url=https://m.5ibiquge.com/">-->
    <link rel="stylesheet" type='text/css' href="css/index.css"/>
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
        <%--        <div class="header_search" >--%>
        <%--            <form name="form" method="post" action="" id="sform" target="_blank"><input type="hidden"--%>
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
            %>
            <div>账号:${user.userId}</div>
            <div>昵称:${user.nickName}</div>
            <div><a href="/lxhnovelweb_war_exploded/ExportServlet">退出</a></div>
            <%
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
            <div class="l">
                <%
                    ArrayList<Book> mixBooks = new BookDAO().getANumberOfBooksByClassification(6, 0);
                    for (Book book : mixBooks) {
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
                            <a href="/0_949/"><%=book.getBookName()%>
                            </a>
                        </dt>
                        <dd>
                            <%=book.getIntroduction()%>
                        </dd>
                    </dl>
                    <div class="clear"></div>
                </div>
                <%
                    }
                %>
            </div>
            <div class="r">
                <h2>
                    人气小说榜
                </h2>

                <ul>
                    <%
                        ArrayList<Book> hotBook = new BookDAO().getAllBooksOrderByReadTimesLimitFourteen();
                        String[] classifications = {"玄幻", "修真", "都市", "历史", "网游", "科幻"};
                        for (Book book : hotBook) {
                    %>
                    <li>
                        <span class="s1"><%=classifications[book.getClassification() - 1]%></span>
                        <span class="s2"><a
                                href="<%="directory.jsp?bookId="+book.getBookId()%>"><%=book.getBookName()%></a></span>
                        <span class="s5"><%=book.getAuthor()%></span>
                    </li>
                    <%
                        }
                    %>
                </ul>

            </div>
            <div class="clear"></div>
        </div>
        <div id="novelslist1" class="novelslist">
            <div class="content">
                <h2>玄幻小说</h2>
                <ul class="cf">
                    <%
                        ArrayList<Book> xuanhuan = new BookDAO().getANumberOfBooksByClassification(4, 1);
                        for (Book book : xuanhuan) {
                    %>
                    <li>
                        <a href="<%="directory.jsp?bookId="+book.getBookId()%>"><%=book.getBookName()%>
                        </a> /
                        <%=book.getAuthor()%>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <div class="content">
                <h2>修真小说</h2>
                <ul class="cf">
                    <%
                        ArrayList<Book> xiuzheng = new BookDAO().getANumberOfBooksByClassification(4, 2);
                        for (Book book : xiuzheng) {
                    %>
                    <li>
                        <a href="<%="directory.jsp?bookId="+book.getBookId()%>"><%=book.getBookName()%>
                        </a> /
                        <%=book.getAuthor()%>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <div class="content border">
                <h2>都市小说</h2>
                <ul class="cf">
                    <%
                        ArrayList<Book> dushi = new BookDAO().getANumberOfBooksByClassification(4, 3);
                        for (Book book : dushi) {
                    %>
                    <li>
                        <a href="<%="directory.jsp?bookId="+book.getBookId()%>"><%=book.getBookName()%>
                        </a> /
                        <%=book.getAuthor()%>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <div class="clear"></div>
        </div>
        <div id="novelslist2" class="novelslist">
            <div class="content">
                <h2>历史小说</h2>
                <ul class="cf">
                    <%
                        ArrayList<Book> lishi = new BookDAO().getANumberOfBooksByClassification(4, 4);
                        for (Book book : lishi) {
                    %>
                    <li>
                        <a href="<%="directory.jsp?bookId="+book.getBookId()%>"><%=book.getBookName()%>
                        </a> /
                        <%=book.getAuthor()%>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <div class="content">
                <h2>网游小说</h2>
                <ul class="cf">
                    <%
                        ArrayList<Book> wangyou = new BookDAO().getANumberOfBooksByClassification(4, 5);
                        for (Book book : wangyou) {
                    %>
                    <li>
                        <a href="<%="directory.jsp?bookId="+book.getBookId()%>"><%=book.getBookName()%>
                        </a> /
                        <%=book.getAuthor()%>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <div class="content border">
                <h2>科幻小说</h2>
                <ul class="cf">
                    <%
                        ArrayList<Book> kehuang = new BookDAO().getANumberOfBooksByClassification(4, 6);
                        for (Book book : kehuang) {
                    %>
                    <li>
                        <a href="<%="directory.jsp?bookId="+book.getBookId()%>"><%=book.getBookName()%>
                        </a> /
                        <%=book.getAuthor()%>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <div class="clear">
            </div>
        </div>
        <div id="firendlink">
            友情连接：
            <a href="index.jsp" target="_blank">笔趣阁</a>
        </div>
        <div class="footer">
            <div class="footer_link"></div>
            <div class="footer_cont">
                <script>
                    // footer();
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
</div>
</body>

</html>