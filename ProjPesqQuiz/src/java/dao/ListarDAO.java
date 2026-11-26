package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.QuizBean;
import util.ConectaBD;

public class ListarDAO {

    /** Lista todas as participações (usada na listagem e no relatório por usuário). */
    public List<QuizBean> Listar() throws ClassNotFoundException, SQLException {
        List<QuizBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM participacao ORDER BY id";
        try (Connection conexao = ConectaBD.conectar();
             PreparedStatement ps = conexao.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(montar(rs));
            }
        }
        return lista;
    }

    /** Busca uma participação pelo id (usada na tela de edição). Retorna null se não existir. */
    public QuizBean Buscar(int id) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM participacao WHERE id=?";
        try (Connection conexao = ConectaBD.conectar();
             PreparedStatement ps = conexao.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return montar(rs);
                }
            }
        }
        return null;
    }

    private QuizBean montar(ResultSet rs) throws SQLException {
        QuizBean q = new QuizBean();
        q.setId(rs.getInt("id"));
        q.setNome(rs.getString("nome"));
        q.setR1(rs.getInt("R1"));
        q.setR2(rs.getInt("R2"));
        q.setR3(rs.getInt("R3"));
        q.setR4(rs.getInt("R4"));
        q.setR5(rs.getInt("R5"));
        q.setR6(rs.getInt("R6"));
        q.setR7(rs.getInt("R7"));
        q.setR8(rs.getInt("R8"));
        return q;
    }

}
