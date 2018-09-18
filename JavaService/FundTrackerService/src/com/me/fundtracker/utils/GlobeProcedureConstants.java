package com.me.fundtracker.utils;

public class GlobeProcedureConstants {
	// -----------------------------------------------------------------------------------------------------------------------
	//												Login Module Service...
	// -----------------------------------------------------------------------------------------------------------------------
	public static final String VALIDATE_LOGIN_USER_CRDENTIAL = "{call FT_CheckAuthorisedUser(?,?,?)}";
	
	// -----------------------------------------------------------------------------------------------------------------------
	//										Members View Service - Master Module
	// -----------------------------------------------------------------------------------------------------------------------
	// To get the all members list.
	public static final String GET_ALL_MEMBERS_DETAIL = "{call FT_GetAllMembersDetail()}";
	// To insert the new members details.
	public static final String INSERT_MEMBER_DETAILS = "{call FT_InsertMemberDetails(?, ?, ?, ?, ?, ?, ?, ?, ?, ? )}";
	// TO update the existing member details
	public static final String UPDATE_MEMBER_DETAILS = "{call FT_UpdateMemberDetails(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
	// TO delete member details
	public static final String DELETE_MEMBER_DETAILS = "{call FT_DeleteMemberDetails(?)}";
	
	// -----------------------------------------------------------------------------------------------------------------------
	//									Expense Category View Service - Master Module
	// -----------------------------------------------------------------------------------------------------------------------
	// To get the all category list.
	public static final String GET_ALL_CATEGORY_DETAIL = "{call FT_GetAllCategoryDetail()}";
	// To get the all account group list.
	public static final String GET_ALL_ACCOUNT_GROUP_DETAIL = "{call FT_GetAllGroupDetail()}";
	// To insert the new category details.
	public static final String INSERT_CATEGORY_DETAILS = "{call FT_InsertCategoryDetails(?, ?, ?)}";
	// TO update the existing category details
	public static final String UPDATE_CATEGORY_DETAILS = "{call FT_UpdateCategoryDetails(?, ?, ?, ?)}";
	// TO delete category details by given category ID.
	public static final String DELETE_CATEGORY_DETAILS = "{call FT_DeleteCategoryDetail(?)}";
	
	// -----------------------------------------------------------------------------------------------------------------------
	//									Expense View Service - Transactions Module
	// -----------------------------------------------------------------------------------------------------------------------
	// To get the all daily expense details.
	public static final String GET_ALL_DAILY_EXPENSE_DETAILS = "{call FT_GetAllDailyExpenseDetails(?, ?)}";
	// To get the all category details by Group Key.
	public static final String GET_CATEGORY_DETAILS_BY_GROUP = "{call FT_GetCategoryDetailsByGroup(?)}";
	// To insert the new expense details.
	public static final String INSERT_DAILY_EXPENSE_DETAILS = "{call FT_InsertDailyExpenseDetails(?, ?, ?, ?)}";
	// TO update the existing expense details
	public static final String UPDATE_DAILY_EXPENSE_DETAILS = "{call FT_UpdateDailyExpenseDetail(?, ?, ?, ?, ?)}";
	// TO delete expense details by given expense ID.
	public static final String DELETE_DAILY_EXPENSE_DETAILS = "{call FT_DeleteDailyExpenseDetail(?)}";
}
