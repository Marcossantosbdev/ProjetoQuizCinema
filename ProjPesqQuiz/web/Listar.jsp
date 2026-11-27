<%-- 
    Document   : Listar (lista as participações com opções de editar e excluir)
    Projeto    : ProjPesqQuiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.ListarDAO"%>
<%@page import="model.QuizBean"%>
<%@page import="java.util.List"%>
<%@page import="util.Html"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Participações Cadastradas</title>
        <link rel="stylesheet" href="css/estilo.css">
    </head>
    <body>
        <header class="topo">
            <a class="logo" href="index.html">🪐 Sistema Solar</a>
            <nav>
                <a href="index.html">Início</a>
                <a href="Quiz.jsp">Quiz</a>
                <a href="MenuQuiz.html">Gerenciar</a>
            </nav>
        </header>
        <div class="pagina">
            <div class="caixa">
                <h1>Listar Participações</h1>
                <div class="rolagem">
                <table class="tabela">
                    <thead>
                        <tr>
                            <th>nome</th>
                            <th class="centro">r1</th><th class="centro">r2</th><th class="centro">r3</th><th class="centro">r4</th>
                            <th class="centro">r5</th><th class="centro">r6</th><th class="centro">r7</th><th class="centro">r8</th>
                            <th colspan="2" class="centro">ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                ListarDAO dao = new ListarDAO();
                                List<QuizBean> lista = dao.Listar();
                                if (lista.isEmpty()) {
                        %>
                        <tr><td colspan="11" class="centro">Nenhuma participação cadastrada.</td></tr>
                        <%
                                }
                                for (QuizBean p : lista) {
                        %>
                        <tr>
                            <td><%= Html.escapar(p.getNome()) %></td>
                            <td class="centro"><%= p.getR1() %></td>
                            <td class="centro"><%= p.getR2() %></td>
                            <td class="centro"><%= p.getR3() %></td>
                            <td class="centro"><%= p.getR4() %></td>
                            <td class="centro"><%= p.getR5() %></td>
                            <td class="centro"><%= p.getR6() %></td>
                            <td class="centro"><%= p.getR7() %></td>
                            <td class="centro"><%= p.getR8() %></td>
                            <td><a href="editarquiz.jsp?id=<%= p.getId() %>" class="btn btn-azul btn-pequeno">Editar</a></td>
                            <td><a href="excluirquiz.jsp?id=<%= p.getId() %>" class="btn btn-vermelho btn-pequeno"
                                   onclick="return confirm('Deseja realmente excluir esta participação?');">Excluir</a></td>
                        </tr>
                        <%
                                }   // fecha o for
                            } catch (Exception e) {
                        %>
                        <tr><td colspan="11">Erro: <%= Html.escapar(String.valueOf(e.getMessage())) %></td></tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                </div>
                <div class="acoes">
                    <a class="btn" href="Quiz.jsp">Nova participação</a>
                    <a class="btn btn-claro" href="MenuQuiz.html">Voltar ao Menu</a>
                </div>
            </div>
        </div>
    </body>
</html>
