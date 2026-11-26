package DAO;

import java.sql.*;
import model.QuizBean;
import util.ConectaBD;

public class EditarDAO {

    /** Atualiza nome e respostas da participação identificada pelo id. */
    public boolean Editar(QuizBean q) {
        String sql = "UPDATE participacao SET nome=?,r1=?,r2=?,r3=?,r4=?,r5=?,r6=?,r7=?,r8=? "
                   + "WHERE id=?";
        try (Connection conexao = ConectaBD.conectar();
             PreparedStatement ps = conexao.prepareStatement(sql)) {
            ps.setString(1, q.getNome());
            ps.setInt(2, q.getR1());
            ps.setInt(3, q.getR2());
            ps.setInt(4, q.getR3());
            ps.setInt(5, q.getR4());
            ps.setInt(6, q.getR5());
            ps.setInt(7, q.getR6());
            ps.setInt(8, q.getR7());
            ps.setInt(9, q.getR8());
            ps.setInt(10, q.getId());
            return ps.executeUpdate() > 0;   // false = registro não encontrado
        } catch (Exception e) {
            System.out.println("Erro ao editar: " + e);
            return false;
        }
    }

}
