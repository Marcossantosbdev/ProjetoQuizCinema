package DAO;

import java.sql.*;
import model.QuizConteudo;
import model.ResumoRelatorio;
import util.ConectaBD;

public class RelatorioDAO {

    /**
     * Monta o resumo com uma única consulta: total de entrevistados e, para cada
     * questão, quantos escolheram cada alternativa (SUM de comparações r?=alternativa).
     * O SQL é montado só com números fixos (nada vem do usuário).
     */
    public ResumoRelatorio Gerar() throws ClassNotFoundException, SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS total");
        for (int q = 1; q <= QuizConteudo.TOTAL_QUESTOES; q++) {
            for (int a = 1; a <= QuizConteudo.TOTAL_ALTERNATIVAS; a++) {
                sql.append(", SUM(r").append(q).append("=").append(a)
                   .append(") AS q").append(q).append("a").append(a);
            }
        }
        sql.append(" FROM participacao");

        ResumoRelatorio resumo = new ResumoRelatorio();
        try (Connection conexao = ConectaBD.conectar();
             PreparedStatement ps = conexao.prepareStatement(sql.toString());
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                resumo.setTotalParticipantes(rs.getInt("total"));
                for (int q = 1; q <= QuizConteudo.TOTAL_QUESTOES; q++) {
                    for (int a = 1; a <= QuizConteudo.TOTAL_ALTERNATIVAS; a++) {
                        // SUM retorna NULL quando a tabela está vazia; getInt devolve 0
                        resumo.setContagem(q, a, rs.getInt("q" + q + "a" + a));
                    }
                }
            }
        }
        return resumo;
    }

}
