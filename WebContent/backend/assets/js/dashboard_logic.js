$(document).ready(function () {
    $(".search_select").selectize();

    let inventory_pie_chart = new CanvasJS.Chart("inventory_pie_chart", {
        theme: "light2", // "light1", "light2", "dark1", "dark2"
        exportEnabled: true,
        animationEnabled: true,
        title: {
            text: "Product Inventory Chart"
        },
        data: [{
            type: "pie",
            startAngle: 25,
            toolTipContent: "<b>{label}</b>: {y}%",
            showInLegend: "true",
            legendText: "{label}",
            indexLabelFontSize: 16,
            indexLabel: "{label} - {y}%",
            dataPoints: [
                { y: 51.08, label: "Chrome" },
                { y: 27.34, label: "Internet Explorer" },
                { y: 10.62, label: "Firefox" },
                { y: 5.02, label: "Microsoft Edge" },
                { y: 4.07, label: "Safari" },
                { y: 1.22, label: "Opera" },
                { y: 0.44, label: "Others" }
            ]
        }]
    });

    let productline_bar_chart = new CanvasJS.Chart("productline_bar_chart", {
        animationEnabled: true,
        exportEnabled: true,
        title: {
            text: "Productline Chart"
        },
        axisY: {
            title: "Number of Sales",
            titleFontColor: "#4F81BC",
            lineColor: "#4F81BC",
            labelFontColor: "#4F81BC",
            tickColor: "#4F81BC"
        },
        toolTip: {
            shared: true
        },
        legend: {
            cursor: "pointer",
            itemclick: toggleDataSeries
        },
        data: [{
            type: "column",
            name: "Productline",

            showInLegend: true,
            dataPoints: [
                { label: "Saudi", y: 266.21 },
                { label: "Venezuela", y: 302.25 },
                { label: "Iran", y: 157.20 },
                { label: "Iraq", y: 148.77 },
                { label: "Kuwait", y: 101.50 },
                { label: "UAE", y: 97.8 }
            ]
        }]
    });

    let order_product_bar_chart = new CanvasJS.Chart("order_product_bar_chart", {
        animationEnabled: true,
        exportEnabled: true,
        title: {
            text: "Total number of Orders and Products"
        },
        axisY: {
            title: "Number of Orders",
            titleFontColor: "#4F81BC",
            lineColor: "#4F81BC",
            labelFontColor: "#4F81BC",
            tickColor: "#4F81BC"
        },
        axisY2: {
            title: "Number of Products",
            titleFontColor: "#C0504E",
            lineColor: "#C0504E",
            labelFontColor: "#C0504E",
            tickColor: "#C0504E"
        },
        toolTip: {
            shared: true
        },
        legend: {
            cursor: "pointer",
            itemclick: toggleDataSeries
        },
        data: [{
            type: "column",
            name: "Proven Oil Reserves (bn)",
            legendText: "Proven Oil Reserves",
            showInLegend: true,
            dataPoints: [
                { label: "Saudi", y: 266.21 },
                { label: "Venezuela", y: 302.25 },
                { label: "Iran", y: 157.20 },
                { label: "Iraq", y: 148.77 },
                { label: "Kuwait", y: 101.50 },
                { label: "UAE", y: 97.8 }
            ]
        },
        {
            type: "column",
            name: "Oil Production (million/day)",
            legendText: "Oil Production",
            axisYType: "secondary",
            showInLegend: true,
            dataPoints: [
                { label: "Saudi", y: 10.46 },
                { label: "Venezuela", y: 2.27 },
                { label: "Iran", y: 3.99 },
                { label: "Iraq", y: 4.45 },
                { label: "Kuwait", y: 2.92 },
                { label: "UAE", y: 3.1 }
            ]
        }]
    });

    let buyPrice_msrp_line_chart = new CanvasJS.Chart("buyPrice_msrp_line_chart", {
        title: {
            text: "Weekly Buy Price and MSRP Analysis"
        },
        exportEnabled: true,
        animationEnabled: true,
        axisY: {
            title: "Prices",
            lineColor: "#C24642",
            tickColor: "#C24642",
            labelFontColor: "#C24642",
            titleFontColor: "#C24642",
            suffix: "k"
        },
        toolTip: {
            shared: true
        },
        legend: {
            cursor: "pointer",
            itemclick: toggleDataSeries
        },
        data: [{
            type: "line",
            name: "Footfall",
            color: "#369EAD",
            showInLegend: true,
            axisYIndex: 1,
            dataPoints: [
                { x: new Date(2017, 00, 7), y: 85.4 },
                { x: new Date(2017, 00, 14), y: 92.7 },
                { x: new Date(2017, 00, 21), y: 64.9 },
                { x: new Date(2017, 00, 28), y: 58.0 },
                { x: new Date(2017, 01, 4), y: 63.4 },
                { x: new Date(2017, 01, 11), y: 69.9 },
                { x: new Date(2017, 01, 18), y: 88.9 },
                { x: new Date(2017, 01, 25), y: 66.3 },
                { x: new Date(2017, 02, 4), y: 82.7 },
                { x: new Date(2017, 02, 11), y: 60.2 },
                { x: new Date(2017, 02, 18), y: 87.3 },
                { x: new Date(2017, 02, 25), y: 98.5 }
            ]
        },
        {
            type: "line",
            name: "Order",
            color: "#C24642",
            axisYIndex: 0,
            showInLegend: true,
            dataPoints: [
                { x: new Date(2017, 00, 7), y: 32.3 },
                { x: new Date(2017, 00, 14), y: 33.9 },
                { x: new Date(2017, 00, 21), y: 26.0 },
                { x: new Date(2017, 00, 28), y: 15.8 },
                { x: new Date(2017, 01, 4), y: 18.6 },
                { x: new Date(2017, 01, 11), y: 34.6 },
                { x: new Date(2017, 01, 18), y: 37.7 },
                { x: new Date(2017, 01, 25), y: 24.7 },
                { x: new Date(2017, 02, 4), y: 35.9 },
                { x: new Date(2017, 02, 11), y: 12.8 },
                { x: new Date(2017, 02, 18), y: 38.1 },
                { x: new Date(2017, 02, 25), y: 42.4 }
            ]
        }]
    });

    let sales_revenue_line_chart = new CanvasJS.Chart("sales_revenue_line_chart", {
        title: {
            text: "Weekly Sales Revenue Analysis"
        },
        exportEnabled: true,
        animationEnabled: true,
        axisY: {
            title: "Prices",
            lineColor: "#C24642",
            tickColor: "#C24642",
            labelFontColor: "#C24642",
            titleFontColor: "#C24642",
            suffix: "k"
        },
        toolTip: {
            shared: true
        },
        legend: {
            cursor: "pointer",
            itemclick: toggleDataSeries
        },
        data: [{
            type: "line",
            name: "Order",
            color: "#C24642",
            axisYIndex: 0,
            showInLegend: true,
            dataPoints: [
                { x: new Date(2017, 00, 7), y: 32.3 },
                { x: new Date(2017, 00, 14), y: 33.9 },
                { x: new Date(2017, 00, 21), y: 26.0 },
                { x: new Date(2017, 00, 28), y: 15.8 },
                { x: new Date(2017, 01, 4), y: 18.6 },
                { x: new Date(2017, 01, 11), y: 34.6 },
                { x: new Date(2017, 01, 18), y: 37.7 },
                { x: new Date(2017, 01, 25), y: 24.7 },
                { x: new Date(2017, 02, 4), y: 35.9 },
                { x: new Date(2017, 02, 11), y: 12.8 },
                { x: new Date(2017, 02, 18), y: 38.1 },
                { x: new Date(2017, 02, 25), y: 42.4 }
            ]
        }]
    });

    inventory_pie_chart.render();
    productline_bar_chart.render();
    order_product_bar_chart.render();
    buyPrice_msrp_line_chart.render();
    sales_revenue_line_chart.render();
});

function toggleDataSeries(e) {
    if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
        e.dataSeries.visible = false;
    } else {
        e.dataSeries.visible = true;
    }
    e.chart.render();
}