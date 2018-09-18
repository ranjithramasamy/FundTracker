package com.me.fundtracker.business.login;

import org.apache.log4j.Logger;

import com.me.fundtracker.dao.login.LoginDAOFactory;
import com.me.fundtracker.valueobjects.login.LoginVO;

public class LoginImpl 
{
	private static final Logger logger = Logger.getLogger(LoginImpl.class.getName());
	
	/**
	 * Validate given username & passowrd.
	 */
	public Boolean validateLogin( LoginVO loginVO )
	{
		logger.info("Entry");
		Boolean isValidUser = false;
		LoginDAOFactory loginDAO = null;
		int result;
			
		try
		{
			loginDAO = new LoginDAOFactory();
			result = loginDAO.validateUser(loginVO);
					
			// If the return value from SQL is 1 then set 'true'.
			if (result == 1)
				isValidUser = true;
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info("Exit");
		return isValidUser;
	}
}
