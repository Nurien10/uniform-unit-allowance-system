<%-- 
    Document   : external_officer
    Created on : 15 Jan 2025, 3:30:47 pm
    Author     : HP
--%>

<html>
<head>
    <title>External Officer Login</title>
   <style>
      body {
    background-color: #f5f5f5; /* Kelabu putih */
    font-family: 'Times New Roman', Times, serif;
}
#sidebar {
    background-color: #1A252F; /* Warna sidebar asal */
    color: white;
    width: 200px;
    height: 100%;
    position: fixed;
    top: 0;
    left: 0; /* Pastikan penuh ke kiri tanpa gap */
    padding: 20px;
    text-align: center;
}
#sidebar img {
    display: block;
    margin: 20px auto;
    width: 150px;
    height: auto;
    border: none;
}
#sidebar a {
    color: white;
    text-decoration: none;
    font-weight: bold;
    display: block;
    margin: 20px 0;
    font-family: 'Times New Roman', Times, serif;
}
#content {
    margin-left: 220px;
    padding: 60px; /* Tambah padding untuk jarak di sekeliling kandungan */
}
h1 {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #34495e; /* Warna tajuk serasi dengan gambar */
}
form {
    max-width: 400px;
    margin: 0 auto;
    background: #ffffff; /* Putih seperti dalam gambar */
    padding: 40px;
    border-radius: 10px; /* Sudut bulat seperti gambar */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05); /* Bayang lembut */
    margin-bottom: 20px; /* Tambah jarak di bawah form */
}
label {
    font-weight: bold;
    color: #34495e;
    margin-bottom: 5px;
}
input {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    background-color: #f0f0f5; /* Latar input seperti gambar */
}
.form-buttons {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}
.form-buttons button {
    width: 48%;
    padding: 10px;
    border: none;
    border-radius: 5px;
    font-family: 'Times New Roman', Times, serif;
    font-size: 14px;
    cursor: pointer;
    font-weight: bold;
    text-align: center;
    transition: background-color 0.3s;
}
.form-buttons button[type="submit"] {
    background-color: #27ae60; /* Hijau seperti gambar */
    color: white;
}
.form-buttons button[type="submit"]:hover {
    background-color: #219653; /* Hijau gelap */
}
.form-buttons button[type="reset"] {
    background-color: #e74c3c; /* Merah seperti gambar */
    color: white;
}
.form-buttons button[type="reset"]:hover {
    background-color: #c0392b; /* Merah gelap */
}
.signup-link {
    text-align: center;
    margin-top: 10px;
}
.signup-link a {
    text-decoration: none;
    color: #3498db; /* Biru seperti dalam gambar kedua */
    font-weight: bold;
}
.signup-link a:hover {
    text-decoration: underline;
}
.back-button {
    display: block;
    margin: 20px auto;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    text-align: center;
    text-decoration: none;
    color: white;
    font-weight: bold;
    width: 100px;
    background-color: #3498db; /* Biru */
    transition: background-color 0.3s;
    font-family: 'Times New Roman', Times, serif;
}
.back-button:hover {
    background-color: #2980b9; /* Biru gelap */
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
    background-color: transparent; /* Background transparent */
}
    </style>
</head>
<body>
    <!-- Sidebar Section -->
    <div id="sidebar">
        <h2>UMT Uniform Unit Allowance Management System</h2>
        <img src="${pageContext.request.contextPath}/assets/images/logo_umt.png" alt="UMT Logo">
        <a href="index.jsp">Home</a>
    </div>

    <!-- Main Content Section -->
    <div id="content">
        <h1>Login (External Officer)</h1> <!-- Centered above the form -->
        <form action="login" method="post">
            <input type="hidden" name="role" value="ExternalOfficer">

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <div class="form-buttons">
                <button type="submit">Login</button>
                <button type="reset">Cancel</button>
            </div>

            <div class="signup-link">
                <p>I don't have an account.</p>
                <a href="registerexternal_officer.jsp">Sign Up</a>
            </div>
        </form>

        
    </div>
    <footer>
        © 2025 UMT Uniform Unit Allowance Management System. All rights reserved.
    </footer>  
</body>
</html>
