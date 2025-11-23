var taskchart;
function handleItemClick(year) {

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;
                const data = JSON.parse(str);

                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

                const monthlyData = {};

                months.forEach(month => {
                    monthlyData[month] = 0;
                });

                for (var i = 0; i < data.length; i++) {
                    var taskDocument = data[i];
                    var date = new Date(taskDocument.completedDate);
                    var month = date.toLocaleString('en-us', {month: 'short'});
                    monthlyData[month]++;
                }

                // Prepare data for chart
                const taskCounts = months.map(month => monthlyData[month]);

                // Destroy existing chart if it exists
                if (taskchart) {
                    taskchart.destroy();
                }

                // Create ApexCharts
                var options = {
                    chart: {
                        type: 'area',
                        toolbar: {
                            show: false
                        }
                    },
                    dataLabels: {
                        enabled: false
                    },
                    xaxis: {
                        categories: months,
                        title: {
                            text: 'Month'
                        }
                    },
                    yaxis: {
                        title: {
                            text: 'Number of Tasks'
                        },
                        labels: {
                            formatter: function (value) {
                                return Math.round(value);
                            }
                        }
                    },
                    series: [{
                            name: 'Completed Tasks',
                            data: taskCounts
                        }],
                    stroke: {
                        curve: 'smooth',
                        width: 2
                    }
                };

                taskchart = new ApexCharts(document.querySelector("#admintaskChart"), options);
                taskchart.render();


                return true;
            }

        }

    };
    req.open("POST", "../TaskStatusCountDashbard", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("year=" + year);

}

var mytaskchart;
function handleAdminTask(year, adminId) {

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;
                const data = JSON.parse(str);

                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

                const monthlyData = {};

                months.forEach(month => {
                    monthlyData[month] = 0;
                });

                for (var i = 0; i < data.length; i++) {
                    var taskDocument = data[i];
                    var date = new Date(taskDocument.completedDate);
                    var month = date.toLocaleString('en-us', {month: 'short'});
                    monthlyData[month]++;
                }

                // Prepare data for chart
                const taskCounts = months.map(month => monthlyData[month]);

                // Destroy existing chart if it exists
                if (mytaskchart) {
                    mytaskchart.destroy();
                }

                // Create ApexCharts
                var options = {
                    chart: {
                        type: 'area',
                        toolbar: {
                            show: false
                        }
                    },
                    dataLabels: {
                        enabled: false
                    },
                    xaxis: {
                        categories: months,
                        title: {
                            text: 'Month'
                        }
                    },
                    yaxis: {
                        title: {
                            text: 'Number of Tasks'
                        },
                        labels: {
                            formatter: function (value) {
                                return Math.round(value);
                            }
                        }
                    },
                    series: [{
                            name: 'Completed Tasks',
                            data: taskCounts
                        }],
                    stroke: {
                        curve: 'smooth',
                        width: 2
                    }
                };

                mytaskchart = new ApexCharts(document.querySelector("#mytaskChart"), options);
                mytaskchart.render();


                return true;
            }

        }

    };
    req.open("POST", "../TaskStatusCountEmpDashboard", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("year=" + year + "&projectEmployee=" + adminId);

}

