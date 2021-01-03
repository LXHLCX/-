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
    if(user==null){
        out.print("<script type='text/javascript'>");
        out.print("alert('请先登录');");
        out.print("window.location='index.jsp';");
        out.print("</script>");
        return;
    }
    if(user.getAdministrator()==0){
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
        <div class="ywtop_con"><b>公告：</b>书友们，“笔趣阁”最新域名“www.5ibiquge.com”。请您牢记本站网址并加入收藏，手机也可直接访问，会自动进入手机站！
            <div class="nri">
                <a  style="color:red;" href="index.jsp" title="返回主页面">返回主页面</a>
                <a  style="color:red;" href="bookManager.jsp" title="书籍管理">书籍管理</a>
            </div>
        </div>
    </div>
    <div id="main">
        <div id="hotcontent">
            <div class="l">
                <%
                    ArrayList<User> userArrayList= UserDAO.getNotAdministorUsers();
                %>
                <table border="4px" cellpadding="10px" id="showAccount" style="color: black;" width="100%">
                    <%
                        for(User temp:userArrayList){
                    %>
                    <tr>
                        <td style="font-size: 20px;padding: 4px" >
                            账号:<%=temp.getUserId()%>
                        </td>
                        <td style="font-size: 20px;padding: 4px" >
                            密码:<%=temp.getPassword()%>
                        </td>
                        <td style="font-size: 20px;padding: 4px" >
                            昵称:<%=temp.getNickName()%>
                        </td>
                        <td style="font-size: 20px;padding: 4px" >
                            <a href="<%="/lxhnovelweb_war_exploded/DeleteAccountServlet?userId="+temp.getUserId()%>">删除</a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </table>
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
