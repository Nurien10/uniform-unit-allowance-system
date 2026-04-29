<%-- 
    Document   : index
    Created on : 21 Jan 2025, 6:20:59 pm
    Author     : HP
--%>
<!DOCTYPE html>
<html>
<head>
    <title>UMT Uniform Unit Allowance Management System</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            font-family: 'Times New Roman', Times, serif;
            background-image: url('assets/images/homepagedesign.png');
            background-size: 100% 100%;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            width: 100%;
            overflow: hidden; /* Elak scroll */
            color: white;
        }

        .header {
            display: flex;
            justify-content: flex-end;
            align-items: flex-start; /* Angkat ke atas */
            padding: 10px; /* Kurang padding untuk angkat */
            background: transparent;
        }

        .login-container {
            display: flex;
            align-items: center;
        }

        .logo {
            width: 45px; /* Saiz sama dengan members.png */
            vertical-align: middle;
            margin-right: 5px; /* Jarak antara logo dan pemisah */
        }

        .login-dropdown {
            position: relative;
            display: inline-block;
        }

        .login-button {
            cursor: pointer;
            color: black; /* Teks LOGIN hitam */
            font-weight: bold;
            background: transparent; /* Tiada background */
            display: flex;
            align-items: center;
        }

        .login-button img {
            width: 35px;
            vertical-align: middle;
            margin-left: 5px;
        }

        .login-dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            color: black;
            min-width: 180px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .login-dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-weight: bold;
        }

        .login-dropdown-content a:hover {
            background-color: #ddd;
        }

        .login-dropdown:hover .login-dropdown-content {
            display: block;
        }

        .center-content {
            position: absolute;
            top: 100px; /* Angkat tajuk ke atas */
            left: 100px; /* Jauhkan daripada kiri, ke tengah sikit */
            text-align: left; /* Tak center */
        }

        h1 {
            font-size: 4em;
            text-transform: uppercase;
            text-shadow: 3px 3px 6px rgba(0, 0, 0, 0.8), 0 0 20px rgba(255, 255, 255, 0.3); /* Tambah shadow lebih ketara */
            margin: 0;
            line-height: 1.0; /* Rapatkan baris */
            color: white; /* Pastikan teks putih */
        }

        .buttons {
            margin-top: 30px; /* Jarak dari tajuk */
            text-align: left; /* Tak center */
        }

        .buttons a {
            background-color: #003366;
            color: white;
            padding: 10px 25px;
            margin: 0 20px 0 0; /* Jarak vertikal */
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            font-family: 'Times New Roman', Times, serif;
            display: inline-block; /* Elakkan center */
        }

        .buttons a:hover {
            background-color: #005599;
        }

        footer {
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
            color: white;
            background: transparent;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="login-container">
            <img src="assets/images/logo_umt.png" alt="UMT Logo" class="logo">
            <span style="color: black; margin: 0 5px;">|</span> <!-- Pemisah bar -->
            <div class="login-dropdown">
                <div class="login-button">
                    LOGIN
                    <img src="assets/images/members.png" alt="Login Icon">
                </div>
                <div class="login-dropdown-content">
                    <a href="units_members.jsp">Units Members</a>
                    <a href="units_highcouncil.jsp">Units High Council</a>
                    <a href="units_trainers.jsp">Unit Trainer</a>
                    <a href="external_officer.jsp">External Officer</a>
                </div>
            </div>
        </div>
    </div>

    <div class="center-content">
        <h1>UMT UNIFORM UNIT<br>ALLOWANCE<br>MANAGEMENT<br>SYSTEM</h1>
        <div class="buttons">
            <a href="about.jsp">ABOUT</a>
            <a href="contact.jsp">CONTACT US</a>
        </div>
    </div>

    <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>
</body>
</html>