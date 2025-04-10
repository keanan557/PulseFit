PulseFit Ecommerce Website

[![Screenshot of Homepage](https://github.com/keanan557/pulsefit-assets/blob/6dafcea32d51891e331fefa73f9aeb455ce196e2/pulsefit-home.png)](https://pulsefit-live.vercel.app/)
[![Animated GIF of Adding to Cart](https://github.com/keanan557/pulsefit-assets/blob/0602588381d46a76d405a1d787d5fc85b6c9db85/add%20to%20cart.gif)](https://pulsefit-live.vercel.app/)

A fully functional e-commerce website built by Keanan,Anele,Mogale,Sphelele for the Module 3 assignment. PulseFit offers a solution for people looking to gain muscle and become healthy and stronger.

## Table of Contents
- [Live Demo](#live-demo)
- [Technologies Used](#technologies-used)
- [Setup Instructions](#setup-instructions)
- [Key Features](#key-features)
- [Credits](#credits) (If Applicable)
- [Author](#author)

## Live Demo
[Link to the live deployed website](https://pulsefit-live.vercel.app/)

## Technologies Used
- **Front-end:** Vue
- **Styling:** Custom CSS
- **Back-end:** node
- **Database:** MySQL

## Setup Instructions

Follow these steps to run the system on your local development environment:

1.  **Prerequisites:**
    * MySQL Server installed and running

2.  **Clone the Repository:**
    ```bash
    git clone https://github.com/keanan557/PulseFit.git
    cd frontend and 
    cd api
    ```

3.  **Install Dependencies (if using Composer):**
    ```bash
    npm i
    
    ```

4.  **Database Setup:**
    * Create a new database named `PulseFit` in your MySQL server.
    * Import the database schema from the provided SQL file (`database/PulseFit.sql` - if applicable). You can do this using a MySQL client (like phpMyAdmin or MySQL Workbench) or the command line:
        ```bash
        mysql -u [your_mysql_username] -p PulseFit < database/PulseFit.sql
        ```
    * Configure the database connection details in your mysql configuration file (e.g., `config.js`, `.env`):
        ```php
        <?php
        // Example configuration
        define('DB_HOST', 'localhost');
        define('DB_USER', 'your_db_user');
        define('DB_PASS', 'your_db_password');
        define('DB_NAME', 'PulseFit');
        ?>
        ```

5.  **Web Server Configuration:**
    * Ensure your web server is configured to point to the project's `public` directory (or the main entry point of your application).
    * If using Apache, you might need to enable `mod_rewrite` and configure a `.htaccess` file (if provided).

6.  **Run the Development Server (Example using node's built-in server):**
    ```bash
    npm run serve for frontend
    node --watch index.js for api 
    ```
    Then, open your web browser and navigate to `http://localhost:8000`.

## Key Features
This e-commerce website implements the following key features:

* **User Login and Registration:** Secure user registration and login functionality.
* **User Interface Design and UX/UI Principles:** A user-friendly and visually appealing design adhering to UX/UI best practices.
* **Shopping Cart and Order Process:** A functional shopping cart allowing users to add, modify, and checkout with their selected items.
* **Responsive Design Implementation:** The website adapts seamlessly to various screen sizes (desktop, tablet, mobile).
* **Database Design and Implementation:** A well-structured database (`PulseFit`) to store user, product, and order data.
* **Authentication and User Management:** Secure authentication for users and potentially an administrative interface for managing the website.
* **Product/Service Data Management:** [If implemented] An administrative interface for adding, editing, and deleting products.
* **Order Processing and Management:** [If implemented] An administrative interface for viewing and managing customer orders.
* **Payment System Integration:** [Specify if actual or simulated] Integration with a payment gateway (either a real implementation or a simulated process).
* **Overall System Integration (Front-end and Back-end):** Seamless communication and data flow between the user interface and the server-side logic.

## Credits (If Applicable)
[Acknowledge any libraries, frameworks, or resources used, e.g.:]
* Vue: [https://vuejs.org/]
* MySql: [https://www.mysql.com/]
* Node : [https://nodejs.org/en]

## Author
* Keanan 
* Anele
* Mogale
* Sphele

## Githubs

* github.com/keanan557
* github.com/Lostee23
* github.com/psycho2k3
* github.com/Anele-Mbombiya
