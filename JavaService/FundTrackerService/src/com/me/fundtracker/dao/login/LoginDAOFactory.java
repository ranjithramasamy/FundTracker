package com.me.fundtracker.dao.login;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;

import org.apache.log4j.Logger;

import com.me.fundtracker.dao.ConnectionManager;
import com.me.fundtracker.utils.GlobeProcedureConstants;
import com.me.fundtracker.valueobjects.login.LoginVO;

public class LoginDAOFactory 
{	
	private ConnectionManager _connManager = ConnectionManager.getInstance();
	
	private static final Logger logger = Logger.getLogger(LoginDAOFactory.class.getName());
	
	/**
	 * Execute SQL stored procedure to validate given username & passowrd.
	 */
	public int validateUser( LoginVO loginVO )
	{
		logger.info("Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		int outParamValue = 0;
			
		try
		{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.VALIDATE_LOGIN_USER_CRDENTIAL);
			
			// Set the value for the IN parameter
			callableStmt.setString(1, loginVO.getUsername());
			callableStmt.setString(2, loginVO.getPassword());
		    
			// Register the type of the OUT parameter
			callableStmt.registerOutParameter(3, Types.VARCHAR);
			
			// Execute the stored procedure and retrieve the OUT value
			callableStmt.execute();
		    
			// Out parameter value returning by SQL.
			outParamValue = Integer.parseInt(callableStmt.getString(3));
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info("Exit");
		return outParamValue;
	}
}
