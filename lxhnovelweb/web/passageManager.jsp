<%--
  Created by IntelliJ IDEA.
  User: 李湘晖
  Date: 2020/12/31
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
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
        out.print("<a href=\"bookManager.jsp\">返回主页面</a>");
        return;
    }
    Book book = null;
    if (bookId == null) {
        out.println("书籍不存在");
        out.print("<a href=\"bookManager.jsp\">返回主页面</a>");
        return;
    } else {
        book = new BookDAO().getBookById(bookId);
        if (book == null) {
            out.println("书籍不存在");
            out.print("<a href=\"bookManager.jsp\">返回主页面</a>");
            return;
        }
    }
%>
<div id="wrapper">
    <div class="ywtop">
        <div class="ywtop_con">
            <div class="nri">
                <a style="color:red;" href="index.jsp" title="返回主页面">返回主页面</a>
                <a style="color:red;" href="AccountManager.jsp" title="账号管理">账号管理</a>
                <a style="color:red;" href="bookManager.jsp" title="书籍管理">书籍管理</a>
            </div>
        </div>
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
        <form action="<%="/lxhnovelweb_war_exploded/AddPassageServlet?bookId="+book.getBookId()%>" method="post"
              enctype="multipart/form-data" onsubmit="return validate();" id="form">
            <input name="newPassage" id="file" type="file" value="选择新一章的txt文档">
            <p style="display: inline-block">章节名:</p><input type="text" name="passageName">
            <input type="submit" value="确认添加新章节">
        </form>
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
                %>
                <dd>
                    <a href="<%="passage.jsp?bookId="+passageArrayList.get(i).getBookId()+"&passageNumber="+passageArrayList.get(i).getPassageNumber()%>"
                       target="_blank">
                        <%=passageArrayList.get(i).getPassageName()%>
                    </a>
                    <a style="color: red" href="<%="/lxhnovelweb_war_exploded/DeletePassageServlet?bookId="+passageArrayList.get(i).getBookId()+"&passageNumber="+passageArrayList.get(i).getPassageNumber()%>">
                        删除
                    </a>

                </dd>
                <%
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
