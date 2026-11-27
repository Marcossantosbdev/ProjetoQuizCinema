package controller;

import dao.ParticipacaoQuizDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ParticipacaoQuiz;

@WebServlet(name = "ParticipacaoCrudServlet", urlPatterns = {"/ParticipacaoCrudServlet"})
public class ParticipacaoCrudServlet extends HttpServlet {

    private final ParticipacaoQuizDAO dao = new ParticipacaoQuizDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");
        if (acao == null || acao.isEmpty()) {
            acao = "listar";
        }

        try {
            switch (acao) {
                case "editar": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ParticipacaoQuiz participacao = dao.buscarPorId(id);
                    request.setAttribute("participacao", participacao);
                    request.getRequestDispatcher("editar_participacao.jsp").forward(request, response);
                    break;
                }
                case "excluir": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    dao.excluir(id);
                    response.sendRedirect("ParticipacaoCrudServlet?acao=listar&msg=excluido");
                    break;
                }
                case "listar":
                default: {
                    List<ParticipacaoQuiz> lista = dao.listarTodos();
                    request.setAttribute("listaParticipacoes", lista);
                    request.getRequestDispatcher("gerenciar_quiz.jsp").forward(request, response);
                    break;
                }
            }
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("erro", "Erro na operação CRUD: " + e.getMessage());
            request.getRequestDispatcher("gerenciar_quiz.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");

        try {
            if ("atualizar".equals(acao)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String nome = request.getParameter("nomeEntrevistado");

                ParticipacaoQuiz p = new ParticipacaoQuiz();
                p.setId(id);
                p.setNomeEntrevistado(nome != null ? nome.trim() : "");
                p.setQ1(Integer.parseInt(request.getParameter("q1")));
                p.setQ2(Integer.parseInt(request.getParameter("q2")));
                p.setQ3(Integer.parseInt(request.getParameter("q3")));
                p.setQ4(Integer.parseInt(request.getParameter("q4")));
                p.setQ5(Integer.parseInt(request.getParameter("q5")));
                p.setQ6(Integer.parseInt(request.getParameter("q6")));
                p.setQ7(Integer.parseInt(request.getParameter("q7")));
                p.setQ8(Integer.parseInt(request.getParameter("q8")));

                dao.atualizar(p);
                response.sendRedirect("ParticipacaoCrudServlet?acao=listar&msg=atualizado");
            } else {
                response.sendRedirect("ParticipacaoCrudServlet?acao=listar");
            }
        } catch (IllegalArgumentException | SQLException e) {
            request.setAttribute("erro", "Erro ao atualizar registro: " + e.getMessage());
            request.getRequestDispatcher("gerenciar_quiz.jsp").forward(request, response);
        }
    }
}