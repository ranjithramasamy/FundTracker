package com.me.fundtracker.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.me.fundtracker.business.login.LoginImpl;
import com.me.fundtracker.business.master.CategoryMediator;
import com.me.fundtracker.business.master.MembersMediator;
import com.me.fundtracker.business.transaction.ExpenseMediator;
import com.me.fundtracker.valueobjects.login.LoginVO;
import com.me.fundtracker.valueobjects.master.CategoryAndAccountGroupsVO;
import com.me.fundtracker.valueobjects.master.CategoryVO;
import com.me.fundtracker.valueobjects.master.MembersVO;
import com.me.fundtracker.valueobjects.transaction.DailyExpenseVO;
import com.me.fundtracker.valueobjects.transaction.ExpenseFilterVO;
import com.me.fundtracker.valueobjects.transaction.ExpenseTypesVO;

/**
 * @author Ranjith
 *
 */
public class FundTrackerServiceController 
{
	/**
	 * Logger instance
	 */
	private static final Logger logger = Logger.getLogger(FundTrackerServiceController.class.getName());
	/**
	 * Current instance assigned to logger.
	 */
	private static final String CLASS_NAME  = FundTrackerServiceController.class.getName();
	
	// -----------------------------------------------------------------------------------------------------------------------
	//												Login Module Service...
	// -----------------------------------------------------------------------------------------------------------------------
	/**
	 * Validate given username & passowrd.
	 */
	public Boolean validateLogin( LoginVO loginVO )
	{
		String methodName = CLASS_NAME + " :: validateLogin() -- ";
		logger.info(methodName + "Entry");
		Boolean isValidUser = false;
		
		try
		{
			LoginImpl login = new LoginImpl();
			isValidUser = login.validateLogin(loginVO);			
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit - isValidUser: " + isValidUser);
		return isValidUser;
	}
	
	// -----------------------------------------------------------------------------------------------------------------------
	//								Members View Related Service Methods - Master Module...
	// -----------------------------------------------------------------------------------------------------------------------
	/**
	 * Get all member details.
	 */
	public ArrayList<MembersVO> getAllMembersDetail()
	{
		String methodName = CLASS_NAME + " :: getAllMembersDetail() -- ";
		logger.info(methodName + "Entry");
		ArrayList<MembersVO> collMembersList = null;
		
		try
		{
			MembersMediator member = new MembersMediator();
			collMembersList = member.getAllMembersDetail();
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");
		return collMembersList;
	}
	
	/**
	 * Insert member details.
	 */
	public ArrayList<MembersVO> insertMemberDetails(  ArrayList<MembersVO> collMembers )
	{
		String methodName = CLASS_NAME + " :: insertMemberDetails() -- ";
		logger.info(methodName + "Entry");
		ArrayList<MembersVO> collMembersList = null;
		
		try
		{
			MembersMediator member = new MembersMediator();
			collMembersList = member.insertMemberDetails( collMembers );
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");		
		return collMembersList;
	}
	
	/**
	 * Update member details.
	 */
	public ArrayList<MembersVO> updateMemberDetails( MembersVO memberVO )
	{
		String methodName = CLASS_NAME + " :: updateMemberDetails() -- ";
		logger.info(methodName + "Entry");
		ArrayList<MembersVO> collMembersList = null;
		
		try
		{
			MembersMediator member = new MembersMediator();
			collMembersList = member.updateMemberDetails( memberVO );			
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		System.out.println(memberVO.getMemberID() + "    " + memberVO.getFirstName() + "  " + memberVO.getNickName() + "  " + memberVO.getMobileNo());
		logger.info(methodName + "Exit");
		
		return collMembersList; 
	}
	
	/**
	 * Delete member details.
	 */
	public ArrayList<MembersVO> deleteMemberDetails( int memberID )
	{
		String methodName = CLASS_NAME + " :: deleteMemberDetails() -- ";
		logger.info(methodName + "Entry");
		ArrayList<MembersVO> collMembersList = null;
		
		try
		{
			MembersMediator member = new MembersMediator();
			collMembersList = member.deleteMemberDetails( memberID );			
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");		
		return collMembersList; 
	}
	
	// -----------------------------------------------------------------------------------------------------------------------
	//								Expense Category View Related Service Methods - Master Module...
	// -----------------------------------------------------------------------------------------------------------------------
	/**
	 * Get all category list & account group list details.
	 */
	public CategoryAndAccountGroupsVO getAllCategoryAndGroupDetail()
	{
		String methodName = CLASS_NAME + " :: getAllCategoryAndGroupDetail() -- ";
		logger.info(methodName + "Entry");
		CategoryAndAccountGroupsVO categoryAndGroups = null;
		
		try
		{
			CategoryMediator expCategory = new CategoryMediator();
			categoryAndGroups = expCategory.getAllCategoryAndGroupDetail();
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");
		return categoryAndGroups;
	}
	
	/**
	 *Insert Category details.
	 */
	public ArrayList<CategoryVO> insertCategoryDetails( CategoryVO expCategoryVO )
	{
		String methodName = CLASS_NAME + " :: insertCategoryDetails() -- ";
		logger.info(methodName + "Entry");
		ArrayList<CategoryVO> collExpCategoryList = null;
		
		try
		{
			CategoryMediator expCategory = new CategoryMediator();
			collExpCategoryList = expCategory.insertCategoryDetails( expCategoryVO );
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");		
		return collExpCategoryList;
	}
	
	/**
	 * Update Category details.
	 */
	public ArrayList<CategoryVO> updateCategoryDetails( CategoryVO expCategoryVO )
	{
		String methodName = CLASS_NAME + " :: updateCategoryDetails() -- ";
		logger.info(methodName + "Entry");
		ArrayList<CategoryVO> collExpCategoryList = null;
		
		try
		{
			CategoryMediator expCategory = new CategoryMediator();
			collExpCategoryList = expCategory.updateCategoryDetails( expCategoryVO );			
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		System.out.println(expCategoryVO.getCategoryID() + "    " + expCategoryVO.getAccountGroupKey() + "  " + expCategoryVO.getDefaultAccountType());
		logger.info(methodName + "Exit");
		
		return collExpCategoryList; 
	}
	
	/**
	 * Delete Category details.
	 */
	public ArrayList<CategoryVO> deleteCategoryDetail( int categoryID )
	{
		String methodName = CLASS_NAME + " :: deleteCategoryDetail() -- ";
		logger.info(methodName + "Entry");
		ArrayList<CategoryVO> collExpCategoryList = null;
		
		try
		{
			CategoryMediator expCategory = new CategoryMediator();
			collExpCategoryList = expCategory.deleteCategoryDetail( categoryID );			
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");		
		return collExpCategoryList; 
	}
	

	// -----------------------------------------------------------------------------------------------------------------------
	//								Expense Category View Related Service Methods - Master Module...
	// -----------------------------------------------------------------------------------------------------------------------
	/**
	 * Get all category list & account group list details.
	 */
	public List<DailyExpenseVO> getAllDailyExpenseDetails( ExpenseFilterVO expFilterVO )
	{
		String methodName = CLASS_NAME + " :: getDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		List<DailyExpenseVO> collExpenseTypesList = null;
		
		try
		{
			if(expFilterVO == null )
				logger.error(methodName + "Filter is EMPTY / NULL.");
			
			ExpenseMediator expMediator = new ExpenseMediator();
			collExpenseTypesList = expMediator.getAllDailyExpenseDetails( expFilterVO );
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");
		return collExpenseTypesList;
	}
	
	/**
	 * Get all category list & account group list details.
	 */
	public ArrayList<ExpenseTypesVO> getAllExpenseTypesList()
	{
		String methodName = CLASS_NAME + " :: getAllExpenseTypesList() -- ";
		logger.info(methodName + "Entry");
		ArrayList<ExpenseTypesVO> collExpenseTypesList = null;
		
		try
		{
			ExpenseMediator expMediator = new ExpenseMediator();
			collExpenseTypesList = expMediator.getAllExpenseTypesList();
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");
		return collExpenseTypesList;
	}
	
	/**
	 * Insert member details.
	 */
	public List<DailyExpenseVO> insertDailyExpenseDetails( List<DailyExpenseVO> collDailyExpVO, ExpenseFilterVO expFilterVO )
	{
		String methodName = CLASS_NAME + " :: insertDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		List<DailyExpenseVO> collDailyExpList = null;
		
		try
		{
			ExpenseMediator expMediator = new ExpenseMediator();
			collDailyExpList = expMediator.insertDailyExpenseDetails( collDailyExpVO, expFilterVO.getFromDate(), expFilterVO.getToDate() );
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");		
		return collDailyExpList;
	}
	
	/**
	 * Update member details.
	 */
	public List<DailyExpenseVO> updateDailyExpenseDetails( DailyExpenseVO collDailyExpVO, ExpenseFilterVO expFilterVO )
	{
		String methodName = CLASS_NAME + " :: updateDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		List<DailyExpenseVO> collDailyExpList = null;
		
		try
		{
			ExpenseMediator member = new ExpenseMediator();
			collDailyExpList = member.updateDailyExpenseDetails( collDailyExpVO, expFilterVO.getFromDate(), expFilterVO.getToDate() );			
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		System.out.println(collDailyExpVO.getDate() + "  " + collDailyExpVO.getExpCategoryType() + "  " + collDailyExpVO.getAmount());
		logger.info(methodName + "Exit");
		
		return collDailyExpList; 
	}
	
	/**
	 * Delete member details.
	 */
	public List<DailyExpenseVO> deleteDailyExpenseDetail( int expenseID, ExpenseFilterVO expFilterVO )
	{
		String methodName = CLASS_NAME + " :: deleteDailyExpenseDetails() -- ";
		logger.info(methodName + "Entry");
		List<DailyExpenseVO> collDailyExpList = null;
		
		try
		{
			ExpenseMediator expMediator = new ExpenseMediator();
			collDailyExpList = expMediator.deleteDailyExpenseDetails( expenseID, expFilterVO.getFromDate(), expFilterVO.getToDate() );			
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");		
		return collDailyExpList; 
	}
}