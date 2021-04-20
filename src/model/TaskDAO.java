package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import bean.Task;
import config.DBConfig;

public class TaskDAO {

	private static Connection cnn;
	private static ResultSet rs;
	
	public boolean insert(Task task) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into tasks "
            		+ "(name, project, team_member, description, created_on, created_by, updated_on, updated_by)"
            		+ " values (?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, task.getName());
            preparedStatement.setInt(2, task.getProject().getId());
            preparedStatement.setInt(3, task.getTeam_member().getId());
            preparedStatement.setString(4, task.getDescription());
            preparedStatement.setString(5, task.getCreatedOn());
            preparedStatement.setInt(6, task.getCreatedBy().getId());
            preparedStatement.setString(7, task.getUpdatedOn());
            preparedStatement.setInt(8, task.getUpdatedBy().getId());

            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
           	return false;
        }
		return true;
	}
	
	public boolean isCompleted(Task task) {
		
		try {
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Update tasks set "
            		+ "is_completed = ? , updated_on = ?, updated_by = ?"
            		+ " where id = ?", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setBoolean(1, task.getIsCompleted());
            preparedStatement.setString(2, task.getUpdatedOn());
            preparedStatement.setInt(3, task.getUpdatedBy().getId());
            preparedStatement.setInt(4, task.getId());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (Exception e) {
           	e.printStackTrace();
           	return false;
        }
		return true;
	}
}
