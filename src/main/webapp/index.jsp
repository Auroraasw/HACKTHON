<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.repository.TrilhaRepository, com.service.TrilhaService, com.model.Trilha, java.util.List" %>
<%
    request.setCharacterEncoding("UTF-8");
    TrilhaService service = new TrilhaService(new TrilhaRepository(application.getRealPath("/recursos/trilhas.txt")));

    String msg = null, msgType = "success";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            int idx = Integer.parseInt(request.getParameter("voto"));
            if (service.RegVoto(idx)) {
                msg = "Voto computado com sucesso! Obrigado por participar.";
            } else {
                msg = "A opção selecionada não existe.";
                msgType = "error";
            }
        } catch (Exception e) {
            msg = "Selecione uma trilha válida.";
            msgType = "error";
        }
    }

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

    <% if (msg != null) { %>
    <div class="alert-box alert-<%= msgType %>"><%= msg %></div>
    <% } %>

    <section class="hero-section">
        <div class="hero-card">
            <h2 class="hero-title">Vote na sua opção favorita</h2>
            <p class="hero-description">Selecione uma trilha abaixo e clique no botão para confirmar seu voto.</p>
        </div>
    </section>

    <% if (tracks != null && !tracks.isEmpty()) { %>
    <form id="vote-form" method="post" action="index.jsp">
        <input type="hidden" name="voto" id="selected-vote-input" value="0">

        <div class="tracks-grid">
            <% for (int i = 0; i < tracks.size(); i++) {
                Trilha t = tracks.get(i);
            %>
            <div class="track-card <%= (i == 0) ? "active" : "" %>" data-index="<%= i %>" data-name="<%= t.getNome() %>">
                <div class="card-top">
                    <span class="track-badge">#<%= String.format("%02d", i + 1) %></span>
                    <div class="radio-indicator"><span class="radio-dot"></span></div>
                </div>
                <div>
                    <h3 class="track-name"><%= t.getNome() %></h3>
                    <p class="track-desc"><%= t.getDescricao() %></p>
                </div>
            </div>
            <% } %>
        </div>

        <div class="action-area">
            <div class="selection-info">
                Opção selecionada:
                <span id="selected-label" class="selection-label"><%= tracks.get(0).getNome() %></span>
            </div>
            <button type="submit" class="btn-submit">Confirmar Voto</button>
        </div>
    </form>
    <% } else { %>
    <div class="alert-box alert-error">Nenhuma trilha foi cadastrada no arquivo trilhas.txt.</div>
    <% } %>

</main>

<footer class="page-footer">
    Sistema de Votação Oficial • Mundo SENAI
</footer>

<script>
    document.querySelectorAll('.track-card').forEach(card => {
        card.addEventListener('click', () => {
            document.querySelectorAll('.track-card').forEach(c => c.classList.remove('active'));
            card.classList.add('active');

            document.getElementById('selected-vote-input').value = card.dataset.index;
            document.getElementById('selected-label').textContent = card.dataset.name;
        });
    });
</script>

</body>
</html>