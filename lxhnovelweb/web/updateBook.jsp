<%--
  Created by IntelliJ IDEA.
  User: 李湘晖
  Date: 2020/12/31
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bean.Book" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="bean.User" %>
<%@ page import="java.util.ArrayList" %>
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

    <title>笔趣阁</title>
<%--    <link rel="canonical" href="css/index.css"/>--%>
    <!--<meta name="applicable-device" content="pc">
<meta http-equiv="mobile-agent" content="format=html5; url=https://m.5ibiquge.com/">-->
    <link rel="stylesheet" href="css/index.css"/>
    <script src="js/index.js"></script>
    <script type="text/javascript" src="js/index_two.js"></script>
    <script type="text/javascript" src="js/userPanel.js"></script>
    <link rel="stylesheet" href="css/directory.css"/>
    <script src="js/directory_one.js"></script>
    <script type="text/javascript" src="js/directory_two.js"></script>
    <script type="text/javascript" src="js/directory_three.js"></script>
    <script type="text/javascript" src="js/userPanel.js"></script>
    <script>
        function validate() {
            var headShot = document.getElementById("headShot");
            if (headShot.value == "") {
                alert("请选择要上传的头像！");
                headShot.focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div id="wrapper">
    <script>
        // login();
    </script>
    <div class="ywtop">
        <div class="ywtop_con">
            <div class="nri">
                <a style="color:red;" href="index.jsp" title="返回主页面">返回主页面</a>
                <a style="color:red;" href="AccountManager.jsp" title="账号管理">账号管理</a>
                <a style="color:red;" href="bookManager.jsp" title="书籍管理">书籍管理</a>
            </div>
        </div>
    </div>
    <div class="box_con">
        <%--        <div style="display: inline-block;width: 20%">--%>
        <%--            <div style="display: inline-block;width: 100%;text-align: center;background-color: red">--%>
        <%--                <img src="books/bookCover/nocover.jpg" width="120px" height="150px">--%>
        <%--            </div>--%>
        <%--            <div style="display: inline-block;width: 100%;text-align: center;">--%>

        <%--            </div>--%>
        <%--        </div>--%>
        <%--            通过书籍编号获取书籍--%>
        <%
            String bookIdString = request.getParameter("bookId");
            Integer bookId = Book.BookStringToBookId(bookIdString);
            Book book = null;
            book = new BookDAO().getBookById(bookId);
//              如果没有找到书籍,返回书籍管理页面
            if (book == null) {
                out.print("<script type='text/javascript'>");
                out.print("alert('没有找到书籍');");
                out.print("window.location='bookManager.jsp';");
                out.print("</script>");
                return;
            }
        %>
        <form action="<%="/lxhnovelweb_war_exploded/UpdateBookServlet?bookId="+book.getBookId()%>" method="post"
              enctype="multipart/form-data" onsubmit="return validate();" id="form">
            <div style="display: inline-block;width: 30%;text-align: center">
                <div class="uploade">
                    <div align="center">
                        <img src="<%="books/bookCover/"+book.getCover()%>" id="preview" width="120" height="150">
                        <p>&nbsp;</p>
                        <input name="cover" id="file" type="file" value="上传书籍封面">
                    </div>
                </div>
                <div class="clear"></div>
                <div class="he"></div>
            </div>
            <div style="display: inline-block;width: 65%;height: 100%;">
                <table width="100%">
                    <tr>
                        <td>书名:</td>
                        <td>
                            <input type="text" name="bookName" value="<%=book.getBookName()%>">
                        </td>
                    </tr>
                    <tr>
                        <td>作者:</td>
                        <td>
                            <input type="text" name="author" value="<%=book.getAuthor()%>">
                        </td>
                    </tr>
                    <tr>
                        <td>分类:</td>
                        <td>
                            <select id="classification" name="classification">
                                <%
                                    String[] clssStrings = {"玄幻小说", "修真小说", "都市小说", "历史小说", "网游小说", "科幻小说"};
                                    for (int i = 0; i < clssStrings.length; i++) {
                                        if (book.getClassification() == (i + 1)) {
                                            out.print("<option value=\""+(i+1)+"\" "+"selected"+">"+clssStrings[i]+"</option>");
                                        } else {
                                            out.print("<option value=\""+(i+1)+"\">"+clssStrings[i]+"</option>");
                                        }
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>简介:</td>
                        <td>
                            <textarea rows="10" cols="80" wrap="virtual" name="introduction"
                                      id="introduction"><%=book.getIntroduction()%></textarea>
                        </td>
                    </tr>
                </table>
                <div style="text-align: center">
                    <input type="submit" value="确认更改">
                </div>
            </div>
        </form>
        <script>
            // 选择文件上传控件
            var file = document.querySelector('#file');
            // 选择图片控件
            var preview = document.querySelector('#preview');
            // 当用户选择完文件以后
            file.onchange = function () {
                // 创建文件读取对象
                var reader = new FileReader();
                // 在文件上传控件中有一个 files 属性，代表用户选择的文件列表，files[0] 表示第一个文件
                // 如果加了 multiple 属性上传多个文件的话，files[1] 就是第二个文件，files[2] 就是第三个文件 ...
                // 读取文件
                reader.readAsDataURL(this.files[0]);
                // 监听onload事件
                reader.onload = function () {
                    // 将文件读取的结果显示在页面中
                    preview.src = reader.result;
                }
            }
        </script>
        <div></div>
    </div>
</div>
</body>
</html>