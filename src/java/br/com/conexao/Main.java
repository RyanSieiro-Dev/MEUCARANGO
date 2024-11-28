package br.com.conexao;

import java.sql.Connection;
import java.sql.SQLException;

public class Main {
    
    public static void main(String[] args) {
        Connection con = null;
        try {
            con = CriarConexao.getConexao();
            System.out.println("Conexão com o banco de dados estabelecida com sucesso.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Erro ao estabelecer a conexão com o banco de dados: " + e.getMessage());
        } finally {
           
            if (con != null) {
                try {
                    con.close();
                    System.out.println("Conexão com o banco de dados fechada.");
                } catch (SQLException e) {
                    e.printStackTrace();
                    System.err.println("Erro ao fechar a conexão com o banco de dados: " + e.getMessage());
                }
            }
        }
    }
}
