<%-- 
    Document   : RelatorioResumo (relatório 2: total de entrevistados e percentuais)
    Projeto    : ProjPesqQuiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.RelatorioDAO"%>
<%@page import="model.ResumoRelatorio"%>
<%@page import="model.QuizConteudo"%>
<%@page import="util.Html"%>
<%@page import="util.Formato"%>
<%
    ResumoRelatorio resumo = null;
    String erro = null;
    try {
        RelatorioDAO dao = new RelatorioDAO();
        resumo = dao.Gerar();
    } catch (Exception e) {
        erro = "Erro: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Relatório 2 – Resumo</title>
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
                <h1>Relatório 2 – Resumo das respostas</h1>
                <%
                    if (erro != null) {
                %>
                <div class="msg msg-erro"><%= Html.escapar(erro) %></div>
                <%
                    } else {
                %>
                <p class="totais">Total de entrevistados: <strong><%= resumo.getTotalParticipantes() %></strong></p>
                <%
                        if (resumo.getTotalParticipantes() == 0) {
                %>
                <div class="msg msg-erro">Ainda não há participações para calcular os percentuais.</div>
                <%
                        }
                        for (int q = 1; q <= QuizConteudo.TOTAL_QUESTOES; q++) {
                %>
                <div class="resumo-questao">
                    <h3><%= q %>. <%= Html.escapar(QuizConteudo.getEnunciado(q)) %></h3>
                    <%
                            for (int a = 1; a <= QuizConteudo.TOTAL_ALTERNATIVAS; a++) {
                                double pct = resumo.getPercentual(q, a);
                                boolean correta = (a == QuizConteudo.getGabarito(q));
                    %>
                    <div class="linha-barra">
                        <span><%= a %>) <%= Html.escapar(QuizConteudo.getAlternativa(q, a)) %><%= correta ? " ✔" : "" %></span>
                        <div class="barra-fundo">
                            <div class="barra-valor <%= correta ? "correta" : "" %>" style="width:<%= Formato.larguraCss(pct) %>%"></div>
                        </div>
                        <small><%= resumo.getContagem(q, a) %> resp. – <%= Formato.percentual(pct) %></small>
                    </div>
                    <%
                            }
                    %>
                </div>
                <%
                        }
                %>
                <p style="text-align:center"><span class="certo">✔ = alternativa correta</span></p>
                <%
                    }
                %>
                <div class="acoes">
                    <a class="btn btn-verde" href="RelatorioUsuarios.jsp">Ir para o Relatório 1 (Usuários)</a>
                    <a class="btn btn-claro" href="MenuQuiz.html">Voltar ao Menu</a>
                </div>
            </div>
        </div>
    </body>
</html>
