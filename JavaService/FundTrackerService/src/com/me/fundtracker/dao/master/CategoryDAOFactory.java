package com.me.fundtracker.dao.master;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import org.apache.log4j.Logger;

import com.me.fundtracker.dao.ConnectionManager;
import com.me.fundtracker.utils.GlobeProcedureConstants;
import com.me.fundtracker.valueobjects.master.CategoryVO;

public class CategoryDAOFactory 
{
	private static final Logger logger = Logger.getLogger(CategoryDAOFactory.class.getName());
	private static final String CLASS_NAME  = CategoryDAOFactory.class.getName();
	private ConnectionManager _connManager = ConnectionManager.getInstance();
	
	public ResultSet getAllCategoryDetail()
	{
		String methodName = CLASS_NAME + " :: getAllCategoryDetail() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.GET_ALL_CATEGORY_DETAIL);
			
			result = callableStmt.executeQuery();
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet getAllAccountGroupDetail()
	{
		String methodName = CLASS_NAME + " :: getAllAccountGroupDetail() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.GET_ALL_ACCOUNT_GROUP_DETAIL);
			
			result = callableStmt.executeQuery();
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet insertCategoryDetails( CategoryVO expCategoryVO )
	{
		String methodName = CLASS_NAME + " :: insertCategoryDetails() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.INSERT_CATEGORY_DETAILS);
			
			// Set the value for the IN parameter
			callableStmt.setString(1, expCategoryVO.getAccountGroupKey());
			callableStmt.setString(2, expCategoryVO.getDescription());
			callableStmt.setString(3, expCategoryVO.getDefaultAccountType());
			
			// Execute the stored procedure to insert new expense details.
			callableStmt.executeUpdate();
			
			//Get updated expense category lists.
			result = getAllCategoryDetail();
		}
		catch(Exception ex){
			logger.error("Error while executing SQL statement.", ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet updateCategoryDetails( CategoryVO expCategoryVO )
	{
		String methodName = CLASS_NAME + " :: updateCategoryDetails() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.UPDATE_CATEGORY_DETAILS);
			
			// Set the value for the IN parameter
			callableStmt.setInt(1, expCategoryVO.getCategoryID());
			callableStmt.setString(2, expCategoryVO.getAccountGroupKey());
			callableStmt.setString(3, expCategoryVO.getDescription());
			callableStmt.setString(4, expCategoryVO.getDefaultAccountType());
			
			// Execute the stored procedure to update existing member details.
			callableStmt.executeUpdate();
			result = getAllCategoryDetail();
		}
		catch(Exception ex){
			logger.error("Error while executing SQL statement.", ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet deleteCategoryDetail( int categoryID )
	{
		String methodName = CLASS_NAME + " :: deleteCategoryDetail() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.DELETE_CATEGORY_DETAILS);
			
			// Set the value for the IN parameter
			callableStmt.setInt(1, categoryID);
			
			// Execute the stored procedure to update existing member details.
			callableStmt.executeUpdate();
			result = getAllCategoryDetail();
		}
		catch(Exception ex){
			logger.error("Error while executing SQL statement.", ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}

}
