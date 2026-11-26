<%-- 
    Document   : Quiz (formulário de cadastro das respostas)
    Projeto    : ProjPesqQuiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.QuizConteudo"%>
<%@page import="util.Html"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quiz – Sistema Solar</title>
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
                <h1>Quiz – Sistema Solar</h1>
                <p style="text-align:center">Informe seu nome e escolha uma alternativa (1 a 4) em cada questão.</p>
                <form method="POST" action="Cadastro.jsp">
                    <label class="campo" for="nome">Seu nome:</label>
                    <input type="text" id="nome" name="nome" maxlength="100" required>

                    <%
                        for (int q = 1; q <= QuizConteudo.TOTAL_QUESTOES; q++) {
                    %>
                    <fieldset class="questao">
                        <legend><%= q %>. <%= Html.escapar(QuizConteudo.getEnunciado(q)) %></legend>
                        <%
                            for (int a = 1; a <= QuizConteudo.TOTAL_ALTERNATIVAS; a++) {
                        %>
                        <label class="opcao">
                            <input type="radio" name="r<%= q %>" value="<%= a %>" required>
                            <%= a %>) <%= Html.escapar(QuizConteudo.getAlternativa(q, a)) %>
                        </label>
                        <%
                            }
                        %>
                    </fieldset>
                    <%
                        }
                    %>

                    <div class="acoes">
                        <input class="btn" type="submit" value="ENVIAR RESPOSTAS">
                        <a class="btn btn-claro" href="index.html">Voltar à Página Inicial</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
