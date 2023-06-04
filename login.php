<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="description" content="Login Page" />
    <meta name="keywords" content="HTML, CSS" />
    <meta name="author" content="Alex Nikolov" />
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .container h3 {
            text-align: center;
            margin-bottom: 20px;
        }

        .container label {
            display: block;
            margin: 8px;
            margin-left: 0;
            text-align: center;
        }

        .container input{
            width: 100%;
            padding: 8px;
            border-radius: 3px;
            border: 1px solid #ccc;
        }

        .container button{
            display: block;
            width: 50%;
            padding: 8px;
            margin-top: 20px;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }


        .left-container,
        .right-container {
            flex: 1;
            padding: 10px;
        }

        .right-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

    </style>
</head>

<body>
    <?php include 'includes/header.inc.php'; ?>

    <?php
    session_start();

    require_once "settings.php";
    $conn = @mysqli_connect($host, $user, $pwd, $sql_db);
    if (!$conn) {
        // Displays an error message
        echo "<p>Database connection failure</p>";
    } else {
        
    }?>

    <div class="container">
        <div class="left-container">
            <h3>Login</h3>
            <form method="POST" action="login.php" novalidate="novalidate">
                <div class="row">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="row">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary">Login</button>
            </form>
        </div>
        <div class="right-container">
            <h3>Sign Up</h3>
            <p>Create a new account by clicking the button below.</p>
            <button class="btn btn-primary">Sign Up</button>
        </div>
    </div>
</body>

</html>
