
package br.com.login;
 import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.SQLException;

public class UsuarioDao{
    private Connection con;
    
    public UsuarioDao(Connection con) {
        this.con = con;
    }
    public void adicionar (Usuario u) throws SQLException {
        String sql = "insert into tb_login (nome, email, senha, is_admin) values (?,?,?,?)";
try {
    PreparedStatement stmt = con.prepareStatement(sql);
    stmt.setString(1, u.getNome()); 
    stmt.setString(2, u.getEmail()); 
    stmt.setString(3, u.getSenha());
     stmt.setBoolean(4, u.getIsAdmin());
    
    stmt.execute(); 
    stmt.close();
   } catch (SQLException e) {
    e.printStackTrace();
    } finally {
    con.close();
}
}
    
} 

   