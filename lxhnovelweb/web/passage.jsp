<%@ page import="java.io.*" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="bean.Book" %>
<%@ page import="bean.Passage" %>
<%@ page import="dao.PassageDAO" %>
<%@ page import="utils.SearchPassagePosition" %>
<%@ page import="bean.User" %>
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
    <!--<meta name="keywords" content="第三章 苏幼微,元尊,元尊笔趣阁" />
    <meta name="description" content="笔趣阁提供了天蚕土豆创作的玄幻小说《元尊》干净清爽无错字的文字章节： 第三章 苏幼微在线阅读。" />
    <link rel="canonical" href="https://www.5ibiquge.com/0_949/6.html" />
    <meta name="applicable-device" content="pc">
    <meta http-equiv="mobile-agent" content="format=html5; url=https://m.5ibiquge.com/0_949/6.html">-->
    <link rel="stylesheet" href="css/passage.css"/>
    <script src="js/passage_one.js"></script>
    <script type="text/javascript" src="js/passage_two.js"></script>
    <script type="text/javascript" src="js/passage_three.js"></script>
    <script type="text/javascript" src="js/passage_four.js"></script>
    <script type="text/javascript" src="js/iframejs.js"></script>
    <script type="text/javascript" src="js/userPanel.js"></script>
    <script>
        var znsid = '';
    </script>
    <style>
        #source {
            display: none;
        }

        html,
        #source {
            width: 100%;
            height: 100%;
        }

        #ifexplorer {
            width: 976px;
            margin: 0 auto;
        }

        .to_nextpage {
            text-align: center;
        }

        .to_nextpage a {
            margin-left: -2em;
            font-weight: bold;
            color: #a94442;
        }

        #mainFrame pre {
            color: red;
        }

    </style>
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
            out.print("<a href=\"index.hsp\">返回主页面</a>");
            return;
        }
    }
    Integer passageNumber = null;
    try {

        passageNumber = Integer.parseInt(request.getParameter("passageNumber"));

    } catch (Exception e) {
        out.println("该章节不存在");
        out.print("<a href=\"directory.jsp?bookId=" + book.getBookId() + "\">返回目录</a>");
        return;
    }
    Passage passage = null;
    if (passageNumber == null) {
        out.println("章节不存在");
        out.print("<a href=\"directory.jsp?bookId=" + book.getBookId() + "\">返回目录</a>");
        return;
    } else {
        System.out.println("斯柯达就好了收到就好你看是打飞机那棵树的就好了可视对讲海枯石烂带回家看到社会健康");
        int temp = passageNumber;
        passage = new PassageDAO().getOnePassageByBookIdPassageId(book.getBookId(), temp);
        System.out.println("可能觉得反馈时间很可能是回家啦上课很多人瘦客户机但是客户");
        if (passage == null) {
            out.println("该章节不存在");
            out.print("<a href=\"directory.jsp?bookId=" + book.getBookId() + "\">返回目录</a>");
            return;
        }
    }
    Passage lastPassage = SearchPassagePosition.getLastPassage(passage);
    Passage nextPassage = SearchPassagePosition.getNextPassage(passage);
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
    <div class="content_read">
        <div class="box_con">
            <div class="con_top">
                <script>
                    textselect();
                </script>
                <a href="https://www.5ibiquge.com/">笔趣阁</a> &gt;
                <a href="<%="directory.jsp?bookId="+book.getBookId()%>"><%=book.getBookName()%>
                </a> &gt;
                <a href="<%="passage.jsp?bookId="+passage.getBookId()+"&passageNumber="+passage.getPassageNumber()%>"><%=passage.getPassageName()%>
                </a>
            </div>

            <div class="bookname">
                    <h1><%=passage.getPassageName()%>
                </h1>
                <div class="bottem1">
                    <a href="<%="passage.jsp?bookId="+lastPassage.getBookId()+"&passageNumber="+lastPassage.getPassageNumber()%>"
                       rel="next">上一章</a> &larr;
                    <a href="<%="directory.jsp?bookId="+passage.getBookId()%>" rel="index">章节列表</a> &rarr;
                    <a href="<%="passage.jsp?bookId="+nextPassage.getBookId()+"&passageNumber="+nextPassage.getPassageNumber()%>"
                       rel="next">下一章</a>
                </div>
            </div>
            <div id="ifexplorer">
                <iframe src="about:blank" id="source" width="100%" frameborder="no" border="0" marginwidth="0"
                        marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>
            </div>
            <div id="content">
                <%--				<iframe src="books/元尊一张.txt" scrolling="no" width="100%" height="100%" frameborder="0" id="mainFrame" onload='IFrameReSize("mainFrame");IFrameReSizeWidth("mainFrame");'>--%>
                <%--				</iframe>--%>
                <a href="books/"></a>
                <%
                    File file = new File(request.getServletContext().getRealPath("/books")+"/"+book.getBookId()+"/"+passage.getPassagePosition());
                    if(!file.exists()){
                        out.print("<script type='text/javascript'>");
                        out.print("alert('抱歉,文件丢失');");
                        out.print("window.location='index.jsp';");
                        out.print("</script>");
                        return;
                    }
                    System.out.println(file);
                    InputStreamReader inputStreamReader = new InputStreamReader(new FileInputStream(file), "UTF-8");
                    char[] chars = new char[100];
                    int length = 0;
                %>
                <pre style="color: red;font-size: 20px;font: '宋体';word-wrap: break-word; white-space: pre-wrap;">
					<%
                        while ((length = inputStreamReader.read(chars)) > 0) {
                            for (int i = 0; i < length; i++) {
                                out.print(chars[i]);
                                System.out.print(chars[i]);
                            }
                        }
                    %>
				</pre>
            </div>
            <script>
                bdshare();
            </script>
            <div class="bottem2">
                <a href="<%="passage.jsp?bookId="+lastPassage.getBookId()+"&passageNumber="+lastPassage.getPassageNumber()%>"
                   rel="next">上一章</a> &larr;
                <a href="<%="directory.jsp?bookId="+passage.getBookId()%>" rel="index">章节列表</a> &rarr;
                <a href="<%="passage.jsp?bookId="+nextPassage.getBookId()+"&passageNumber="+nextPassage.getPassageNumber()%>"
                   rel="next">下一章</a>
            </div>
        </div>
    </div>
    <div class="footer">
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
<script>
    var preview_page = "/0_949/5.html";
    var next_page = "/0_949/7.html";
    var index_page = "/0_949/";
    var article_id = "949";
    var chapter_id = "6";
    var nextcid = "7";
    var prevcid = "5";
    var articlename = "元尊";
    var chaptername = "第三章 苏幼微";
    var hash = "a91f7e2ad311f390";
    var localpre = "www.5ibiquge.com";
    var preloadhtml = $('#content').html();
    var sourceurl = "https://www.sbiquge.com/18_18507/9966242.html";
    lastread.set(article_id, chapter_id, articlename, chaptername, '天蚕土豆', '玄幻小说', '0');
</script>
<script src="/Public/biquge/js/chapter.js?v6.14"></script>
</body>

</html>