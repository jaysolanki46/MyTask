package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.ReferenceGuideFunctions;
import bean.Task;
import config.DBConfig;
import config.GuideDBConfig;

public class ReferenceGuideFunctionDAO {

	private static Connection cnn;
	private static ResultSet rs;
	
	public boolean insert(ReferenceGuideFunctions referenceGuideFunctions) throws ClassNotFoundException, SQLException {
		
		try {
			
			cnn = GuideDBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into reference_guide_functions "
            		+ "(name, short_solution, is_telium, is_tetra, is_function, is_menu, created_by, created_on)"
            		+ " values (?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, referenceGuideFunctions.getName());
            preparedStatement.setString(2, referenceGuideFunctions.getShort_solution());
            preparedStatement.setBoolean(3, referenceGuideFunctions.getIs_telium());
            preparedStatement.setBoolean(4, referenceGuideFunctions.getIs_tetra());
            preparedStatement.setBoolean(5, referenceGuideFunctions.getIs_function());
            preparedStatement.setBoolean(6, referenceGuideFunctions.getIs_menu());
            preparedStatement.setInt(7, referenceGuideFunctions.getCreatedBy().getId());
            preparedStatement.setString(8, referenceGuideFunctions.getCreatedOn());

            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
           	return false;
        } finally {
			cnn.close();
		}
		return true;
	}
	
	public boolean update(ReferenceGuideFunctions referenceGuideFunctions) throws ClassNotFoundException, SQLException {
		
		try {
			
			cnn = GuideDBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Update reference_guide_functions set "
            		+ "name = ? , short_solution = ?, is_telium = ?, is_tetra = ?, is_function = ?, is_menu = ?, updated_by = ?, updated_on = ?"
            		+ " where id = ?", Statement.RETURN_GENERATED_KEYS);
            
            preparedStatement.setString(1, referenceGuideFunctions.getName());
            preparedStatement.setString(2, referenceGuideFunctions.getShort_solution());
            preparedStatement.setBoolean(3, referenceGuideFunctions.getIs_telium());
            preparedStatement.setBoolean(4, referenceGuideFunctions.getIs_tetra());
            preparedStatement.setBoolean(5, referenceGuideFunctions.getIs_function());
            preparedStatement.setBoolean(6, referenceGuideFunctions.getIs_menu());
            preparedStatement.setInt(7, referenceGuideFunctions.getUpdatedBy().getId());
            preparedStatement.setString(8, referenceGuideFunctions.getUpdatedOn());
            preparedStatement.setInt(9, referenceGuideFunctions.getId());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
           	return false;
        } finally {
			cnn.close();
		}
		return true;
	}
	
}
