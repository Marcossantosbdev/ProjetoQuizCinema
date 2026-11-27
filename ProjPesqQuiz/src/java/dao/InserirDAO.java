package DAO;

import java.sql.*;
import model.QuizBean;
import util.ConectaBD;

public class InserirDAO {

    public boolean Inserir(QuizBean q) {
        String sql = "INSERT INTO participacao (nome,r1,r2,r3,r4,r5,r6,r7,r8) "
                   + "VALUES (?,?,?,?,?,?,?,?,?)";
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
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("Erro ao inserir: " + e);
            return false;
        }
    }

}
