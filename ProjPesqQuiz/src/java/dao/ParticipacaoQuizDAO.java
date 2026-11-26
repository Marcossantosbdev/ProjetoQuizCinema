package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.ParticipacaoQuiz;
import model.ResumoRelatorio;

public class ParticipacaoQuizDAO {

    public boolean cadastrar(ParticipacaoQuiz p) throws SQLException {
        String sql = "INSERT INTO participacoes (nome_entrevistado, q1, q2, q3, q4, q5, q6, q7, q8) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, p.getNomeEntrevistado());
            stmt.setInt(2, p.getQ1());
            stmt.setInt(3, p.getQ2());
            stmt.setInt(4, p.getQ3());
            stmt.setInt(5, p.getQ4());
            stmt.setInt(6, p.getQ5());
            stmt.setInt(7, p.getQ6());
            stmt.setInt(8, p.getQ7());
            stmt.setInt(9, p.getQ8());

            return stmt.executeUpdate() > 0;
        }
    }

    public List<ParticipacaoQuiz> listarTodos() throws SQLException {
        List<ParticipacaoQuiz> lista = new ArrayList<>();
        String sql = "SELECT id, nome_entrevistado, q1, q2, q3, q4, q5, q6, q7, q8, data_registro "
                   + "FROM participacoes ORDER BY id DESC";

        try (Connection conn = ConexaoBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearParticipacao(rs));
            }
        }
        return lista;
    }

    public ParticipacaoQuiz buscarPorId(int id) throws SQLException {
        String sql = "SELECT id, nome_entrevistado, q1, q2, q3, q4, q5, q6, q7, q8, data_registro "
                   + "FROM participacoes WHERE id = ?";

        try (Connection conn = ConexaoBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearParticipacao(rs);
                }
            }
        }
        return null;
    }

    public boolean atualizar(ParticipacaoQuiz p) throws SQLException {
        String sql = "UPDATE participacoes SET nome_entrevistado = ?, "
                   + "q1 = ?, q2 = ?, q3 = ?, q4 = ?, q5 = ?, q6 = ?, q7 = ?, q8 = ? "
                   + "WHERE id = ?";

        try (Connection conn = ConexaoBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, p.getNomeEntrevistado());
            stmt.setInt(2, p.getQ1());
            stmt.setInt(3, p.getQ2());
            stmt.setInt(4, p.getQ3());
            stmt.setInt(5, p.getQ4());
            stmt.setInt(6, p.getQ5());
            stmt.setInt(7, p.getQ6());
            stmt.setInt(8, p.getQ7());
            stmt.setInt(9, p.getQ8());
            stmt.setInt(10, p.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM participacoes WHERE id = ?";

        try (Connection conn = ConexaoBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public ResumoRelatorio gerarResumoRelatorio() throws SQLException {
        List<ParticipacaoQuiz> participacoes = listarTodos();
        int total = participacoes.size();

        // questao (1..8) -> alternativa (1..4) -> contagem
        Map<Integer, Map<Integer, Integer>> contagens = new LinkedHashMap<>();
        for (int q = 1; q <= 8; q++) {
            Map<Integer, Integer> mapaAlt = new LinkedHashMap<>();
            for (int alt = 1; alt <= 4; alt++) {
                mapaAlt.put(alt, 0);
            }
            contagens.put(q, mapaAlt);
        }

        for (ParticipacaoQuiz p : participacoes) {
            for (int q = 1; q <= 8; q++) {
                int resp = p.getResposta(q);
                if (resp >= 1 && resp <= 4) {
                    Map<Integer, Integer> mapaAlt = contagens.get(q);
                    mapaAlt.put(resp, mapaAlt.get(resp) + 1);
                }
            }
        }

        Map<Integer, Map<Integer, Double>> percentuais = new LinkedHashMap<>();
        for (int q = 1; q <= 8; q++) {
            Map<Integer, Double> mapaPct = new LinkedHashMap<>();
            for (int alt = 1; alt <= 4; alt++) {
                double pct = 0.0;
                if (total > 0) {
                    pct = (contagens.get(q).get(alt) * 100.0) / total;
                }
                mapaPct.put(alt, pct);
            }
            percentuais.put(q, mapaPct);
        }

        return new ResumoRelatorio(total, percentuais);
    }

    private ParticipacaoQuiz mapearParticipacao(ResultSet rs) throws SQLException {
        ParticipacaoQuiz p = new ParticipacaoQuiz();
        p.setId(rs.getInt("id"));
        p.setNomeEntrevistado(rs.getString("nome_entrevistado"));
        p.setQ1(rs.getInt("q1"));
        p.setQ2(rs.getInt("q2"));
        p.setQ3(rs.getInt("q3"));
        p.setQ4(rs.getInt("q4"));
        p.setQ5(rs.getInt("q5"));
        p.setQ6(rs.getInt("q6"));
        p.setQ7(rs.getInt("q7"));
        p.setQ8(rs.getInt("q8"));
        p.setDataRegistro(rs.getTimestamp("data_registro"));
        return p;
    }
}