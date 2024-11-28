package br.com.conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CriarConexao {
    
    private static final Logger logger = Logger.getLogger(CriarConexao.class.getName());

    public static Connection getConexao() throws SQLException {
        Connection con = null;
        try {
            // Registrar o driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Estabelecer a conexão
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Login", "root", "");
            
            // Logar mensagem de conexão bem-sucedida
            logger.info("Conexão com o banco de dados estabelecida com sucesso.");
            
        } catch (ClassNotFoundException e) {
            // Logar o erro de driver não encontrado
            logger.log(Level.SEVERE, "Driver MySQL não encontrado.", e);
            throw new SQLException("Driver MySQL não encontrado.", e);
        } catch (SQLException e) {
            // Logar o erro de conexão com o banco de dados
            logger.log(Level.SEVERE, "Erro ao conectar com o banco de dados.", e);
            throw e;
        }
        return con;
    }
}
