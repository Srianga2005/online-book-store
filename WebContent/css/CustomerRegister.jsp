<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<body class="auth" onload="funload()">
<c:set var="activeTab" value="register"/>
<%@ include file="/WEB-INF/jspf/navbar.jspf" %>

<div class="auth-wrapper">
  <div class="auth-card">
    <div class="auth-header">
      <h1 class="auth-title">Create your account</h1>
      <p class="auth-sub">Fill in the details to get started</p>
    </div>
    <div class="auth-body">
      <form action="userreg" method="post">
        <div class="form-group">
          <label class="form-label" for="Email">Email</label>
          <input class="form-control" type="email" name="mailid" id="Email" placeholder="you@example.com" required>
        </div>
        <div class="form-group">
          <label class="form-label" for="passWord">Password</label>
          <input class="form-control" type="password" name="password" id="passWord" placeholder="••••••••" required>
        </div>
        <div class="form-row">
          <div class="form-group col-md-6">
            <label class="form-label" for="firstName">First name</label>
            <input class="form-control" type="text" name="firstname" id="firstName" placeholder="First name" required>
          </div>
          <div class="form-group col-md-6">
            <label class="form-label" for="lastName">Last name</label>
            <input class="form-control" type="text" name="lastname" id="lastName" placeholder="Last name" required>
          </div>
        </div>
        <div class="form-group">
          <label class="form-label" for="address">Address</label>
          <textarea class="form-control" name="address" id="address" placeholder="Enter your address" rows="3" required></textarea>
        </div>
        <div class="form-group">
          <label class="form-label" for="phno">Mobile number</label>
          <input class="form-control" type="text" name="phone" id="phno" placeholder="1234567890" required>
        </div>
        <div class="form-group form-check">
          <input type="checkbox" class="form-check-input" id="acceptance" name="acceptance" required>
          <label class="form-check-label" for="acceptance">I accept all Terms &amp; Conditions</label>
        </div>
        <button class="btn btn-gradient btn-block py-2" type="submit">Create account</button>
      </form>
    </div>
    <div class="auth-footer">Already have an account? <a href="CustomerLogin.jsp">Sign in</a></div>
  </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
