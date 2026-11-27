package DAO;

import java.sql.*;
import util.ConectaBD;

public class ExcluirDAO {

    public boolean Excluir(int id) {
        String sql = "DELETE FROM participacao WHERE id=?";
        try (Connection conexao = ConectaBD.conectar();
             PreparedStatement ps = conexao.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;   // false = registro não existe
        } catch (Exception e) {
            System.out.println("Erro ao excluir: " + e);
            return false;
        }
    }

}
