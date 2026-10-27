<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.repository.TrilhaRepository, com.service.TrilhaService, com.model.Trilha, java.util.List" %>
<%
    // Define a codificação da requisição para aceitar acentuação em UTF-8
    request.setCharacterEncoding("UTF-8");

    // Instancia o serviço lendo o arquivo de dados
    TrilhaService service = new TrilhaService(new TrilhaRepository(application.getRealPath("/recursos/trilhas.txt")));

    String msg = null, msgType = "success";

    // Processa o envio do formulário de voto (requisição POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            // Obtém o índice da opção enviada pelo usuário
            int idx = Integer.parseInt(request.getParameter("voto"));

            // Tenta registrar o voto e define a mensagem de retorno
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

    // Carrega a lista completa de trilhas cadastradas
    List<Trilha> tracks = service.getTrilhas();
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Votação Oficial | Mundo SENAI</title>
    <!-- Carrega a folha de estilos CSS externa -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style2.css">
</head>
<body>

<!-- Cabeçalho com o título do sistema e link para a página de resultados -->
<header class="header-container">
    <div>
        <h1 class="brand-title">Mundo SENAI</h1>
        <p class="brand-subtitle">Escolha a sua trilha tecnológica favorita</p>
    </div>
    <a href="resultado.jsp" class="results-link">Ver Resultados</a>
</header>

<main class="main-content">

    <!-- Exibe a mensagem de feedback (sucesso ou erro), caso exista -->
    <% if (msg != null) { %>
    <div class="alert-box alert-<%= msgType %>"><%= msg %></div>
    <% } %>

    <!-- Seção de apresentação -->
    <section class="hero-section">
        <div class="hero-card">
            <h2 class="hero-title">Vote na sua opção favorita</h2>
            <p class="hero-description">Selecione uma trilha abaixo e clique no botão para confirmar seu voto.</p>
        </div>
    </section>

    <!-- Exibe o formulário se houver trilhas disponíveis -->
    <% if (tracks != null && !tracks.isEmpty()) { %>
    <form id="vote-form" method="post" action="index.jsp">
        <!-- Campo oculto que armazena o índice da trilha selecionada -->
        <input type="hidden" name="voto" id="selected-vote-input" value="0">

        <!-- Grid para exibir os cartões das trilhas -->
        <div class="tracks-grid">
            <% for (int i = 0; i < tracks.size(); i++) {
                Trilha t = tracks.get(i);
            %>
            <!-- Cartão individual da trilha (a primeira vem selecionada por padrão) -->
            <div class="track-card <%= (i == 0) ? "active" : "" %>" data-index="<%= i %>" data-name="<%= t.getNome() %>">
                <div class="card-top">
                    <!-- Número formatado (ex: #01, #02) -->
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

        <!-- Barra inferior com a opção selecionada e o botão de envio -->
        <div class="action-area">
            <div class="selection-info">
                Opção selecionada:
                <span id="selected-label" class="selection-label"><%= tracks.get(0).getNome() %></span>
            </div>
            <button type="submit" class="btn-submit">Confirmar Voto</button>
        </div>
    </form>

    <!-- Alerta exibido caso não haja trilhas no arquivo -->
    <% } else { %>
    <div class="alert-box alert-error">Nenhuma trilha foi cadastrada no arquivo trilhas.txt.</div>
    <% } %>

</main>

<!-- Rodapé da página -->
<footer class="page-footer">
    Turma de Técnico em Desenvolvimento de Sistemas 2026 - Felipe, Guilherme, Matheus, Pedro.
</footer>

<!-- Script interativo para gerenciar a seleção dos cartões -->
<script>
    document.querySelectorAll('.track-card').forEach(card => {
        card.addEventListener('click', () => {
            // Remove a seleção do cartão anterior e destaca o novo
            document.querySelectorAll('.track-card').forEach(c => c.classList.remove('active'));
            card.classList.add('active');

            // Atualiza o valor do input hidden e o texto de confirmação
            document.getElementById('selected-vote-input').value = card.dataset.index;
            document.getElementById('selected-label').textContent = card.dataset.name;
        });
    });
</script>

</body>
</html>