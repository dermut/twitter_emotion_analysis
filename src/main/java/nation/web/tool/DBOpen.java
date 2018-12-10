package nation.web.tool;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBOpen {
  public Connection getConnection() {
    Connection con = null;              // DBMS 연결 
    
    try {
      String className = "org.gjt.mm.mysql.Driver"; // MySQL 연결 Drvier 
      String url = "jdbc:mysql://localhost:3306/health?useUnicode=true&characterEncoding=euckr"; 
      String user = "root"; 
      String pass = "1234";
      
      Class.forName(className); // memory로 클래스를 읽어옴, 객체는 생성하지 않음.
      con = DriverManager.getConnection(url, user, pass);  // MySQL 연결
      
      
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    return con;
  }
}
