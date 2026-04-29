<%-- 
    Document   : about
    Created on : 22 Jun 2025, 1:15:13 am
    Author     : HP
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About PDRM</title>
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
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white to soften background */
            border-radius: 10px;
        }
        h1 {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #34495e;
        }
        .section {
            background-color: #ffffff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .section h2 {
            color: #34495e;
            font-size: 20px;
            margin-bottom: 10px;
        }
        .section p {
            line-height: 1.6;
            color: #666;
        }
        .vision-mission-container {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }
        .vision, .mission {
            flex: 1;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #3498db; /* Light blue accent for playfulness */
        }
        .vision h2, .mission h2 {
            color: #2980b9; /* Slightly different shade for headers */
            font-size: 20px;
            margin-bottom: 10px;
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
        <h1>About Kor Suksis </h1>

        <div class="section">
            <h2>Introduction</h2>
            <p>
                The idea for the establishment of the Student Police Volunteer Corps (SUKSIS) was initially inspired by YAB Datuk Seri Abdullah Hj. Ahmad Badawi, the 5th Prime Minister of Malaysia, who was then serving as Deputy Prime Minister and Minister of Home Affairs during his speech at the launch of the 12th Convocation Expo at Universiti Utara Malaysia (UUM), Sintok, Kedah.
            </p>
        </div>

        <div class="section">
            <h2>Objectives</h2>
            <p>
                1.To produce students with a strong sense of identity and high discipline<br>
                2.To shape students who are intellectual and charismatic in leadership<br>
                3. To foster a spirit of camaraderie among students of diverse races and religions.
            </p>
        </div>

        <div class="vision-mission-container">
            <div class="vision">
                <h2>Vision</h2>
                <p>
                    To cultivate graduates with a strong, successful character, equipped with policing expertise and personal skills that harmonize intellectual prowess with social awareness.
                </p>
            </div>
            <div class="mission">
                <h2>Mission</h2>
                <p>
                    To mold a civil society that upholds the law and takes responsibility for preserving the security and harmony of Malaysia’s diverse communities.
                </p>
            </div>
        </div>
    </div>

    <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>
</body>
</html>