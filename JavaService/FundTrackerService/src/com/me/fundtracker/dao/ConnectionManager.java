package com.me.fundtracker.dao;

import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.log4j.Logger;

import com.me.fundtracker.utils.GlobalConstants;

/**
 * @author Ranjith
 *
 */
public class ConnectionManager 
{
	private static final Logger logger = Logger.getLogger(ConnectionManager.class.getName());
	
	// Private constructor prevents instantiation from other classes
	private ConnectionManager() {
	}

	/**
	 * SingletonHolder is loaded on the first execution of
	 * Singleton.getInstance() or the first access to SingletonHolder.INSTANCE,
	 * not before.
	 */
	private static class SingletonConnectionManager 
	{
		private static final ConnectionManager SINGLETON_INSTANCE = new ConnectionManager();
	}

	/**
	 * Returns always the single instance for ConnectionManager.
	 */
	public static ConnectionManager getInstance() 
	{
		return SingletonConnectionManager.SINGLETON_INSTANCE;
	}
	
	/**
	 * Get the SQL JDBC connection string.
	 * @return
	 */
	public String getSQLConnectionURL() 
	{
		String connection = GlobalConstants.SQL_JDBC_HOST
				+ GlobalConstants.SQL_DATASOURCE;

		return connection;
	}
	
	/**
	 * Get the connection object to perform SQL operations. 
	 * @return
	 */
	public Connection getSQLConnectionObject() 
	{
		String connURL = getSQLConnectionURL();
		Connection connection = null;
		
		try
		{
			Class.forName(GlobalConstants.JDBC_DRIVER);
			connection = DriverManager.getConnection(connURL);			
		}
		catch(Exception ex){
			logger.debug(ex);
		}

		return connection;
	}

}
