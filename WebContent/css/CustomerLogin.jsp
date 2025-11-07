<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<body class="auth" onload="funload()">
<c:set var="activeTab" value="login"/>
<%@ include file="/WEB-INF/jspf/navbar.jspf" %>

<div class="auth-wrapper">
  <div class="auth-card">
    <div class="auth-header">
      <h1 class="auth-title">Welcome back</h1>
      <p class="auth-sub">Login to access your account</p>
    </div>
    <div class="auth-body">
      <form action="userlog" method="post" onsubmit="checkform()" id="theform">
        <div class="form-group">
          <label class="form-label" for="userName">Email or Username</label>
          <input class="form-control" type="text" name="username" id="userName" placeholder="you@example.com" required>
        </div>
        <div class="form-group">
          <label class="form-label" for="Password">Password</label>
          <input class="form-control" type="password" name="password" id="Password" placeholder="••••••••" required>
        </div>
        <div class="d-flex align-items-center justify-content-between mb-2 helper-links">
          <a href="SellerLogin.jsp">Login as Admin</a>
          <a href="CustomerRegister.jsp">New user? Register</a>
        </div>
        <div class="mb-3">
          <div class="capbox">
            <div id="CaptchaDiv">46749</div>
            <div class="capbox-inner">
              <input type="hidden" id="txtCaptcha" value="46749">
              <input class="form-control" style="display:inline-block;width:auto" type="text" name="CaptchaInput" id="CaptchaInput" size="10" placeholder="Captcha">
            </div>
          </div>
        </div>
        <button class="btn btn-gradient btn-block py-2" type="submit">Sign in</button>
      </form>
    </div>
    <div class="auth-footer">&copy; Book Store</div>
  </div>
  
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
<script type="text/javascript">
  function checkform(){
    var theform = document.getElementById('theform');
    var why = '';
    if (theform.CaptchaInput.value == '') { why += '- Please Enter CAPTCHA Code.\n'; }
    if (theform.CaptchaInput.value != '') {
      if (ValidCaptcha(theform.CaptchaInput.value) == false) { why += '- The CAPTCHA Code Does Not Match.\n'; }
    }
    if (why != '') { alert(why); event.preventDefault(); return false; }
    return true;
  }
  function ValidCaptcha(){
    var str1 = removeSpaces(document.getElementById('txtCaptcha').value);
    var str2 = removeSpaces(document.getElementById('CaptchaInput').value);
    return str1 == str2;
  }
  function removeSpaces(s){ return s.split(' ').join(''); }
  // generate captcha
  (function(){
    var a=Math.ceil(Math.random()*9)+'';
    var b=Math.ceil(Math.random()*9)+'';
    var c=Math.ceil(Math.random()*9)+'';
    var d=Math.ceil(Math.random()*9)+'';
    var e=Math.ceil(Math.random()*9)+'';
    var code=a+b+c+d+e;
    document.getElementById('txtCaptcha').value=code;
    document.getElementById('CaptchaDiv').innerHTML=code;
  })();
</script>
</body>
</html>
