package com.me.fundtracker.business.transaction;

import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.me.fundtracker.dao.transaction.ExpenseDAOFactory;
import com.me.fundtracker.utils.GlobalConstants;
import com.me.fundtracker.valueobjects.transaction.DailyExpenseVO;
import com.me.fundtracker.valueobjects.transaction.ExpenseFilterVO;
import com.me.fundtracker.valueobjects.transaction.ExpenseTypesVO;

public class ExpenseMediator {
	//Logger instance
	private static final Logger logger = Logger.getLogger(ExpenseMediator.class.getName());
	// Class name
	private static final String CLASS_NAME  = ExpenseMediator.class.getName();
	// Expense DAO Factory instance
	private ExpenseDAOFactory _expenseDAO  = new ExpenseDAOFactory();
	
	public ArrayList<ExpenseTypesVO> getAllExpenseTypesList()
	{
		String methodName = CLASS_NAME + " :: getAllExpenseTypesList() -- ";
		logger.info(methodName + "Entry");
		ArrayList<ExpenseTypesVO> expenseTypesList = null;
		
		ResultSet resultset = null;
		
		try
		{
			resultset = _expenseDAO.getAllExpenseTypesList();
			expenseTypesList = buildExpenseTypesList(resultset);
		}
		catch(Exception ex){
			logger.error("Error while retrieving the expense types list.", ex);
		}
		
		logger.info(methodName + "Exit");
		return expenseTypesList;
	}
	
	public List<DailyExpenseVO> getAllDailyExpenseDetails( ExpenseFilterVO expFilterVO )
	{
		String methodName = CLASS_NAME + " :: getDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		List<DailyExpenseVO> dailyExpenseList = null;
		
		ResultSet resultset = null;
		
		try
		{
			resultset = _expenseDAO.getAllDailyExpenseDetails( expFilterVO );
			dailyExpenseList = buildDailyExpenseList(resultset);
		}
		catch(Exception ex){
			logger.error("Error while retrieving the daily expense list.", ex);
		}
		
		logger.info(methodName + "Exit");
		return dailyExpenseList;
	}
	
	public List<DailyExpenseVO> insertDailyExpenseDetails( List<DailyExpenseVO> collDailyExpVO, String fromDate, String toDate )
	{
		String methodName = CLASS_NAME + " :: insertDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		List<DailyExpenseVO> collDailyExpList = new ArrayList<DailyExpenseVO>();
		ResultSet resultset = null;
		
		try
		{
			resultset = _expenseDAO.insertDailyExpenseDetails( collDailyExpVO, fromDate, toDate );
			collDailyExpList = buildDailyExpenseList( resultset );
		}
		catch(Exception ex){
			logger.error(methodName + "Error while inserting the daily expense collection -- ", ex);
		}
		
		logger.info(methodName + "Exit");
		return collDailyExpList;
	}
	
	public List<DailyExpenseVO> updateDailyExpenseDetails( DailyExpenseVO collDailyExpVO, String fromDate, String toDate )
	{
		String methodName = CLASS_NAME + " :: updateDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		List<DailyExpenseVO> collDailyExpList = new ArrayList<DailyExpenseVO>();
		ResultSet resultset = null;
		
		try
		{
			resultset = _expenseDAO.updateDailyExpenseDetails( collDailyExpVO, fromDate, toDate );
			collDailyExpList = buildDailyExpenseList( resultset );
		}
		catch(Exception ex){
			logger.error(methodName + "Error while updating the daile expense details -- ", ex);
		}
		
		logger.info(methodName + "Exit");
		return collDailyExpList;
	}
	
	public List<DailyExpenseVO> deleteDailyExpenseDetails( int dailyExpID, String fromDate, String toDate )
	{
		String methodName = CLASS_NAME + " :: deleteDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		List<DailyExpenseVO> collDailyExpList = new ArrayList<DailyExpenseVO>();
		ResultSet resultset = null;
		
		try
		{
			resultset = _expenseDAO.deleteDailyExpenseDetails( dailyExpID, fromDate, toDate );
			collDailyExpList = buildDailyExpenseList( resultset );
		}
		catch(Exception ex){
			logger.error(methodName + "Error while deleting the daily expense details -- ", ex);
		}
		
		logger.info(methodName + "Exit");
		return collDailyExpList;
	}
	
	// ------------------------------------------------------------------------------------------------------------------------------------
	//												Private Methods Definitions
	// ------------------------------------------------------------------------------------------------------------------------------------
	private List<DailyExpenseVO> buildDailyExpenseList( ResultSet resultset )
	{
		String methodName = CLASS_NAME + " :: buildDailyExpenseList() -- ";
		logger.info(methodName + "Entry");
		List<DailyExpenseVO> collDailyExpenseList = new ArrayList<DailyExpenseVO>();
		DailyExpenseVO dailyExpenseVO = null;
		DateFormat df = new SimpleDateFormat(GlobalConstants.DATE_FORMAT);
		
		try
		{
			if( resultset != null )
			{
				while (resultset.next())
				{
					dailyExpenseVO = new DailyExpenseVO();
					
					dailyExpenseVO.setExpId(resultset.getString("id"));
					dailyExpenseVO.setDate(df.format(resultset.getDate("expense_date")));
					dailyExpenseVO.setExpCategoryID(resultset.getInt("CategoryID"));
					dailyExpenseVO.setExpCategoryType(resultset.getString("description"));
					dailyExpenseVO.setNarration(resultset.getString("narration"));
					dailyExpenseVO.setAmount(resultset.getString("amount"));
					collDailyExpenseList.add(dailyExpenseVO);
				}
			}
		}
		catch(Exception ex){
			logger.error(methodName + "Error in building daily expense list -- ", ex);
		}
		
		logger.info(methodName + "Exit");
		return collDailyExpenseList;
	}
	
	private ArrayList<ExpenseTypesVO> buildExpenseTypesList( ResultSet resultset )
	{
		String methodName = CLASS_NAME + " :: buildExpenseTypesList() -- ";
		logger.info(methodName + "Entry");
		ArrayList<ExpenseTypesVO> collExpenseTypesList = new ArrayList<ExpenseTypesVO>();
		ExpenseTypesVO expenseTypeVO = null;
		
		try
		{
			if( resultset != null )
			{
				while (resultset.next())
				{
					expenseTypeVO = new ExpenseTypesVO();
					
					expenseTypeVO.setExpCategoryID(resultset.getInt("category_id"));
					expenseTypeVO.setExpCategoryType(resultset.getString("description"));
					expenseTypeVO.setDefaultAccountType(resultset.getString("default_account_type"));
					collExpenseTypesList.add(expenseTypeVO);
				}
			}
		}
		catch(Exception ex){
			logger.error(methodName + "Error in building expense types list -- ", ex);
		}
		
		logger.info(methodName + "Exit");
		return collExpenseTypesList;
	}
}
