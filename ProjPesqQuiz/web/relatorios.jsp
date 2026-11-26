<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@page import="model.ParticipacaoQuiz"%>
<%@page import="model.ResumoRelatorio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relatórios - Quiz de Cinema</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121417;
            color: #f1f5f9;
            margin: 0;
            padding: 24px;
        }
        .container {
            max-width: 1050px;
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
        .card-resumo {
            background: #272c36;
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 24px;
            border-left: 4px solid #f59e0b;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 12px;
            margin-bottom: 28px;
            background: #272c36;
        }
        th, td {
            border: 1px solid #3b4252;
            padding: 10px;
            text-align: center;
        }
        th {
            background: #0f172a;
            color: #f8fafc;
        }
        td.nome {
            text-align: left;
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

    <h1>📊 Relatórios da Pesquisa de Cinema</h1>

    <%
        ResumoRelatorio resumo = (ResumoRelatorio) request.getAttribute("resumo");
        List<ParticipacaoQuiz> participacoes = (List<ParticipacaoQuiz>) request.getAttribute("participacoes");
        int total = (resumo != null) ? resumo.getTotalEntrevistados() : 0;
    %>

    <h2>1. Relatório por Usuário e Respostas</h2>
    <% if (participacoes == null || participacoes.isEmpty()) { %>
        <p>Nenhum entrevistado registrado até o momento.</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Entrevistado</th>
                    <th>Q1</th>
                    <th>Q2</th>
                    <th>Q3</th>
                    <th>Q4</th>
                    <th>Q5</th>
                    <th>Q6</th>
                    <th>Q7</th>
                    <th>Q8</th>
                </tr>
            </thead>
            <tbody>
                <% for (ParticipacaoQuiz p : participacoes) { %>
                <tr>
                    <td class="nome"><%= p.getNomeEntrevistado() %></td>
                    <td><%= p.getQ1() %></td>
                    <td><%= p.getQ2() %></td>
                    <td><%= p.getQ3() %></td>
                    <td><%= p.getQ4() %></td>
                    <td><%= p.getQ5() %></td>
                    <td><%= p.getQ6() %></td>
                    <td><%= p.getQ7() %></td>
                    <td><%= p.getQ8() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <h2>2. Relatório Resumo (Entrevistados e Percentuais)</h2>
    <div class="card-resumo">
        <strong>Número total de entrevistados:</strong> <%= total %>
    </div>

    <table>
        <thead>
            <tr>
                <th>Questão</th>
                <th>Opção 1 (%)</th>
                <th>Opção 2 (%)</th>
                <th>Opção 3 (%)</th>
                <th>Opção 4 (%)</th>
            </tr>
        </thead>
        <tbody>
            <% for (int q = 1; q <= 8; q++) {
                   double p1 = (resumo != null) ? resumo.getPercentual(q, 1) : 0.0;
                   double p2 = (resumo != null) ? resumo.getPercentual(q, 2) : 0.0;
                   double p3 = (resumo != null) ? resumo.getPercentual(q, 3) : 0.0;
                   double p4 = (resumo != null) ? resumo.getPercentual(q, 4) : 0.0;
            %>
            <tr>
                <td><strong>Questão <%= q %></strong></td>
                <td><%= String.format(Locale.US, "%.1f%%", p1) %></td>
                <td><%= String.format(Locale.US, "%.1f%%", p2) %></td>
                <td><%= String.format(Locale.US, "%.1f%%", p3) %></td>
                <td><%= String.format(Locale.US, "%.1f%%", p4) %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>