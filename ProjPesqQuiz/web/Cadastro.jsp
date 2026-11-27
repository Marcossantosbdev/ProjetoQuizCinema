<%-- 
    Document   : Cadastro (grava as respostas do quiz e mostra o resultado)
    Projeto    : ProjPesqQuiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.InserirDAO"%>
<%@page import="model.QuizBean"%>
<%@page import="model.QuizConteudo"%>
<%@page import="util.Html"%>
<%
    // buscando os dados do formulário
    request.setCharacterEncoding("UTF-8");
    String nome = request.getParameter("nome");
    boolean valido = (nome != null && !nome.trim().isEmpty());

    // criando a instância da classe modelo e encapsulando
    QuizBean quiz = new QuizBean();
    if (valido) {
        nome = nome.trim();
        if (nome.length() > 100) {
            nome = nome.substring(0, 100);
        }
        quiz.setNome(nome);
        for (int q = 1; q <= QuizConteudo.TOTAL_QUESTOES; q++) {
            try {
                int valor = Integer.parseInt(request.getParameter("r" + q));
                if (valor < 1 || valor > QuizConteudo.TOTAL_ALTERNATIVAS) {
                    valido = false;
                } else {
                    quiz.setResposta(q, valor);
                }
            } catch (NumberFormatException e) {
                valido = false;   // resposta ausente ou inválida
            }
        }
    }
    boolean gravou = false;
    if (valido) {
        InserirDAO dao = new InserirDAO();
        gravou = dao.Inserir(quiz);
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Resultado do Quiz</title>
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
                <h1>Quiz incompleto</h1>
                <div class="msg msg-erro">Informe o seu nome e responda todas as questões.</div>
                <div class="acoes"><a class="btn" href="Quiz.jsp">Voltar ao Quiz</a></div>
                <%
                    } else if (!gravou) {
                %>
                <h1>Erro no Cadastro</h1>
                <div class="msg msg-erro">Não foi possível gravar suas respostas. Verifique se o banco de dados (quizbd) está ligado.</div>
                <div class="acoes"><a class="btn" href="Quiz.jsp">Tentar novamente</a></div>
                <%
                    } else {
                        int acertos = QuizConteudo.calcularAcertos(quiz);
                        int[] respostas = quiz.getRespostas();
                %>
                <h1>Obrigado, <%= Html.escapar(quiz.getNome()) %>!</h1>
                <div class="msg msg-ok">Dados inseridos com sucesso!!!</div>
                <p class="placar">Você acertou <strong><%= acertos %></strong> de <%= QuizConteudo.TOTAL_QUESTOES %> questões</p>

                <div class="rolagem">
                <table class="tabela">
                    <thead>
                        <tr><th>Questão</th><th>Sua resposta</th><th>Resposta correta</th><th class="centro">Resultado</th></tr>
                    </thead>
                    <tbody>
                        <%
                            for (int q = 1; q <= QuizConteudo.TOTAL_QUESTOES; q++) {
                                int minha = respostas[q - 1];
                                int certa = QuizConteudo.getGabarito(q);
                        %>
                        <tr>
                            <td><%= q %>. <%= Html.escapar(QuizConteudo.getEnunciado(q)) %></td>
                            <td><%= minha %>) <%= Html.escapar(QuizConteudo.getAlternativa(q, minha)) %></td>
                            <td><%= certa %>) <%= Html.escapar(QuizConteudo.getAlternativa(q, certa)) %></td>
                            <td class="centro <%= (minha == certa) ? "certo" : "errado" %>"><%= (minha == certa) ? "✔ Acertou" : "✘ Errou" %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                </div>
                <div class="acoes">
                    <a class="btn btn-verde" href="RelatorioResumo.jsp">Ver o resumo de todos os participantes</a>
                    <a class="btn btn-claro" href="index.html">Voltar à Página Inicial</a>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>
