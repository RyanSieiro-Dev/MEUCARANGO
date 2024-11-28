<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>meucarango</title>
    <link rel="stylesheet" href="css/styles.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
</head>
<body>
    <header>    
                <% 
        
        String errorMsg = (String) session.getAttribute("errorMsg");
        if (errorMsg != null) { 
        %>
            
<div style="color: red; background-color: white; text-align: center; font-weight: bold; margin-top: 10px;">
    <%= errorMsg %>
</div>

        <% 
           
            session.removeAttribute("errorMsg"); 
        } 
        %>
        
        
<%
String nomeSessao = (String) session.getAttribute("nomeSessao");
String emailSessao = (String) session.getAttribute("emailSessao");
Boolean isAdmin = (Boolean) request.getAttribute("isAdmin"); 
if (nomeSessao != null && emailSessao != null) {
%>
   <div class="boas-vindas">
    <h1>Seja bem-vindo, <%= nomeSessao %>!</h1>
      
    <form action="Index.jsp" method="get">
        <input type="submit" value="Deslogar"/>
    </form>
</div>


   <% } %>

<% if (isAdmin != null && isAdmin) { %>
    
    <form action="logado.jsp" method="get">
        <input type="submit" value="Área do Administrador"/>
    </form>


<% } %>

        <div class="content">
            <nav>
                <p class="brand">Meu<strong>carango</strong></p>
                <ul>
                    <li><a href="catalogo.jsp">Catálogo</a></li>
                    <li><a href="#about">Sobre</a></li>
                    <li><a href="#features">Especificações</a></li>
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
                    <li>
                        <form action="AdminAreaServlet" method="post">
                            <input type="submit" value="Área do Administrador"/>
                        </form>
                    </li>
                    <li>
<li>
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
</li>
                    </li>
                </ul>
            </nav>
            <div class="header-block">
                <div class="text">
                    <h2>O carro perfeito para você</h2>
                    <p>Encontre as melhores ofertas de veículos que combinam com seu estilo de vida e necessidades.</p>
                </div>
                <img src="Imagens/car-header.png" alt="Carro" />
            </div>
        </div>
    </header>
    <br><br><br>

    </section>

    <section class="about" id="about">
        <div class="content">
            <div class="title-wrapper-about">
                <p>Saiba mais sobre nós</p>
                <h3>Sobre</h3>
            </div>
            <div class="about-content">
                <div class="left">
                    <img src="Imagens/LogoMeuCarango.png" alt="Sobre" />
                </div>
                <div class="right">
                    <h3>Tecnologia e mobilidade ao seu alcance</h3>
                    <p>Na MeuCarango, nosso objetivo é conectar você às melhores opções de veículos, utilizando tecnologia de ponta para oferecer uma experiência de compra prática, rápida e confiável. Quer você esteja procurando um carro para uso diário, um veículo de luxo ou uma opção econômica, temos o modelo ideal para suas necessidades.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="features" id="features">
        <div class="content">
            <div class="title-wrapper-features">
                <p>O que oferecemos</p>
                <h3>Especificações</h3>
            </div>
            <div class="feature-card-block">
                <div class="feature-card-item">
                    <img src="data:image/png;base64,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" alt="Tecnologia" />
                    <div class="feature-text-content">
                        <h3>Carros Conectados</h3>
                        <p>Os nossos veículos vêm equipados com os mais modernos sistemas de conectividade e navegação para tornar sua viagem mais segura e confortável.</p>
                    </div>
                </div>
                <div class="feature-card-item">
                    <img src="https://cdn-icons-png.flaticon.com/512/1746/1746650.png" alt="Segurança" />
                    <div class="feature-text-content">
                        <h3>Sistemas de Segurança Avançados</h3>
                        <p>Veículos com tecnologia de assistência ao condutor, como frenagem automática, controle de estabilidade e airbags múltiplos.</p>
                    </div>
                </div>
                
                <div class="feature-card-item">
                     <img src="https://img.freepik.com/vetores-premium/icone-de-vasilha-de-combustivel-conjunto-de-icones-de-vetor-de-combustivel-de-carro-conjunto-de-icones-de-combustivel-icones-de-posto-de-gasolina_564974-1349.jpg" alt="Tecnologia" />
                    <i class="bi bi-ev-front"></i>
                    <div class="feature-text-content">
                        <h3>Eficiência de Combustível</h3>
                        <p>Carros projetados para oferecer um excelente desempenho de combustível, reduzindo custos e impacto ambiental.</p>
                    </div>
                </div>
            
                <div class="feature-card-item">
                    <img src="data:image/png;base64,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" alt="Garantia" />
                    <div class="feature-text-content">
                        <h3>Garantia Estendida</h3>
                        <p>Oferecemos planos de garantia estendida para garantir que seu investimento esteja protegido a longo prazo.</p>
                    </div>
                </div>
            
                <div class="feature-card-item">
                    <img src="data:image/png;base64,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" alt="Financiamento" />
                    <div class="feature-text-content">
                        <h3>Opções de Financiamento Flexíveis</h3>
                        <p>Planos de financiamento adaptados às suas necessidades, com taxas de juros competitivas e prazos acessíveis.</p>
                    </div>
                </div>
            
                <div class="feature-card-item">
                    <img src="https://cdn-icons-png.flaticon.com/512/8728/8728994.png" alt="Serviços" />
                    <div class="feature-text-content">
                        <h3>Serviços Pós-Venda</h3>
                        <p>Suporte completo após a compra, incluindo manutenção, revisões e atendimento ao cliente dedicado.</p>
                    </div>
                </div>
            </div>
                <!-- Adicione mais cards de funcionalidades conforme necessário -->
            </div>
        </div>
    </section>

    <footer>
        <div class="main">
            <div class="content footer-links">
                <div class="footer-company">
                    <h4>Empresa</h4>
                    <h6>Sobre</h6>
                    <h6>Contato</h6>
                </div>
                <div class="footer-rental">
                    <h4>Aluguel</h4>
                    <h6>Auto-conduzido</h6>
                    <h6>Com motorista</h6>
                    <h6>Ajuda</h6>
                </div>

                
                <div class="footer-social">
                    <h4>Mantenha-se conectado</h4>
                    <div class="social-icons">
                               
        <a href="https://www.instagram.com/meucarangoofc/" target="_blank" title="Siga-nos no Instagram">
            <img src="Imagens/instagram.png" alt="Instagram" />
        </a>
                        <img src="Imagens/facebook.png" alt="Facebook" />
                    </div>
                </div>
                <div class="footer-contact">
                    <h4>Contato</h4>
                    <h6>+55 31 988776655</h6>
                    <h6>contato@meucarango.com.br</h6>
                    <h6>Rua Exemplo, Belo Horizonte MG</h6>
                </div>
            </div>
        </div>
        <div class="last">MeuCarango 2024 - Todos os Direitos Reservados</div>
    </footer>
</body>
</html>
