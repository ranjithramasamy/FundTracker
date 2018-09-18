package com.me.fundtracker.utils;

public class GlobalConstants {
	// -----------------------------------------------------------------------------------------------------------------------
	//										Constants used by ConnectionManager class
	// -----------------------------------------------------------------------------------------------------------------------
	public static final String JDBC_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	
	public static final String SQL_JDBC_HOST = "jdbc:sqlserver://localhost:1433;";
	
	public static final String SQL_DATASOURCE = "databaseName=FundTracker;user=sa;password=ramasamy9473;";

	// -----------------------------------------------------------------------------------------------------------------------
	//										Constants used by ExpenseDAOFactory class
	// -----------------------------------------------------------------------------------------------------------------------
	public static final String CATEGORY_GROUP_EXPENSE = "EXP";
		
	public static final String CATEGORY_GROUP_DONATION = "DON";
		
	public static final String CATEGORY_GROUP_AUCTION = "AUC";
	
	public static final String DATE_FORMAT = "MM/dd/yyyy";
}
