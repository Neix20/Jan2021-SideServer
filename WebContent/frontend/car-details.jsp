<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <link
    href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap"
    rel="stylesheet">

  <title>Product Detals</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/frontend/assets/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/frontend/assets/css/font-awesome.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/assets/css/style.css">

  <!-- jQuery -->
  <script src="${pageContext.request.contextPath}/frontend/assets/js/jquery-2.1.0.min.js"></script>

  <!-- Bootstrap -->
  <script src="${pageContext.request.contextPath}/frontend/assets/js/popper.js"></script>
  <script src="${pageContext.request.contextPath}/frontend/assets/js/bootstrap.min.js"></script>

  <style>
    /* Chrome, Safari, Edge, Opera */
    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
      -webkit-appearance: none;
      margin: 0;
    }

    /* Firefox */
    input[type=number] {
      -moz-appearance: textfield;
    }
  </style>

  <script>
    $(function () {
      $(".plus").on("click", e => {
        let num = $(e.target).siblings("input[type=number]").val(),
          max_limit = parseInt($(e.target).siblings("input[type=number]").attr("max")),
          min_limit = parseInt($(e.target).siblings("input[type=number]").attr("min"));
        (num >= max_limit) ? $(e.target).prop("disabled", true) : $(e.target).siblings("input[type=number]").val(++num);
        if (num >= min_limit) $(e.target).siblings(".minus").prop("disabled", false);
      });

      $(".minus").on("click", e => {
        let num = $(e.target).siblings("input[type=number]").val(),
          max_limit = parseInt($(e.target).siblings("input[type=number]").attr("max")),
          min_limit = parseInt($(e.target).siblings("input[type=number]").attr("min"));
        (num <= min_limit) ? $(e.target).prop("disabled", true) : $(e.target).siblings("input[type=number]").val(--num);
        if (num <= max_limit) $(e.target).siblings(".plus").prop("disabled", false);
      });

      $(".buy_quantity").on("keypress", e => {
        if (e.keyCode == 13) {
          let num = $(e.target).val(), max_limit = parseInt($(e.target).attr("max")), min_limit = parseInt($(e.target).attr("min"));
          if (num > max_limit) $(e.target).siblings(".plus").prop("disabled", true);
          if (num < min_limit) $(e.target).siblings(".minus").prop("disabled", true);
          if (num >= min_limit) $(e.target).siblings(".minus").prop("disabled", false);
          if (num <= max_limit) $(e.target).siblings(".plus").prop("disabled", false);
        }
      });

    });
    function notifyMe() {
      if (!("Notification" in window)) {
        alert("This browser does not support desktop notification");
      }
      else if (Notification.permission === "granted") {
        let notification = new Notification('Product has been successfully added to shopping cart!');
      }
      else if (Notification.permission !== "denied") {
        Notification.requestPermission().then(function (permission) {
          if (permission === "granted") {
            let notification = new Notification('Product has been successfully added to shopping cart!');
          }
        });
      }
    }
    notifyMe();
  </script>
</head>

<body>

  <!-- ***** Preloader Start ***** -->
  <div id="js-preloader" class="js-preloader">
    <div class="preloader-inner">
      <span class="dot"></span>
      <div class="dots">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>
  </div>
  <!-- ***** Preloader End ***** -->

  <!-- ***** Header Area Start ***** -->
  <header class="header-area header-sticky">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <nav class="main-nav">
            <!-- ***** Logo Start ***** -->
            <a href="index.html" class="logo">Vehicle Models<em> Website</em></a>
            <!-- ***** Logo End ***** -->
            <!-- ***** Menu Start ***** -->
            <ul class="nav">
              <li><a href="index.html">Home</a></li>
              <li><a href="productCatalog.jsp">Vehicle Models</a></li>
              <li><a href="ShoppingCart.jsp">Shopping Cart</a></li>
              <li><a href="contact.html">Contact</a></li>
            </ul>
            <a class='menu-trigger'>
              <span>Menu</span>
            </a>
            <!-- ***** Menu End ***** -->
          </nav>
        </div>
      </div>
    </div>
  </header>
  <!-- ***** Header Area End ***** -->

  <!-- ***** Call to Action Start ***** -->
  <section class="section section-bg" id="call-to-action"
    style="background-image: url(frontend/assets/images/banner-image-1-1920x500.jpg)">
    <div class="container">
      <div class="row">
        <div class="col-lg-10 offset-lg-1">
          <div class="cta-content">
            <br>
            <br>
            <h2>Product<em> Details</em></h2>
            <p>Ut consectetur, metus sit amet aliquet placerat, enim est ultricies ligula</p>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- ***** Call to Action End ***** -->

  <!--Section: Block Content-->
  <div class="container pt-5">
    <div class="row">
      <!--Images-->
      <div class="col-md-6 mb-4 mb-md-0">
        <img src="${pageContext.request.contextPath}/frontend/assets/images/Classic_1.jpg" style="width: 100%;" />
      </div>

      <!--Put into div class= container-->
      <div class="col-md-6">

        <h5>Fantasy T-shirt</h5>
        <p><span class="mr-1"><strong>$12.99</strong></span></p>
        <p class="pt-1">Lorem ipsum dolor sit amet consectetur adipisicing elit. Numquam, sapiente illo. Sit
          error voluptas repellat rerum quidem, soluta enim perferendis voluptates laboriosam. Distinctio,
          officia quis dolore quos sapiente tempore alias.</p>
        <div class="table-responsive">
          <table class="table table-sm table-borderless mb-0">
            <tbody>
              <tr>
                <th class="pl-0 w-25" scope="row"><strong>Model</strong></th>
                <td>Shirt 5407X</td>
              </tr>
              <tr>
                <th class="pl-0 w-25" scope="row"><strong>Scale</strong></th>
                <td>Black</td>
              </tr>
              <tr>
                <th class="pl-0 w-25" scope="row"><strong>Vendor</strong></th>
                <td>USA, Europe</td>
              </tr>
            </tbody>
          </table>
        </div>
        <hr>

        <div class="mb-2">
          <table class="table table-sm table-borderless">
            <tbody>
              <tr>
                <td colspan="3">Quantity</td>
              </tr>
              <tr>
                <td>
                  <button type="button" class="btn btn-primary minus">&#9660;</button>
                  <input class="text-right buy_quantity" style="width: 100px;" name="buy_quantity" value="1"
                    type="number" min="1" max="10" />
                  <button type="button" class="btn btn-primary plus">&#9650;</button>
                </td>
              </tr>

              <tr>
                <td colspan="3">Quantity2</td>
              </tr>
              <tr>
                <td>
                  <button type="button" class="btn btn-primary minus">&#9660;</button>
                  <input class="text-right buy_quantity" style="width: 100px;" name="buy_quantity" value="1"
                    type="number" min="1" max="5" />
                  <button type="button" class="btn btn-primary plus">&#9650;</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <button type="button" class="btn btn-primary btn-md mr-1 mb-2" onclick="notifyMe()">Add to cart</button>
      </div>
    </div>
  </div>
  <!--Section: Block Content-->


  <!-- Plugins -->
  <script src="${pageContext.request.contextPath}/frontend/assets/js/scrollreveal.min.js"></script>
  <script src="${pageContext.request.contextPath}/frontend/assets/js/waypoints.min.js"></script>
  <script src="${pageContext.request.contextPath}/frontend/assets/js/jquery.counterup.min.js"></script>
  <script src="${pageContext.request.contextPath}/frontend/assets/js/imgfix.min.js"></script>
  <script src="${pageContext.request.contextPath}/frontend/assets/js/mixitup.js"></script>
  <script src="${pageContext.request.contextPath}/frontend/assets/js/accordions.js"></script>

  <!-- Global Init -->
  <script src="${pageContext.request.contextPath}/frontend/assets/js/custom.js"></script>

</body>

</html>