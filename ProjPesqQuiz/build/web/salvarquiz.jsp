<%-- 
    Document   : salvarquiz (grava a edição feita em editarquiz.jsp)
    Projeto    : ProjPesqQuiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.EditarDAO"%>
<%@page import="model.QuizBean"%>
<%@page import="model.QuizConteudo"%>
<%@page import="util.Html"%>
<%
    request.setCharacterEncoding("UTF-8");
    QuizBean quiz = new QuizBean();
    boolean valido = true;
    String nome = request.getParameter("nome");
    try {
        quiz.setId(Integer.parseInt(request.getParameter("id")));
        if (nome == null || nome.trim().isEmpty()) {
            valido = false;
        } else {
            nome = nome.trim();
            if (nome.length() > 100) {
                nome = nome.substring(0, 100);
            }
            quiz.setNome(nome);
        }
        for (int q = 1; q <= QuizConteudo.TOTAL_QUESTOES; q++) {
            int valor = Integer.parseInt(request.getParameter("r" + q));
            if (valor < 1 || valor > QuizConteudo.TOTAL_ALTERNATIVAS) {
                valido = false;
            } else {
                quiz.setResposta(q, valor);
            }
        }
    } catch (NumberFormatException e) {
        valido = false;
    }
    boolean alterou = false;
    if (valido) {
        EditarDAO edit = new EditarDAO();
        alterou = edit.Editar(quiz);
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Salvar Alterações</title>
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
                <%
                    if (!valido) {
                %>
                <h1>Dados inválidos</h1>
                <div class="msg msg-erro">Informe o nome e escolha uma alternativa em todas as questões.</div>
                <%
                    } else if (alterou) {
                %>
                <h1>Alteração Efetuada</h1>
                <div class="msg msg-ok">Participação de <strong><%= Html.escapar(quiz.getNome()) %></strong> atualizada com sucesso!!!</div>
                <%
                    } else {
                %>
                <h1>Registro não alterado</h1>
                <div class="msg msg-erro">Registro não encontrado ou erro ao gravar no banco de dados.</div>
                <%
                    }
                %>
                <div class="acoes">
                    <a class="btn btn-azul" href="Listar.jsp">Voltar à Listagem</a>
                    <a class="btn btn-claro" href="MenuQuiz.html">Menu</a>
                </div>
            </div>
        </div>
    </body>
</html>
