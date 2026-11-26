package controller;

import dao.ParticipacaoQuizDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ParticipacaoQuiz;

@WebServlet(name = "QuizServlet", urlPatterns = {"/QuizServlet"})
public class QuizServlet extends HttpServlet {

    private final ParticipacaoQuizDAO dao = new ParticipacaoQuizDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String nome = request.getParameter("nomeEntrevistado");
            if (nome == null || nome.trim().isEmpty()) {
                request.setAttribute("erro", "Informe o nome do entrevistado.");
                request.getRequestDispatcher("quiz.jsp").forward(request, response);
                return;
            }

            int q1 = Integer.parseInt(request.getParameter("q1"));
            int q2 = Integer.parseInt(request.getParameter("q2"));
            int q3 = Integer.parseInt(request.getParameter("q3"));
            int q4 = Integer.parseInt(request.getParameter("q4"));
            int q5 = Integer.parseInt(request.getParameter("q5"));
            int q6 = Integer.parseInt(request.getParameter("q6"));
            int q7 = Integer.parseInt(request.getParameter("q7"));
            int q8 = Integer.parseInt(request.getParameter("q8"));

            ParticipacaoQuiz participacao = new ParticipacaoQuiz(
                    nome.trim(), q1, q2, q3, q4, q5, q6, q7, q8
            );

            boolean salvou = dao.cadastrar(participacao);
            if (salvou) {
                response.sendRedirect("ParticipacaoCrudServlet?acao=listar&msg=cadastrado");
            } else {
                request.setAttribute("erro", "Não foi possível salvar a participação no banco.");
                request.getRequestDispatcher("quiz.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Responda todas as 8 questões com alternativas de 1 a 4.");
            request.getRequestDispatcher("quiz.jsp").forward(request, response);
        } catch (IllegalArgumentException | SQLException e) {
            request.setAttribute("erro", "Erro ao registrar participação: " + e.getMessage());
            request.getRequestDispatcher("quiz.jsp").forward(request, response);
        }
    }
}