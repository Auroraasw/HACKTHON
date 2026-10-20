<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.repository.TrilhaRepository" %>
<%@ page import="com.service.TrilhaService" %>
<%@ page import="com.model.Trilha" %>
<%@ page import="java.util.List" %>
<%
    request.setCharacterEncoding("UTF-8");
    String caminho = application.getRealPath("/recursos/trilhas.txt");
    TrilhaRepository repositorio = new TrilhaRepository(caminho);
    TrilhaService service = new TrilhaService(repositorio);

    String mensagem = null;
    String tipoMensagem = "success";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String votoStr = request.getParameter("voto");
        try {
            int indice = Integer.parseInt(votoStr == null ? "" : votoStr);
            if (service.RegVoto(indice)) {
                mensagem = "Voto computado com sucesso! Obrigado por participar.";
                tipoMensagem = "success";
            } else {
                mensagem = "A opção selecionada não existe. Escolha uma das trilhas disponíveis.";
                tipoMensagem = "error";
            }
        } catch (NumberFormatException e) {
            mensagem = "Não foi possível validar seu voto. Selecione uma trilha válida.";
            tipoMensagem = "error";
        }
    }

    // Carrega a lista original para encontrar os índices reais
    List<Trilha> trilhasOriginais = service.getTrilhas();
    // Carrega a lista ordenada para exibição na tela
    List<Trilha> trilhas = service.TrilhaOrd();
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Termômetro de Tecnologias | Mundo SENAI</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<header>
    <div class="brand">SENAI · MUNDO SENAI</div>
    <h1>Qual é a sua trilha?</h1>
    <p>Seu próximo passo na tecnologia começa com uma escolha.</p>
</header>
<main class="wrap">
    <section class="intro">
        <h2>Vote na área que mais combina com você</h2>
        <p>Explore as possibilidades e escolha sua tecnologia favorita. Cada voto ajuda a montar o termômetro da feira.</p>
    </section>

    <% if (mensagem != null) { %>
        <div class="alert <%= tipoMensagem %>" role="alert">
            <span class="alert-tag"><%= "error".equals(tipoMensagem) ? "Atenção: " : "Tudo certo! " %></span>
            <%= mensagem %>
        </div>
    <% } %>

    <% if (trilhas != null && !trilhas.isEmpty()) { %>
        <div class="grid">
            <% for (int i = 0; i < trilhas.size(); i++) {
                Trilha trilha = trilhas.get(i);
                int indiceOriginal = trilhasOriginais.indexOf(trilha);
            %>
                <article class="trilha">
                    <div class="number">#<%= (i + 1) %></div>
                    <h3><%= trilha.getNome() %></h3>
                    <p><%= trilha.getDescricao() %></p>
                    <form method="post" action="index.jsp">
                        <!-- Envia o índice real em vez da posição na tela -->
                        <input type="hidden" name="voto" value="<%= indiceOriginal %>">
                        <button type="submit" class="btn">Votar nesta trilha</button>
                    </form>
                </article>
            <% } %>
        </div>
    <% } else { %>
        <div class="alert error" role="alert">Nenhuma trilha foi cadastrada no arquivo trilhas.txt.</div>
    <% } %>

    <div class="toolbar">
        <span>Votação aberta ao público · Mundo SENAI</span>
    </div>
</main>
<footer>SENAI · Educação Profissional e Tecnológica</footer>
</body>
</html>