<%@page import="java.util.List"%>
<%@page import="model.ParticipacaoQuiz"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciar Participações (CRUD) - Quiz de Cinema</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 16px;
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
        .btn {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
            margin: 2px;
        }
        .btn-editar {
            background: #2563eb;
            color: #fff;
        }
        .btn-excluir {
            background: #dc2626;
            color: #fff;
        }
        .msg-ok {
            background: #14532d;
            color: #bbf7d0;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 16px;
        }
        .erro {
            background: #7f1d1d;
            color: #fecaca;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 16px;
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

    <h1>📋 Gerenciar Participações do Quiz (CRUD)</h1>
    <p>Visualize, edite ou exclua as respostas armazenadas no banco de dados.</p>

    <%
        String msg = request.getParameter("msg");
        if ("cadastrado".equals(msg)) {
    %>
        <div class="msg-ok">Participação cadastrada com sucesso!</div>
    <% } else if ("atualizado".equals(msg)) { %>
        <div class="msg-ok">Participação atualizada com sucesso!</div>
    <% } else if ("excluido".equals(msg)) { %>
        <div class="msg-ok">Participação excluída com sucesso!</div>
    <% } %>

    <% if (request.getAttribute("erro") != null) { %>
        <div class="erro"><%= request.getAttribute("erro") %></div>
    <% } %>

    <%
        List<ParticipacaoQuiz> lista = (List<ParticipacaoQuiz>) request.getAttribute("listaParticipacoes");
        if (lista == null || lista.isEmpty()) {
    %>
        <p>Nenhuma participação cadastrada ainda. <a href="quiz.jsp" style="color:#f59e0b;">Responder o quiz agora</a>.</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Entrevistado</th>
                    <th>Q1</th>
                    <th>Q2</th>
                    <th>Q3</th>
                    <th>Q4</th>
                    <th>Q5</th>
                    <th>Q6</th>
                    <th>Q7</th>
                    <th>Q8</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <% for (ParticipacaoQuiz p : lista) { %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td class="nome"><%= p.getNomeEntrevistado() %></td>
                    <td><%= p.getQ1() %></td>
                    <td><%= p.getQ2() %></td>
                    <td><%= p.getQ3() %></td>
                    <td><%= p.getQ4() %></td>
                    <td><%= p.getQ5() %></td>
                    <td><%= p.getQ6() %></td>
                    <td><%= p.getQ7() %></td>
                    <td><%= p.getQ8() %></td>
                    <td>
                        <a class="btn btn-editar" href="ParticipacaoCrudServlet?acao=editar&id=<%= p.getId() %>">Editar</a>
                        <a class="btn btn-excluir"
                           href="ParticipacaoCrudServlet?acao=excluir&id=<%= p.getId() %>"
                           onclick="return confirm('Deseja realmente excluir esta participação?');">Excluir</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>
</body>
</html>