package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import bean.TaskDetail;
import config.DBConfig;

public class TaskDetailDAO {

	private static Connection cnn;
	private static ResultSet rs;
	
	@SuppressWarnings("resource")
	public boolean insert(TaskDetail taskDetail) throws ClassNotFoundException, SQLException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
			PreparedStatement preparedStatement =  cnn.prepareStatement("select * from task_details where task = ? and task_detail_date = ? and created_by = ?", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, taskDetail.getTask().getId());
            preparedStatement.setString(2, taskDetail.getTaskDetailDate());
            preparedStatement.setInt(3, taskDetail.getCreatedBy().getId());
            System.out.println(preparedStatement);
            rs = preparedStatement.executeQuery();
            
            if(rs.next()) {
            	preparedStatement =  cnn.prepareStatement("Update task_details set "
                		+ "hours = ?, description = ?, updated_on = ?, updated_by = ? "
            			+ "where id = ?", Statement.RETURN_GENERATED_KEYS);

            	preparedStatement.setString(1, taskDetail.getHours());
            	preparedStatement.setString(2, taskDetail.getDescription());
            	preparedStatement.setString(3, taskDetail.getUpdatedOn());
            	preparedStatement.setInt(4, taskDetail.getUpdatedBy().getId());
            	preparedStatement.setInt(5, rs.getInt("id"));

                System.out.println(preparedStatement);
                preparedStatement.executeUpdate();
                
            } else {
            	
            	preparedStatement =  cnn.prepareStatement("Insert into task_details "
                		+ "(task, task_detail_date, hours, description, created_on, created_by, updated_on, updated_by)"
                		+ " values (?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
                preparedStatement.setInt(1, taskDetail.getTask().getId());
                preparedStatement.setString(2, taskDetail.getTaskDetailDate());
                preparedStatement.setString(3, taskDetail.getHours());
                preparedStatement.setString(4, taskDetail.getDescription());
                preparedStatement.setString(5, taskDetail.getCreatedOn());
                preparedStatement.setInt(6, taskDetail.getCreatedBy().getId());
                preparedStatement.setString(7, taskDetail.getUpdatedOn());
                preparedStatement.setInt(8, taskDetail.getUpdatedBy().getId());

                System.out.println(preparedStatement);
                preparedStatement.executeUpdate();
                rs = preparedStatement.getGeneratedKeys();
            }
            
        } catch (Exception e) {
           	e.printStackTrace();
           	return false;
        } finally {
        	cnn.close();
        }
		return true;
	}
}
