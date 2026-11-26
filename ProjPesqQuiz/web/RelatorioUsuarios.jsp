<%-- 
    Document   : RelatorioUsuarios (relatório 1: cada usuário e suas respostas)
    Projeto    : ProjPesqQuiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.ListarDAO"%>
<%@page import="model.QuizBean"%>
<%@page import="model.QuizConteudo"%>
<%@page import="util.Html"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Relatório 1 – Usuários e Respostas</title>
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
                <h1>Relatório 1 – Usuários e suas respostas</h1>
                <p style="text-align:center">Os números indicam a alternativa escolhida em cada questão.
                   Em <span class="certo">verde</span> as respostas corretas e em <span class="errado">vermelho</span> as incorretas.</p>
                <div class="rolagem">
                <table class="tabela">
                    <thead>
                        <tr>
                            <th>Usuário</th>
                            <%
                                for (int q = 1; q <= QuizConteudo.TOTAL_QUESTOES; q++) {
                            %>
                            <th class="centro">Q<%= q %></th>
                            <%
                                }
                            %>
                            <th class="centro">Acertos</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                ListarDAO dao = new ListarDAO();
                                List<QuizBean> lista = dao.Listar();
                                if (lista.isEmpty()) {
                        %>
                        <tr><td colspan="10" class="centro">Nenhuma participação cadastrada.</td></tr>
                        <%
                                }
                                for (QuizBean p : lista) {
                                    int[] respostas = p.getRespostas();
                        %>
                        <tr>
                            <td><%= Html.escapar(p.getNome()) %></td>
                            <%
                                    for (int q = 1; q <= QuizConteudo.TOTAL_QUESTOES; q++) {
                                        boolean certa = (respostas[q - 1] == QuizConteudo.getGabarito(q));
                            %>
                            <td class="centro <%= certa ? "certo" : "errado" %>"><%= respostas[q - 1] %></td>
                            <%
                                    }
                            %>
                            <td class="centro"><strong><%= QuizConteudo.calcularAcertos(p) %>/<%= QuizConteudo.TOTAL_QUESTOES %></strong></td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                        %>
                        <tr><td colspan="10">Erro: <%= Html.escapar(String.valueOf(e.getMessage())) %></td></tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                </div>
                <div class="acoes">
                    <a class="btn btn-verde" href="RelatorioResumo.jsp">Ir para o Relatório 2 (Resumo)</a>
                    <a class="btn btn-claro" href="MenuQuiz.html">Voltar ao Menu</a>
                </div>
            </div>
        </div>
    </body>
</html>
