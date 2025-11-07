<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/jspf/header.jspf" />
<body class="auth" onload="funload()">
<c:set var="activeTab" value="home"/>
<jsp:include page="/WEB-INF/jspf/navbar.jspf" />
<section class="auth-wrapper" style="padding-top:40px;">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-10">
        <div class="auth-card">
          <div class="auth-header" style="text-align:center;">
            <h1 class="auth-title">Welcome, <c:out value="${sessionScope.user.firstName}" default="Customer"/>!</h1>
            <p class="auth-sub">What would you like to do today?</p>
          </div>
          <div class="auth-body">
            <div class="row">
              <div class="col-md-4 mb-3">
                <div class="card" style="background:#0b1220;border:1px solid rgba(255,255,255,.08);border-radius:12px;">
                  <div class="card-body text-center">
                    <h5 class="card-title" style="color:#fff;">Available Books</h5>
                    <p class="card-text" style="color:#9ca3af;">Browse and add to your cart</p>
                    <a href="viewbook" class="btn btn-gradient">Browse Books</a>
                  </div>
                </div>
              </div>
              <div class="col-md-4 mb-3">
                <div class="card" style="background:#0b1220;border:1px solid rgba(255,255,255,.08);border-radius:12px;">
                  <div class="card-body text-center">
                    <h5 class="card-title" style="color:#fff;">Cart</h5>
                    <p class="card-text" style="color:#9ca3af;">Review items in your cart</p>
                    <a href="cart" class="btn btn-gradient">Open Cart</a>
                  </div>
                </div>
              </div>
              <div class="col-md-4 mb-3">
                <div class="card" style="background:#0b1220;border:1px solid rgba(255,255,255,.08);border-radius:12px;">
                  <div class="card-body text-center">
                    <h5 class="card-title" style="color:#fff;">Logout</h5>
                    <p class="card-text" style="color:#9ca3af;">Sign out of your account</p>
                    <a href="logout" class="btn btn-outline-light" style="border-radius:10px;">Logout</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<jsp:include page="/WEB-INF/jspf/footer.jspf" />
</body>
</html>
