<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Finalizar Compra</title>
    <link rel="stylesheet" href="css/pagamentos.css" />
</head>
<body>
    <div class="container">
        <h2>Pagamento - Finalize sua Compra</h2>

        <!-- Formulário de pagamento que será enviado para o FinalizarComprasServlet -->
        <form action="FinalizarComprasServlet" method="post" class="form-pagamento">
            <!-- Campos de Cartão de Crédito -->
            <div class="campo">
                <label for="nome">Nome do Titular do Cartão:</label>
                <input type="text" id="nome" name="nome" required />
            </div>

            <div class="campo">
                <label for="numeroCartao">Número do Cartão:</label>
                <input type="text" id="numeroCartao" name="numeroCartao" required />
            </div>

            <div class="campo">
                <label for="dataValidade">Data de Validade:</label>
                <input type="month" id="dataValidade" name="dataValidade" required />
            </div>

            <div class="campo">
                <label for="cvv">Código de Segurança (CVV):</label>
                <input type="text" id="cvv" name="cvv" required />
            </div>

            <!-- Valor do Pagamento -->
            <div class="campo">
                <label for="valor">Valor do Pagamento:</label>
                <input type="text" id="valor" name="valor" value="R$ 100,00" readonly />
            </div>

            <!-- Método de Pagamento -->
            <div class="campo">
                <label>Escolha o Método de Pagamento:</label><br>
                <input type="radio" id="paypal" name="metodoPagamento" value="paypal">
                <label for="paypal">PayPal</label><br>
                <input type="radio" id="cartao" name="metodoPagamento" value="cartao" checked>
                <label for="cartao">Cartão de Crédito</label>
            </div>

            <!-- Botão de Envio -->
            <button type="submit" class="btn-submit">Finalizar Compra</button>
        </form>
    </div>

    <script src="js/pagamentos.js"></script>
</body>
</html>
