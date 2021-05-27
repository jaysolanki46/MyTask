package model;

import java.sql.*;
import bean.User;
import config.DBConfig;

public class UserDAO {

	private static Connection cnn;
	private static ResultSet rs;
	
	public static ResultSet authenticate(User user) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
			PreparedStatement preparedStatement = cnn
					.prepareStatement("select * from users where name = ? and pass = ?");
			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getPass());

			System.out.println(preparedStatement);
			rs = preparedStatement.executeQuery();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
	
	public boolean update(User user) throws ClassNotFoundException {
		
		try {
        	
			new DBConfig();
			cnn = DBConfig.connection();
			
            PreparedStatement preparedStatement =  cnn.prepareStatement("Update users set "
            		+ "name = ?, pass = ?, theme = ?, email = ? "
            		+ "WHERE id = ?", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getPass());
            preparedStatement.setString(3, user.getTheme());
            preparedStatement.setString(4, user.getEmail());
            preparedStatement.setInt(5, user.getId());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
           	return false;
        }
		return true;
	}
	
	public ResultSet getUserDetails(User user) throws ClassNotFoundException {
		
		try {
			new DBConfig();
			cnn = DBConfig.connection();
        	
			PreparedStatement preparedStatement = cnn
					.prepareStatement("select * from users where id = ?");
			preparedStatement.setInt(1, user.getId());

			System.out.println(preparedStatement);
			rs = preparedStatement.executeQuery();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
}
