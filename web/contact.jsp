<%-- 
    Document   : contact
    Created on : 22 Jun 2025, 1:24:51 am
    Author     : HP
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us - Kor SUKSIS</title>
    <style>
        body {
            background: url('police-bg.png') no-repeat center center fixed;
            background-color: #f5f5f5;
            background-size: cover;
            background-blend-mode: overlay;
            font-family: 'Times New Roman', Times, serif;
            margin: 0;
            padding: 0;
        }

        #content {
            padding: 60px;
            max-width: 800px;
            margin: 0 auto;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
        }

        h1 {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 30px;
            color: #34495e;
        }

        .contact-section {
            background-color: #ffffff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .contact-section h2 {
            color: #34495e;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .contact-section p {
            line-height: 1.6;
            color: #666;
        }

        .social-links {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .social-links a {
            text-decoration: none;
            color: #2980b9;
            font-weight: bold;
            transition: color 0.3s;
        }

        .social-links a:hover {
            color: #1c5980;
        }

        footer {
            margin-top: 20px;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            font-size: 14px;
            font-family: 'Times New Roman', Times, serif;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: transparent;
        }
    </style>
</head>
<body>
    <div id="content">
        <h1>Contact Us</h1>

        <div class="contact-section">
            <h2>Office Address</h2>
            <p>
                Kor SUKSIS Office,<br>
                Universiti Malaysia Terengganu,<br>
                21030 Kuala Nerus, Terengganu, Malaysia.
            </p>
        </div>

        <div class="contact-section">
            <h2>Phone & Email</h2>
            <p>
                General Office: +609-668 1234<br>
                Training Unit: +609-668 5678<br>
                Email: <a href="mailto:suksis@umt.edu.my">suksis@umt.edu.my</a>
            </p>
        </div>

        <div class="contact-section">
            <h2>Follow Us</h2>
            <div class="social-links">
                <a href="https://www.instagram.com/korsuksisumt" target="_blank">Instagram</a>
                <a href="https://www.facebook.com/korsuksisumt" target="_blank">Facebook</a>
                <a href="https://www.youtube.com/korsuksisumt" target="_blank">YouTube</a>
            </div>
        </div>
    </div>

    <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>
</body>
</html>
