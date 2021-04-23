package model;

import java.sql.*;

import bean.Project;
import config.DBConfig;

public class ProjectDAO {

	private static Connection cnn;
	private static ResultSet rs;
	
	public ResultSet insert(Project project) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into projects "
            		+ "(name, department, description, created_on, created_by, updated_on, updated_by)"
            		+ " values (?, ?, ?, ?, ?, ? ,?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, project.getName());
            preparedStatement.setInt(2, project.getDepartment().getId());
            preparedStatement.setString(3, project.getDescription());
            preparedStatement.setString(4, project.getCreatedOn());
            preparedStatement.setInt(5, project.getCreatedBy().getId());
            preparedStatement.setString(6, project.getUpdatedOn());
            preparedStatement.setInt(7, project.getUpdatedBy().getId());

            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
	
	public ResultSet update(Project project) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Update projects set"
            		+ " name = ?, department = ?, description = ?, updated_on = ?, updated_by = ?"
            		+ " where id = ?", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, project.getName());
            preparedStatement.setInt(2, project.getDepartment().getId());
            preparedStatement.setString(3, project.getDescription());
            preparedStatement.setString(4, project.getUpdatedOn());
            preparedStatement.setInt(5, project.getUpdatedBy().getId());
            preparedStatement.setInt(6, project.getId());

            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
}
