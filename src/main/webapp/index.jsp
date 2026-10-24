<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.repository.TrilhaRepository" %>
<%@ page import="com.service.TrilhaService" %>
<%@ page import="com.model.Trilha" %>
<%@ page import="java.util.List" %>
<%
    /*
     * Configura codificação, lê o arquivo de trilhas e inicializa o serviço.
     */
    request.setCharacterEncoding("UTF-8");
    String path = application.getRealPath("/recursos/trilhas.txt");
    TrilhaRepository repository = new TrilhaRepository(path);
    TrilhaService service = new TrilhaService(repository);

    String message = null;
    String messageType = "success";

    // Processa a submissão do formulário quando o usuário envia um voto (método POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String voteStr = request.getParameter("voto");
        try {
            int index = Integer.parseInt(voteStr == null ? "" : voteStr);
            if (service.RegVoto(index)) {
                message = "Voto computado com sucesso! Obrigado por participar.";
                messageType = "success";
            } else {
                message = "A opção selecionada não existe. Escolha uma das trilhas disponíveis.";
                messageType = "error";
            }
        } catch (NumberFormatException e) {
            message = "Não foi possível validar seu voto. Selecione uma trilha válida.";
            messageType = "error";
        }
    }

    // Carrega a lista atualizada de trilhas para renderizar na tela
    List<Trilha> tracks = service.getTrilhas();
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Votação Oficial | Mundo SENAI</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style2.css">
</head>
<body>

<header class="header-container">
    <div>
        <h1 class="brand-title">Mundo SENAI</h1>
        <p class="brand-subtitle">Escolha a sua trilha tecnológica favorita</p>
    </div>
    <a href="resultado.jsp" class="results-link">Ver Resultados</a>
</header>

<main class="main-content">

    <%-- Exibe a caixa de alerta de sucesso ou erro, caso haja alguma mensagem setada no Java --%>
    <% if (message != null) { %>
    <div class="alert-box <%= "error".equals(messageType) ? "alert-error" : "alert-success" %>">
        <%= message %>
    </div>
    <% } %>

    <section class="hero-section">
        <div class="hero-card">
            <h2 class="hero-title">Vote na sua opção favorita</h2>
            <p class="hero-description">Selecione uma trilha abaixo e clique no botão para confirmar seu voto.</p>
        </div>
    </section>

    <%-- Monta o formulário dinâmico caso existam trilhas cadastradas --%>
    <% if (tracks != null && !tracks.isEmpty()) { %>
    <form id="vote-form" method="post" action="index.jsp">
        <%-- Campo oculto que armazena o índice da trilha selecionada pelo JavaScript --%>
        <input type="hidden" name="voto" id="selected-vote-input" value="0">

        <div class="tracks-grid">
            <%-- Percorre a lista de trilhas criando um card interativo para cada uma --%>
            <% for (int i = 0; i < tracks.size(); i++) {
                Trilha track = tracks.get(i);
                boolean isSelected = (i == 0);
            %>
            <div class="track-card <%= isSelected ? "active" : "" %>" data-index="<%= i %>"
                 data-name="<%= track.getNome() %>">
                <div class="card-top">
                    <span class="track-badge">#<%= String.format("%02d", i + 1) %></span>
                    <div class="radio-indicator">
                        <span class="radio-dot"></span>
                    </div>
                </div>
                <div>
                    <h3 class="track-name"><%= track.getNome() %>
                    </h3>
                    <p class="track-desc"><%= track.getDescricao() %>
                    </p>
                </div>
            </div>
            <% } %>
        </div>

        <div class="action-area">
            <div class="selection-info">
                Opção selecionada:
                <span id="selected-label" class="selection-label">
                        <%= tracks.get(0).getNome() %>
                    </span>
            </div>
            <button type="submit" class="btn-submit">Confirmar Voto</button>
        </div>
    </form>
    <% } else { %>
    <%-- Exibido caso o arquivo trilhas.txt esteja vazio ou não seja encontrado --%>
    <div class="alert-box alert-error">
        Nenhuma trilha foi cadastrada no arquivo trilhas.txt.
    </div>
    <% } %>

</main>

<footer class="page-footer">
    Sistema de Votação Oficial • Mundo SENAI
</footer>

<script>
    /*

     * Captura o clique nos cards, atualiza o destaque visual e define a trilha selecionada no input hidden.
     */
    document.addEventListener('DOMContentLoaded', () => {
        const cards = document.querySelectorAll('.track-card');
        const voteInput = document.getElementById('selected-vote-input');
        const selectedLabel = document.getElementById('selected-label');

        cards.forEach(card => {
            card.addEventListener('click', () => {
                // Remove a seleção de todos os cards e aplica apenas no clicado
                cards.forEach(c => c.classList.remove('active'));
                card.classList.add('active');

                // Atualiza o valor do input oculto e o texto na tela
                const index = card.dataset.index;
                const name = card.dataset.name;

                voteInput.value = index;
                selectedLabel.textContent = name;
            });
        });
    });
</script>

</body>
</html>