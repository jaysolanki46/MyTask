package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import bean.ProjectTeam;
import config.DBConfig;

public class ProjectTeamDAO {

	private static Connection cnn;
	private static ResultSet rs;
	
	public boolean insert(ProjectTeam projectTeam) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into project_team "
            		+ "(project, team_member)"
            		+ " values (?, ?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, projectTeam.getProject().getId());
            preparedStatement.setInt(2, projectTeam.getTeamMember().getId());

            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
           	return false;
        }
		return true;
	}
}
