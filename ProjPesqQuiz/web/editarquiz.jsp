<%-- 
    Document   : editarquiz (formulário de edição, carrega os dados do banco)
    Projeto    : ProjPesqQuiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.ListarDAO"%>
<%@page import="model.QuizBean"%>
<%@page import="model.QuizConteudo"%>
<%@page import="util.Html"%>
<%
    // carrega o registro escolhido na listagem
    QuizBean quiz = null;
    String erro = null;
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        ListarDAO dao = new ListarDAO();
        quiz = dao.Buscar(id);
        if (quiz == null) {
            erro = "Registro não encontrado.";
        }
    } catch (NumberFormatException e) {
        erro = "Identificador inválido.";
    } catch (Exception e) {
        erro = "Erro: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Participação</title>
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
                <h1>Editar Participação</h1>
                <%
                    if (erro != null) {
                %>
                <div class="msg msg-erro"><%= Html.escapar(erro) %></div>
                <%
                    } else {
                        int[] respostas = quiz.getRespostas();
                %>
                <form method="post" action="salvarquiz.jsp">
                    <input type="hidden" name="id" value="<%= quiz.getId() %>">
                    <label class="campo" for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" maxlength="100" value="<%= Html.escapar(quiz.getNome()) %>" required>

                    <%
                        for (int q = 1; q <= QuizConteudo.TOTAL_QUESTOES; q++) {
                    %>
                    <fieldset class="questao">
                        <legend><%= q %>. <%= Html.escapar(QuizConteudo.getEnunciado(q)) %></legend>
                        <%
                            for (int a = 1; a <= QuizConteudo.TOTAL_ALTERNATIVAS; a++) {
                        %>
                        <label class="opcao">
                            <input type="radio" name="r<%= q %>" value="<%= a %>" <%= (respostas[q - 1] == a) ? "checked" : "" %> required>
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
                        <button class="btn" type="submit">SALVAR ALTERAÇÕES</button>
                        <a class="btn btn-claro" href="Listar.jsp">Cancelar</a>
                    </div>
                </form>
                <%
                    }
                %>
                <%
                    if (erro != null) {
                %>
                <div class="acoes"><a class="btn btn-claro" href="Listar.jsp">Voltar à Listagem</a></div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>
