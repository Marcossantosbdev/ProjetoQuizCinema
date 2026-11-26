package util;

import java.sql.*;

/**
 * Classe de conexão com o banco de dados (mesmo papel da ConectaBD do projeto do professor).
 * Banco: quizbd (script em /banco/quizbd.sql)
 */
public class ConectaBD {

    private static final String URL = "jdbc:mysql://localhost:3306/quizbd"
            + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
            + "&useUnicode=true&characterEncoding=UTF-8";
    private static final String USUARIO = "root";
    private static final String SENHA = "";

    public static Connection conectar() throws ClassNotFoundException, SQLException {
        // driver novo do conector 8.x (com.mysql.jdbc.Driver está obsoleto)
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USUARIO, SENHA);
    }

}
