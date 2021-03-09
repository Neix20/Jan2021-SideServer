<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
    <title>PHPJabbers.com | Free Car Dealer Website Template</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/frontend/assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/frontend/assets/css/font-awesome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/frontend/assets/js/jquery-2.1.0.min.js"></script>
    <script>
        $(function(){
            $(".btnDropDown").on("click", e => {
                let str = $(e.target).siblings(".detail_board").css("display");
                (str == "none") ? $(e.target).siblings(".detail_board").css("display", "hidden") : $(e.target).siblings(".detail_board").css("display", "none");
            });
        });
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
                            <li><a href="cars.html" class="active">Vehicle Models</a></li>
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
                        <h2>Product <em>Catalog</em></h2>
                        <p>Ut consectetur, metus sit amet aliquet placerat, enim est ultricies ligula</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Call to Action End ***** -->

    <!-- ***** Fleet Starts ***** -->
    <section class="section" id="trainers">
        <div class="container">
            <form action="ProductServlet" method="GET" id="query_form">
                <div class="row py-3">
                    <div class="col-2">
                        <button type="button" class="btn btn-primary btnDropDown">Category &#9660;</button>
                        <div class="detail_board p-1" style="height: 240px; width: 100%; background-color: rgb(211,211,211); display: none;position: absolute; z-index: 2; right: -12px;">
                            <input type="checkbox" name="category" value="all" /> <label for="all">All</label><br/>
                        </div>
                    </div>
                    <div class="col-2">
                        <button type="button" class="btn btn-primary btnDropDown">Sort By &#9660;</button>
                        <div class="detail_board p-1" style="height: 135px; width: 100px; background-color: rgb(211,211,211); display: none;position: absolute; z-index: 2; right: 75px;">
                            <input type="radio" name="sort_keyword" value="name_asc" /> <label for="name_asc">Name &#9650;</label><br/>
                            <input type="radio" name="sort_keyword" value="name_dsc" /> <label for="name_dsc">Name &#9660;</label><br/>
                            <input type="radio" name="sort_keyword" value="price_asc" /> <label for="price_asc">Price &#9650;</label><br/>
                            <input type="radio" name="sort_keyword" value="price_dsc" /> <label for="price_dsc">Price &#9660;</label>
                        </div>
                    </div>
                    <div class="col-7"></div>
                    <div class="col-1">
                        <button class="btn btn-primary">Submit</button>
                    </div>
                </div>
            </form>
            <div class="row">
                <div class="col-lg-4">
                    <div class="trainer-item">
                        <div class="image-thumb">
                            <img src="${pageContext.request.contextPath}/frontend/assets/images/cars_1.jpg" alt="" style="width: 100%;">
                        </div>
                        <div class="down-content">
                            <span>
                                <sup>$</sup>11779
                            </span>

                            <h4>Lorem ipsum dolor sit amet, consectetur</h4>

                            <ul class="social-icons">
                                <li><a href="car-details.html">+ View Model</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="trainer-item">
                        <div class="image-thumb">
                            <img src="${pageContext.request.contextPath}/frontend/assets/images/cars_2.jpg" alt="">
                        </div>
                        <div class="down-content">
                            <span>
                                <sup>$</sup>11779
                            </span>

                            <h4>Lorem ipsum dolor sit amet, consectetur</h4>

                            <ul class="social-icons">
                                <li><a href="car-details.html">+ View Model</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="trainer-item">
                        <div class="image-thumb">
                            <img src="${pageContext.request.contextPath}/frontend/assets/images/cars_3.jpg" alt="">
                        </div>
                        <div class="down-content">
                            <span>
                                <sup>$</sup>11779
                            </span>

                            <h4>Lorem ipsum dolor sit amet, consectetur</h4>

                            <ul class="social-icons">
                                <li><a href="car-details.html">+ View Model</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="trainer-item">
                        <div class="image-thumb">
                            <img src="${pageContext.request.contextPath}/frontend/assets/images/cars_4.jpg" alt="">
                        </div>
                        <div class="down-content">
                            <span>
                                <sup>$</sup>11779
                            </span>

                            <h4>Lorem ipsum dolor sit amet, consectetur</h4>

                            <ul class="social-icons">
                                <li><a href="car-details.html">+ View Model</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="trainer-item">
                        <div class="image-thumb">
                            <img src="${pageContext.request.contextPath}/frontend/assets/images/cars_5.jpg" alt="">
                        </div>
                        <div class="down-content">
                            <span>
                                <sup>$</sup>11779
                            </span>

                            <h4>Lorem ipsum dolor sit amet, consectetur</h4>

                            <ul class="social-icons">
                                <li><a href="car-details.html">+ View Model</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="trainer-item">
                        <div class="image-thumb">
                            <img src="${pageContext.request.contextPath}/frontend/assets/images/cars_6.jpg" alt="">
                        </div>
                        <div class="down-content">
                            <span>
                                <sup>$</sup>11779
                            </span>

                            <h4>Lorem ipsum dolor sit amet, consectetur</h4>

                            <ul class="social-icons">
                                <li><a href="car-details.html">+ View Model</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <br>

            <nav>
                <ul class="pagination pagination-lg justify-content-center">
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                            <span class="sr-only">Next</span>
                        </a>
                    </li>
                </ul>
            </nav>

        </div>
    </section>
    <!-- ***** Fleet Ends ***** -->


    <!-- ***** Footer Start ***** -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <p>
                        Copyright © 2020 Company Name
                        - Template by: <a href="https://www.phpjabbers.com/">PHPJabbers.com</a>
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/frontend/assets/js/jquery-2.1.0.min.js"></script>

    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/frontend/assets/js/popper.js"></script>
    <script src="${pageContext.request.contextPath}/frontend/assets/js/bootstrap.min.js"></script>

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