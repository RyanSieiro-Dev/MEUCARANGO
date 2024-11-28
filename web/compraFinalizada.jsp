<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Compra Finalizada</title>
    <style>
       
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f78b00;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #333;
        }
        
                h3 {
            font-size: 20px;
            color: #333;
            margin-top: 10px;
            font-weight: normal;
            animation: pulse 1s infinite;
        }

        @keyframes pulse {
            0% {
                color: #333;
                transform: scale(1);
            }
            50% {
                color: #f78b00;
                transform: scale(1.1);
            }
            100% {
                color: #333;
                transform: scale(1);
            }
        }


        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
            width: 80%;
            max-width: 600px;
            opacity: 0;
            animation: fadeIn 2s forwards;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #28a745;
        }

        a {
            display: inline-block;
            text-decoration: none;
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #0056b3;
        }

        
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
    <script language="Javascript">
        var timer = 2;
        function countdown() {
            if (timer > 0) {
                timer -= 1;
                setTimeout("countdown()", 3000);
            } else {
                location.href = 'AvaliarServiços.jsp';
            }
        }
        countdown();

        window.onload = function() {
            document.querySelector('.container').classList.add('fade-in');
        };
    </script>
</head>
<body>
    <div class="container">
        <h2><%= request.getParameter("msg") %></h2>
        <h3> Avalie o serviço em 3..2..1.. </h3>
    </div>
</body>
</html>
