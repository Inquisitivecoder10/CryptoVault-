window.onbeforeunload = function () {
    window.scrollTo(0, 0);
};
document.documentElement.scrollTop = 0; // For most browsers
document.body.scrollTop = 0; // For some older browsers
history.scrollRestoration = "manual";
document.documentElement.scrollTop = 0; // Or document.body.scrollTop = 0;
document.addEventListener('scroll', function() {
    const aboutSection = document.getElementById('about');
    const aboutSectionPosition = aboutSection.getBoundingClientRect().top;

    if (aboutSectionPosition <= window.innerHeight / 2) {
        // The "About Us" section is halfway into view
        // Trigger animations here
        aboutSection.classList.add('animate');
    }
});

/* CONTACT US */
document.addEventListener('DOMContentLoaded', function() {
    var contactSection = document.getElementById('contact');
    var contactHeading = document.querySelector('.contact-heading');

    function checkScroll() {
        var rect = contactSection.getBoundingClientRect();
        if (rect.top <= window.innerHeight && rect.bottom >= 0) {
            contactHeading.classList.add('zoomed-in');
        } else {
            contactHeading.classList.remove('zoomed-in');
        }
    }

    window.addEventListener('scroll', checkScroll);
});

/* LOG IN PAGE */
// scripts.js

document.addEventListener('DOMContentLoaded', function() {
    // Find the LogIn button by its ID
    var loginButton = document.getElementById('loginButton');

    // Add a click event listener to the button
    loginButton.addEventListener('click', function() {
        // Implement validation logic here
        var username = prompt("Enter your username:");
        var password = prompt("Enter your password:");

        // Example validation: Check if both username and password are provided
        if (username && password) {
            // Redirect to the login page
            window.location.href = 'login.html';
        } else {
            alert("Invalid username or password. Please try again.");
        }
    });
});

/* ---------------------DYNAMIC GRAPHS --------------------------*/
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
    // Set Data
    const data = google.visualization.arrayToDataTable([
        ['Contry', 'Mhl'],
        ['Italy',55],
        ['France',49],
        ['Spain',44],
        ['USA',24],
        ['Argentina',15]
    ]);

    // Set Options
    const options = {
        title:'World Wide Wine Production'
    };

    // Draw
    const chart = new google.visualization.BarChart(document.getElementById('myChart'));
    chart.draw(data, options);
}

/* PORTFOLIO SECTION */

document.addEventListener('DOMContentLoaded', function() {
    var addButtons = document.querySelectorAll('.add-investment');

    addButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            var amount = prompt("Enter the amount:");
            if (amount) {
                // Calculate the total amount invested
                var totalInvested = 0;
                var investmentRows = document.querySelectorAll('.investments-table tbody tr');
                investmentRows.forEach(function(row) {
                    var amountCell = row.querySelector('td:nth-child(2)'); // Assuming the amount is in the second column
                    var amountValue = parseFloat(amountCell.textContent.replace('$', ''));
                    totalInvested += amountValue;
                });

                // Update the "Invested Value" section
                document.querySelector('.user-details .user-text p:nth-child(4)').textContent = `Invested Value: $${totalInvested}`;

                // Show the popup
                document.getElementById('popup').style.display = 'flex';

                // Hide the popup after 3 seconds
                setTimeout(function() {
                    document.getElementById('popup').style.display = 'none';
                }, 3000);
            }
        });
    });
});

document.addEventListener('DOMContentLoaded', function() {
    var addButtons = document.querySelectorAll('.add-button');

    addButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            var amount = prompt("Enter the amount:");
            if (amount) {
                // Show the popup
                document.getElementById('popup').style.display = 'flex';

                // Hide the popup after 3 seconds
                setTimeout(function() {
                    document.getElementById('popup').style.display = 'none';
                }, 3000);
            }
        });
    });
});

document.addEventListener('DOMContentLoaded', function() {
    var depositButton = document.getElementById('depositButton');

    depositButton.addEventListener('click', function() {
        var amount = prompt("Enter the deposit amount:");
        if (amount) {
            // Show the deposit popup
            document.getElementById('depositPopup').style.display = 'flex';

            // Hide the deposit popup after 3 seconds
            setTimeout(function() {
                document.getElementById('depositPopup').style.display = 'none';
            }, 3000);
        }
    });
});

/* REGISTRATION POPUP */
// scripts.js
document.addEventListener('DOMContentLoaded', function() {
    var registerForm = document.getElementById('registerForm');

    registerForm.addEventListener('submit', function(e) {
        e.preventDefault(); // Prevent the default form submission

        var email = document.getElementById('email').value;

        // Check if the user already exists
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var response = xmlhttp.responseText;
                if (response.includes('User exists')) {
                    // User already exists, show the popup
                    document.getElementById('depositPopup').style.display = 'flex';
                    document.getElementById('message').innerHTML = 'User already registered';
                } else {
                    // User does not exist, proceed with form submission
                    registerForm.submit();
                }
            }
        };
        xmlhttp.open("GET", "/check_user_existence?email=" + email, true);
        xmlhttp.send();
    });
});

/* ---------------------------- GRAPH ------------------------------------- */
// Fetch data from Flask route and create the chart
document.addEventListener('DOMContentLoaded', function() {
    fetch('/get_chart_data')
        .then(response => response.json())
        .then(data => {
            var ctx = document.getElementById("linechart").getContext("2d");
            var linechart = new Chart(ctx, {
                type: "line",
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: "Data Points",
                        data: data.values,
                        fill: false,
                        borderColor: "Whitesmoke",
                        lineTension: 0.1
                    }]
                },
                options: {
                    responsive: false
                }
            });
        });
});
