<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<body class="auth" onload="funload()">
<c:set var="activeTab" value="home"/>
<%@ include file="/WEB-INF/jspf/navbar.jspf" %>

<section class="auth-wrapper" style="padding-top:40px;">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-8">
        <div class="auth-card" style="text-align:center;">
          <div class="auth-header">
            <h1 class="auth-title">Welcome to Online Book Store</h1>
            <p class="auth-sub">Discover, learn, and shop your favorite books</p>
          </div>
          <div class="auth-body">
            <div class="d-flex flex-wrap justify-content-center gap-2">
              <a class="btn btn-gradient px-4 py-2 m-2" href="CustomerLogin.jsp">Customer Login</a>
              <a class="btn btn-outline-light px-4 py-2 m-2" href="CustomerRegister.jsp" style="border-radius:10px;">Register</a>
              <a class="btn btn-outline-light px-4 py-2 m-2" href="SellerLogin.jsp" style="border-radius:10px;">Admin Login</a>
              <a class="btn btn-outline-light px-4 py-2 m-2" href="viewbook" style="border-radius:10px;">Browse Books</a>
              <a class="btn btn-outline-light px-4 py-2 m-2" href="about" style="border-radius:10px;">About Us</a>
            </div>
          </div>
          <div class="auth-footer">Happy Learning!!</div>
        </div>
      </div>
    </div>
  </div>
  
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
