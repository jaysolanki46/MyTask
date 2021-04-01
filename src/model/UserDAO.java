package model;

import java.sql.*;
import bean.User;
import config.DBConfig;

public class UserDAO {

	private Connection cnn;
	private ResultSet rs;
	
	public ResultSet authenticate(User user) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
			PreparedStatement preparedStatement = cnn
					.prepareStatement("select * from users where name = ? and pass = ?");
			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getPass());
			preparedStatement.setBoolean(3, true);

			System.out.println(preparedStatement);
			rs = preparedStatement.executeQuery();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
}
