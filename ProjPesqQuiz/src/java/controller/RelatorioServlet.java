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
import model.ResumoRelatorio;

@WebServlet(name = "RelatorioServlet", urlPatterns = {"/RelatorioServlet"})
public class RelatorioServlet extends HttpServlet {

    private final ParticipacaoQuizDAO dao = new ParticipacaoQuizDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            List<ParticipacaoQuiz> participacoes = dao.listarTodos();
            ResumoRelatorio resumo = dao.gerarResumoRelatorio();

            request.setAttribute("participacoes", participacoes);
            request.setAttribute("resumo", resumo);
            request.getRequestDispatcher("relatorios.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("erro", "Erro ao gerar relatórios: " + e.getMessage());
            request.getRequestDispatcher("relatorios.jsp").forward(request, response);
        }
    }
}