<%@page import="model.ParticipacaoQuiz"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Participação - Quiz de Cinema</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121417;
            color: #f1f5f9;
            margin: 0;
            padding: 24px;
        }
        .container {
            max-width: 720px;
            margin: 0 auto;
            background: #1e2229;
            padding: 24px;
            border-radius: 10px;
        }
        nav {
            margin-bottom: 20px;
        }
        nav a {
            color: #f59e0b;
            margin-right: 16px;
            text-decoration: none;
            font-weight: bold;
        }
        .campo {
            margin-bottom: 14px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #475569;
            background: #0f172a;
            color: #fff;
            box-sizing: border-box;
        }
        button {
            background: #16a34a;
            color: #fff;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .cancelar {
            margin-left: 12px;
            color: #cbd5e1;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container">
    <nav>
        <a href="index.html">Início (Cinema)</a>
        <a href="quiz.jsp">Responder Quiz</a>
        <a href="ParticipacaoCrudServlet?acao=listar">Gerenciar (CRUD)</a>
        <a href="RelatorioServlet">Relatórios</a>
    </nav>

    <h1>✏️ Editar Participação</h1>

    <%
        ParticipacaoQuiz p = (ParticipacaoQuiz) request.getAttribute("participacao");
        if (p == null) {
    %>
        <p>Registro não encontrado.</p>
    <% } else { %>
        <form action="ParticipacaoCrudServlet" method="post">
            <input type="hidden" name="acao" value="atualizar">
            <input type="hidden" name="id" value="<%= p.getId() %>">

            <div class="campo">
                <label for="nomeEntrevistado">Nome do entrevistado:</label>
                <input type="text" id="nomeEntrevistado" name="nomeEntrevistado"
                       value="<%= p.getNomeEntrevistado() %>" required>
            </div>

            <% for (int i = 1; i <= 8; i++) {
                   int atual = p.getResposta(i);
            %>
            <div class="campo">
                <label for="q<%= i %>">Questão <%= i %> (Opção 1 a 4):</label>
                <select id="q<%= i %>" name="q<%= i %>" required>
                    <option value="1" <%= (atual == 1) ? "selected" : "" %>>1 - Alternativa 1</option>
                    <option value="2" <%= (atual == 2) ? "selected" : "" %>>2 - Alternativa 2</option>
                    <option value="3" <%= (atual == 3) ? "selected" : "" %>>3 - Alternativa 3</option>
                    <option value="4" <%= (atual == 4) ? "selected" : "" %>>4 - Alternativa 4</option>
                </select>
            </div>
            <% } %>

            <button type="submit">Salvar Alterações</button>
            <a class="cancelar" href="ParticipacaoCrudServlet?acao=listar">Cancelar</a>
        </form>
    <% } %>
</div>
</body>
</html>