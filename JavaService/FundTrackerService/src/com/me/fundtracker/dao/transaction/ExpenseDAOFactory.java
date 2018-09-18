package com.me.fundtracker.dao.transaction;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;

import com.me.fundtracker.dao.ConnectionManager;
import com.me.fundtracker.utils.GlobalConstants;
import com.me.fundtracker.utils.GlobeProcedureConstants;
import com.me.fundtracker.valueobjects.transaction.DailyExpenseVO;
import com.me.fundtracker.valueobjects.transaction.ExpenseFilterVO;

public class ExpenseDAOFactory {
	private static final Logger logger = Logger.getLogger(ExpenseDAOFactory.class.getName());
	private static final String CLASS_NAME  = ExpenseDAOFactory.class.getName();
	private ConnectionManager _connManager = ConnectionManager.getInstance();
	
	public ResultSet getAllExpenseTypesList()
	{
		String methodName = CLASS_NAME + " :: getAllExpenseTypesList() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.GET_CATEGORY_DETAILS_BY_GROUP);
			
			// Set the value for the IN parameter
			callableStmt.setString(1, GlobalConstants.CATEGORY_GROUP_EXPENSE);
			
			result = callableStmt.executeQuery();
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet getAllDailyExpenseDetails( ExpenseFilterVO expFilterVO )
	{
		String methodName = CLASS_NAME + " :: getAllDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.GET_ALL_DAILY_EXPENSE_DETAILS);
			
			// Set the value for the IN parameter
			callableStmt.setString(1, fromDate);
			callableStmt.setString(2, toDate);
			
			result = callableStmt.executeQuery();
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet insertDailyExpenseDetails( List<DailyExpenseVO> collDailyExpList, String fromDate, String toDate )
	{
		String methodName = CLASS_NAME + " :: insertDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			Iterator< DailyExpenseVO> iterator = collDailyExpList.iterator();
			
			while( iterator.hasNext() )
			{
				DailyExpenseVO dailyExpVO = iterator.next();
				callableStmt = conn.prepareCall(GlobeProcedureConstants.INSERT_DAILY_EXPENSE_DETAILS);
				
				// Set the value for the IN parameter
				callableStmt.setString(1, dailyExpVO.getDate());
				callableStmt.setInt(2, dailyExpVO.getExpCategoryID());
				
				callableStmt.setString(3, dailyExpVO.getNarration());
				callableStmt.setString(4, dailyExpVO.getAmount());
				
				// Execute the stored procedure to insert new member details.
				callableStmt.executeUpdate();
			}

			result = getAllDailyExpenseDetails(fromDate, toDate);
		}
		catch(Exception ex){
			logger.error("Error while executing SQL statement.", ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet updateDailyExpenseDetails( DailyExpenseVO dailyExpVO, String fromDate, String toDate )
	{
		String methodName = CLASS_NAME + " :: updateDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.UPDATE_DAILY_EXPENSE_DETAILS);
			
			// Set the value for the IN parameter
			callableStmt.setInt(1, Integer.valueOf(dailyExpVO.getExpId()));
			callableStmt.setString(2, dailyExpVO.getDate());
			callableStmt.setInt(3, dailyExpVO.getExpCategoryID());
			
			callableStmt.setString(4, dailyExpVO.getNarration());
			callableStmt.setString(5, dailyExpVO.getAmount());
			
			// Execute the stored procedure to update existing daily detail.
			callableStmt.executeUpdate();
			result = getAllDailyExpenseDetails(fromDate, toDate);
		}
		catch(Exception ex){
			logger.error("Error while executing SQL statement.", ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet deleteDailyExpenseDetails( int dailyExpID, String fromDate, String toDate )
	{
		String methodName = CLASS_NAME + " :: deleteDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.DELETE_DAILY_EXPENSE_DETAILS);
			
			// Set the value for the IN parameter
			callableStmt.setInt(1, dailyExpID);
			
			// Delete existing expense detail.
			callableStmt.executeUpdate();
			result = getAllDailyExpenseDetails(fromDate, toDate);
		}
		catch(Exception ex){
			logger.error("Error while executing SQL statement.", ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}

}
