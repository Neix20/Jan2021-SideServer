<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="domain.Product"%>
<%@ page import="domain.Productline"%>
<%@ page import="Utilities.html_generator"%>
<%
List<Product> list = (List<Product>) request.getAttribute("List");
List<Product> SearchResult = (List<Product>) request.getAttribute("SearchResult");
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
    <title>PHPJabbers.com | Free Car Dealer Website Template</title>
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <script src="../js/jquery-3.5.1.min.js"></script>
    <script>
        $(function () {
            $('#category').change(function () {
                this.form.submit();
            });

            $('#price').change(function () {
                this.form.submit();
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
        style="background-image: url(assets/images/banner-image-1-1920x500.jpg)">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 offset-lg-1">
                    <div class="cta-content">
                        <br>
                        <br>
                        <h2>Our <em>Vehicle Models</em></h2>
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
            <form action="ProductServlet" method="GET">
                <div class="row py-3">
                    <div class="col-2 text-right">Category: </div>
                    <div class="col-2">
                        <select id="category" name="category">
                            
                        </select>
                    </div>
                    <div class="col-4"></div>
                    <div class="col-2 text-right">Sort By: </div>
                    <div class="col-2">
                        <select id="price" name="sort_keyword">
                            <option value="low">Low</option>
                            <option value="high">High</option>
                        </select>
                    </div>
                </div>
            </form>
            <div class="row">
                <div class="col-lg-4">
                    <div class="trainer-item">
                        <div class="image-thumb">
                            <img src="assets/images/cars_1.jpg" alt="">
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
                            <img src="assets/images/cars_2.jpg" alt="">
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
                            <img src="assets/images/cars_3.jpg" alt="">
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
                            <img src="assets/images/cars_4.jpg" alt="">
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
                            <img src="assets/images/cars_5.jpg" alt="">
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
                            <img src="assets/images/cars_6.jpg" alt="">
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
    <script src="assets/js/jquery-2.1.0.min.js"></script>

    <!-- Bootstrap -->
    <script src="assets/js/popper.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!-- Plugins -->
    <script src="assets/js/scrollreveal.min.js"></script>
    <script src="assets/js/waypoints.min.js"></script>
    <script src="assets/js/jquery.counterup.min.js"></script>
    <script src="assets/js/imgfix.min.js"></script>
    <script src="assets/js/mixitup.js"></script>
    <script src="assets/js/accordions.js"></script>

    <!-- Global Init -->
    <script src="assets/js/custom.js"></script>

</body>

</html>