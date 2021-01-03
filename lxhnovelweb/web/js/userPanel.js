window.onload = function() {
    $("#registerForm").css("display", "none");
    $("#loginForm").css("display", "inline");
}

function goRegister() {
    $("#registerForm").css("display", "inline");
    $("#loginForm").css("display", "none");
}

function goLogin() {
    $("#registerForm").css("display", "none");
    $("#loginForm").css("display", "inline");
}
var xhr = false;

function createXHR() {
    try {
        xhr = new XMLHttpRequest();
    } catch(e) {
        try {
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        } catch(e1) {
            xhr = false;
        }
    }
    if(!xhr)
        alert("初始化XMLHttpRequest对象失败");
}

function ajaxValidate(url, Obj, idname, part) {//参数分别为发送地址,从何处获取要检测的值,返回信息发送到哪,获取的值的名称
    createXHR();
    var content = "type=emailAjaxValidate&" + part + "=" + Obj.value;
    xhr.open("POST", url, true);
    xhr.onreadystatechange = function() {
        if(xhr.readyState == 4 && xhr.status == 200) {
            document.getElementById(idname).innerHTML = xhr.responseText;
        }
    };
    xhr.setRequestHeader("Content-Length", content.length);
    xhr.setRequestHeader("CONTENT-TYPE", "application/x-www-form-urlencoded");
    xhr.send(content);
}