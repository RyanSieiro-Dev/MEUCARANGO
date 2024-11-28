<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Avaliação da Compra</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f78b00;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            max-width: 400px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h2 {
            color: #333;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button.dislike {
            background-color: #f44336;
        }
        button:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Você gostou da compra?</h2>
<form action="EnviarAvaliacao" method="post">
    <button type="submit" name="avaliacao" value="like">👍 Curtir</button>
    <button type="submit" name="avaliacao" value="dislike" class="dislike">👎 Não Curtir</button>
</form>
    </div>
</body>
</html>
