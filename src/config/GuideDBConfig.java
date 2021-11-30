package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GuideDBConfig {

	public static Connection connection() throws ClassNotFoundException, SQLException {
		 
		// For production
		Class.forName("org.mariadb.jdbc.Driver");
		Connection connection = DriverManager.getConnection("jdbc:mariadb://10.63.192.10:3306/skyzerapp?useSSL=false", "root", "pacificingenico");
		
		
		// For test
		//Class.forName("com.mysql.cj.jdbc.Driver");
		//Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/skyzerguide?serverTimezone=UTC&useSSL=false", "root", "root");

		return connection;
		 
	}
}
