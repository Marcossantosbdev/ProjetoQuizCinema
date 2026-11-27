<%-- 
    Document   : excluirquiz (exclui a participação escolhida na listagem)
    Projeto    : ProjPesqQuiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.ExcluirDAO"%>
<%@page import="util.Html"%>
<%
    boolean excluiu = false;
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        ExcluirDAO excluir = new ExcluirDAO();
        excluiu = excluir.Excluir(id);
    } catch (NumberFormatException e) {
        excluiu = false;
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Excluir Registro</title>
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
                    if (excluiu) {
                %>
                <h1>Registro Excluído</h1>
                <div class="msg msg-ok">Registro excluído com sucesso !!!</div>
                <%
                    } else {
                %>
                <h1>Erro na Exclusão</h1>
                <div class="msg msg-erro">Erro na Exclusão / Registro não existe !!!</div>
                <%
                    }
                %>
                <div class="acoes">
                    <a class="btn btn-azul" href="Listar.jsp">Voltar à Listagem</a>
                    <a class="btn btn-claro" href="index.html">Voltar à Página Inicial</a>
                </div>
            </div>
        </div>
    </body>
</html>
