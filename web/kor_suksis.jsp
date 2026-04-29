<%-- 
    Document   : kor_suksis
    Created on : 3 Jan 2025, 1:11:46 am
    Author     : HP
--%>
<!DOCTYPE html>
<html>
<head>
    <title>KOR SUKSIS</title>
    <style>
        body {
    background-color: #fffbf0; /* Light Peach */
    font-family: 'Times New Roman', Times, serif;
            }
   #sidebar {
        background-color:#C2B280; /* Pastel Green */
        color: white;
        width: 200px;
        height: 100%;
        position: fixed;
        padding: 20px;
        text-align: center;
    }

        #sidebar img {
        display: block;
        margin: 20px auto;
        width: 150px; /* Increased image width */
        height: auto;
        border: none; /* Removed the border */
    }
            #sidebar a {
        color: white;
        text-decoration: none;
        font-weight: bold;
        display: block;
        margin: 20px 0;
        font-family: 'Times New Roman', Times, serif;
        }
        
        footer {
    text-align: center;
    padding: 10px;
    position: fixed;
    bottom: 0;
    left: 220px; /* Bermula selepas sidebar */
    width: calc(100% - 220px); /* Lebar penuh tolak sidebar */
    font-size: 14px;
    font-family: 'Times New Roman', Times, serif;
    display: flex;
    justify-content: center; /* Horizontal center */
    align-items: center; /* Vertical center */
}


        #content {
            margin-left: 220px;
            padding: 20px;
        }
        .unit-links {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 50px;
        }
        .unit-links div {
            text-align: center;
        }
        .unit-links img {
            width: 100px;
            height: 100px;
            border: 1px solid black; /* Thin black border for icons */
        }
        .unit-links a {
            text-decoration: none;
            color: black;
            font-weight: bold;
            font-family: 'Times New Roman', Times, serif; /* Ensures Times New Roman font for links */
        }
        h1 {
            text-align: center;
            font-weight: bold;
            color: black;
            font-family: 'Times New Roman', Times, serif; /* Changed to Times New Roman */
        }
        .back-button {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            border: 2px solid black;
            text-align: center;
            text-decoration: none;
            color: black;
            font-weight: bold;
            width: 100px;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
            font-family: 'Times New Roman', Times, serif; /* Changed to Times New Roman */
        }
        .back-button:hover {
            background-color: black;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Sidebar Section -->
    <div id="sidebar">
        <h2>UMT Uniform Unit Allowance Management System</h2>
        <img src="${pageContext.request.contextPath}/assets/images/logo_umt.png" alt="UMT Logo">
    </div>

    <!-- Main Content Section -->
    <div id="content">
        <h1>KOR SUKSIS</h1>
        <div class="unit-links">
            <div>
                <a href="units_members.jsp">
                    <img src="${pageContext.request.contextPath}/assets/images/members.png" alt="Units Members">
                    <br>Units Members
                </a>
            </div>
            <div>
                <a href="units_highcouncil.jsp">
                    <img src="${pageContext.request.contextPath}/assets/images/council.png" alt="Units High Council">
                    <br>Units High Council
                </a>
            </div>     
                    
             <div>
                <a href="units_trainers.jsp">
                    <img src="${pageContext.request.contextPath}/assets/images/trainers.png" alt="Units Trainer">
                    <br>Units Trainer
                </a>
            </div>        
                    
            <div>
                <a href="external_officer.jsp">
                    <img src="${pageContext.request.contextPath}/assets/images/officers.png" alt="External Officer">
                    <br>External Officer
                </a>
            </div>
            
           
        </div>
        <a href="index.jsp" class="back-button">Back</a>
    </div>
        <!-- Footer Section -->
    <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>             
                    
</body>
</html>
