<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.repository.TrilhaRepository, com.service.TrilhaService, com.model.Trilha, java.util.List" %>
<%
    request.setCharacterEncoding("UTF-8");
    String caminho = application.getRealPath("/recursos/trilhas.txt");
    List<Trilha> trilhas = new TrilhaService(new TrilhaRepository(caminho)).TrilhaOrd();

    int totalVotos = 0;
    if (trilhas != null) {
        for (Trilha t : trilhas) totalVotos += t.getVotos();
    }

    Trilha p1 = (trilhas != null && trilhas.size() > 0) ? trilhas.get(0) : null;
    Trilha p2 = (trilhas != null && trilhas.size() > 1) ? trilhas.get(1) : null;
    Trilha p3 = (trilhas != null && trilhas.size() > 2) ? trilhas.get(2) : null;
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultados | Mundo SENAI</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 text-slate-800 p-6 min-h-screen">

<main class="max-w-4xl mx-auto space-y-8">

    <%-- Cabeçalho --%>
    <div class="flex items-center justify-between border-b pb-4">
        <div>
            <h1 class="text-2xl font-bold">Resultado da Votação</h1>
            <p class="text-sm text-slate-500">Total de votos: <strong><%= totalVotos %></strong></p>
        </div>
        <a href="index.jsp" class="bg-indigo-600 text-white px-4 py-2 rounded-lg font-semibold text-sm hover:bg-indigo-700">
            ← Voltar
        </a>
    </div>

    <% if (trilhas != null && !trilhas.isEmpty()) { %>

    <%-- Pódio Top 3 --%>
    <div class="flex items-end justify-center gap-4 py-6">
        <%-- 2º Lugar --%>
        <% if (p2 != null) { %>
        <div class="flex flex-col items-center w-1/3">
            <span class="text-xs font-bold text-slate-400">2º LUGAR</span>
            <h4 class="font-bold text-slate-800 text-center"><%= p2.getNome() %></h4>
            <span class="text-xs font-bold text-indigo-600 bg-slate-100 px-2 py-0.5 rounded-full mb-2"><%= p2.getVotos() %> votos</span>
            <div class="w-full h-48 bg-slate-100 border-2 border-slate-200 rounded-2xl flex flex-col justify-between p-3 text-center shadow-sm">
                <span class="text-lg font-black text-slate-600">2º</span>
                <span class="bg-white rounded-lg text-xs py-1 text-slate-500 font-medium">Vice-Líder</span>
            </div>
        </div>
        <% } %>

        <%-- 1º Lugar --%>
        <% if (p1 != null) { %>
        <div class="flex flex-col items-center w-1/3">
            <span class="text-xl">👑</span>
            <h4 class="font-bold text-slate-900 text-center"><%= p1.getNome() %></h4>
            <span class="text-xs font-bold text-amber-700 bg-amber-100 px-2 py-0.5 rounded-full mb-2"><%= p1.getVotos() %> votos</span>
            <div class="w-full h-64 bg-amber-400 border-2 border-amber-500 rounded-2xl flex flex-col justify-between p-3 text-center shadow-md">
                <span class="text-2xl font-black text-amber-900">1º</span>
                <span class="bg-white/90 rounded-lg text-xs py-1 text-amber-900 font-bold uppercase">Top Votado</span>
            </div>
        </div>
        <% } %>

        <%-- 3º Lugar --%>
        <% if (p3 != null) { %>
        <div class="flex flex-col items-center w-1/3">
            <span class="text-xs font-bold text-orange-400">3º LUGAR</span>
            <h4 class="font-bold text-slate-800 text-center"><%= p3.getNome() %></h4>
            <span class="text-xs font-bold text-orange-600 bg-orange-100 px-2 py-0.5 rounded-full mb-2"><%= p3.getVotos() %> votos</span>
            <div class="w-full h-36 bg-orange-100 border-2 border-orange-200 rounded-2xl flex flex-col justify-between p-3 text-center shadow-sm">
                <span class="text-lg font-black text-orange-700">3º</span>
                <span class="bg-white rounded-lg text-xs py-1 text-orange-800 font-medium">3º Colocado</span>
            </div>
        </div>
        <% } %>
    </div>

    <%-- Classificação Geral --%>
    <div class="bg-white rounded-2xl border p-6 space-y-4 shadow-sm">
        <h3 class="font-bold text-lg text-slate-900 border-b pb-3">Classificação Geral</h3>
        <% for (int i = 0; i < trilhas.size(); i++) {
            Trilha t = trilhas.get(i);
            double pct = totalVotos > 0 ? ((double) t.getVotos() / totalVotos) * 100 : 0;
            String pctStr = String.format("%.1f", pct).replace(",", ".");
        %>
        <div class="flex flex-col sm:flex-row items-center gap-4 p-3 hover:bg-slate-50 rounded-xl border-b last:border-0">
            <span class="font-bold text-sm bg-slate-100 text-slate-700 w-8 h-8 flex items-center justify-center rounded-lg shrink-0">#<%= i + 1 %></span>

            <div class="flex-1 w-full">
                <h4 class="font-bold text-slate-900"><%= t.getNome() %></h4>
                <p class="text-xs text-slate-500"><%= t.getDescricao() %></p>
                <div class="w-full bg-slate-100 h-2 rounded-full mt-2 overflow-hidden">
                    <div class="bg-indigo-600 h-full rounded-full" style="width: <%= pctStr %>%;"></div>
                </div>
            </div>

            <div class="text-right shrink-0">
                <span class="block text-lg font-extrabold text-indigo-600"><%= pctStr %>%</span>
                <span class="text-xs text-slate-400"><%= t.getVotos() %> votos</span>
            </div>
        </div>
        <% } %>
    </div>

    <% } else { %>
    <div class="p-4 bg-red-50 text-red-600 rounded-xl border border-red-200 text-center">
        Nenhuma trilha foi encontrada no arquivo trilhas.txt.
    </div>
    <% } %>

</main>

</body>
</html>