<%@ page import="java.util.List" %>
<%@ page import="servlets.Veiculo" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.conexao.CriarConexao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.math.BigDecimal"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gerenciar Pareceres Técnicos</title>
    <link rel="stylesheet" href="css/gerenciarparecer.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
</head>
<style>
    
input[type="submit"] {
    background-color: #003366;
    color: white; 
    padding: 10px 20px; 
    font-size: 16px; 
    border: none; 
    border-radius: 5px; 
    cursor: pointer; 
    transition: background-color 0.3s; 
}

input[type="submit"]:hover {
    background-color: #002244; 
}


h2 {
    font-size: 24px; 
    color: #333; 
    text-align: center; 
    font-weight: bold; 
    margin-top: 20px; 
    margin-bottom: 20px; 
    text-transform: uppercase; 
    letter-spacing: 1px; 
}

</style>
<body>
    <header>
        <%
String nomeSessao = (String) session.getAttribute("nomeSessao");
String emailSessao = (String) session.getAttribute("emailSessao");
%>
<div class="content">
    
    
<a href="index.jsp" style="text-decoration: none; color: white;">
    <p class="brand">Meu<strong>carango</strong></p>
</a>
    <br>

    
    <nav>
        <ul>
            <li><a href="catalogo.jsp">Catálogo</a></li>
            <li><a href="index.jsp">Sobre</a></li>
            <li><a href="index.jsp">Especificações</a></li>
            <li>
                <%
                if (nomeSessao != null && emailSessao != null) { 
                %>
                    <a href="carrinho.jsp" class="cart-icon">
                        <i class="fas fa-shopping-cart"></i> Carrinho
                    </a>
                <% 
                } else { 
                %>
                    <a href="login.jsp" class="cart-icon" onclick="alert('Por favor, faça login para acessar o carrinho.')">
                        <i class="fas fa-shopping-cart"></i> Carrinho
                    </a>
                <% 
                } 
                %>
            </li>
            <li><a href="gerenciar_parecer.jsp">Pareceres de veículos</a></li>
        

    <% 
    if (nomeSessao != null && emailSessao != null) { 
    %>
        <button onclick="alert('Você já está logado como <%= nomeSessao %>.');">Login</button>
    <% 
    } else { 
    %>
        <a href="login.jsp">
            <button>Login</button>
        </a>
    <% 
    } 
    %>
    
        </ul>
    

    </nav>
</div>
</header>

    <main>
        <section>
            <h2>Parecer de Veículos</h2>
            <table id="vehicleReportTable">
                <thead>
                    <tr>
                        
                        <th>Nome</th>
                        <th>Marca</th>
                        <th>Modelo</th>
                        <th>Ano</th>
                        <th>Preço</th>
                        <th>Status</th>
                        
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        conn = CriarConexao.getConexao();
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM veiculo"); 
                        while (rs.next()) {
                            int idVeiculo = rs.getInt("ID_Veiculo"); 
                            String nome = rs.getString("Nome"); 
                            String marca = rs.getString("Marca");
                            String modelo = rs.getString("Modelo");
                            int ano = rs.getInt("Ano");
                            BigDecimal preco = rs.getBigDecimal("Preço"); 
                            String status = rs.getString("Status"); 
                %>
                    <tr> 
                        
                        <td><%= nome %></td>
                        <td><%= marca %></td>
                        <td><%= modelo %></td>
                        <td><%= ano %></td>
                        <td><%= preco %></td>
                        <td><%= status %></td>
                    </tr>
                <%
                        }
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
                </tbody>
            </table>
            <div class="buttons">
                <button onclick="generatePDF()">Gerar PDF</button>
                <button onclick="generateXLS()">Gerar XLS</button>
                <button onclick="printLabels()">Imprimir Etiquetas</button>
            </div>
        </section>
                <form action="index.jsp" method="get">
    <input type="submit" value="Ir para a Página Principal">
</form>
    </main>

    <script>
       
        function generatePDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            doc.text("Parecer de Veículos", 10, 10);

            const table = document.getElementById("vehicleReportTable");
            let data = [];
            for (let row of table.rows) {
                let rowData = [];
                for (let cell of row.cells) {
                    rowData.push(cell.innerText);
                }
                data.push(rowData);
            }

            doc.autoTable({
                head: [data[0]],
                body: data.slice(1),
            });

            doc.save("parecer_veiculos.pdf");
        }

        
        function generateXLS() {
            const table = document.getElementById("vehicleReportTable");
            const ws = XLSX.utils.table_to_sheet(table);
            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, "Parecer de Veículos");

            XLSX.writeFile(wb, "parecer_veiculos.xlsx");
        }

        
        function printLabels() {
            const table = document.getElementById("vehicleReportTable");
            let content = "<h2>Etiquetas de Veículos</h2><ul>";

            for (let i = 1; i < table.rows.length; i++) {
                content += "<li>" + table.rows[i].cells[0].innerText + ", Modelo: " + table.rows[i].cells[1].innerText + "</li>";
            }

            content += "</ul>";
            const printWindow = window.open("", "", "width=600,height=400");
            printWindow.document.write(content);
            printWindow.document.close();
            printWindow.print();
        }
    </script>
</body>
</html>