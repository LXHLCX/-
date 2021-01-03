<%@ page import="bean.Book" %>
<%@ page import="utils.DBUtils" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.Passage" %>
<%@ page import="dao.PassageDAO" %>
<%@ page import="bean.User" %>
<%@ page import="dao.CollectionDAO" %>
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
    <title></title>
    <link rel="stylesheet" href="css/directory.css"/>
    <script src="js/directory_one.js"></script>
    <script type="text/javascript" src="js/directory_two.js"></script>
    <script type="text/javascript" src="js/directory_three.js"></script>
    <script type="text/javascript" src="js/userPanel.js"></script>
    <script>
        var bookid = '50721',
            hash = '3ba08c45c5c43049',
            index_rule = '0',
            cindex_rule = '0',
            znsid = '';
    </script>
</head>

<body>
<%
    Integer bookId = null;
    try {
        bookId = Integer.parseInt(request.getParameter("bookId"));
    } catch (Exception e) {
        out.println("书籍不存在");
        out.print("<a href=\"index.jsp\">返回主页面</a>");
        return;
    }
    Book book = null;
    if (bookId == null) {
        out.println("书籍不存在");
        out.print("<a href=\"index.jsp\">返回主页面</a>");
        return;
    } else {
        book = new BookDAO().getBookById(bookId);
        if (book == null) {
            out.println("书籍不存在");
            out.print("<a href=\"index.jsp\">返回主页面</a>");
            return;
        }
    }
%>
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
            <a href="index.jsp" title="笔趣阁"><img src="images/笔趣阁logo.jpg"/></a>
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
    <div class="dvcode"></div>
    <div class="box_con">
        <div id="maininfo">
            <div id="info">
                <div class="booktitle cf">
                    <h1><%=book.getBookName()%>
                    </h1>
                </div>
                <p>作　　者：
                    <%=book.getAuthor()%>
                </p>
                <p>动　　作：
                    <%
                        if (user == null || !CollectionDAO.isCollection(user.getUserId(), book.getBookId())) {
                            String cllectionUrl = "/lxhnovelweb_war_exploded/CollectionServlet?bookId=" + book.getBookId();
                            out.print("<a href=\"" + cllectionUrl + "\" >收藏</a>");
                        } else if (user != null && CollectionDAO.isCollection(user.getUserId(), book.getBookId())) {
                            String cllectionUrl = "/lxhnovelweb_war_exploded/DeleteCollectionServlet?URL=directory.jsp&bookId=" + book.getBookId();
                            out.print("<a href=\"" + cllectionUrl + "\" >取消收藏</a>");
                        }
                    %>
                    ,
                    <a href="#footer">直达底部</a>
                </p>
            </div>
            <div id="intro">
                <%=book.getIntroduction()%>
            </div>
        </div>
        <div id="sidebar">
            <div id="fmimg">
                <img src="<%="books/bookCover/"+book.getCover()%>" width="120" height="150"/>
                <span class="b"></span></div>
        </div>
    </div>
    <div class="box_con">
        <div id="list">
            <dl>
                <dt>《<%=book.getBookName()%>》章节列表</dt>
                <%
                    ArrayList<Passage> passageArrayList = null;
                    passageArrayList = new PassageDAO().getAllPassageById(book.getBookId());
                    if (passageArrayList.size() <= 0) {
                        out.print("<div>还没有内容哦</div>");
                    } else {
                        for (int i = 0; i < passageArrayList.size(); i++) {
                            out.print("<dd><a href=\"");
                            out.print("passage.jsp?bookId=" + passageArrayList.get(i).getBookId() + "&passageNumber=" + passageArrayList.get(i).getPassageNumber());
                            out.print("\" target=\"_blank\">");
                            out.print(passageArrayList.get(i).getPassageName());
                            out.print("</a></dd>");
                        }
                    }
                %>
            </dl>
        </div>
    </div>
    <script id="bdlike_shell"></script>
    <script>
        bdlike();
    </script>
    <div class="dvcode"></div>
    <div id="footer" name="footer">
        <div class="footer_link"></div>
        <div class="footer_cont">
            <p>《
                <a href="https://www.5ibiquge.com/50_50721/" title="笔趣阁-九星霸体诀完整版免费">九星霸体诀完整版免费</a>》情节跌宕起伏、扣人心弦，是一本情节与文笔俱佳的玄幻小说，笔趣阁转载收集
                <a href="https://www.5ibiquge.com/50_50721/" title="九星霸体诀完整版免费最新章节">九星霸体诀完整版免费最新章节</a>、无弹窗阅读。</p>
            <script type="text/javascript">
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
<script id="chapterhtml" type="text/html">
    <dd>
        <a href="/{subid}_{id}/{cid}.html" target="_blank">{title}</a>
    </dd>
</script>
<script type="text/javascript" src="/Public/biquge/js/footer.js?v6.14"></script>
</body>

</html>