package com.me.fundtracker.dao.master;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.log4j.Logger;

import com.me.fundtracker.dao.ConnectionManager;
import com.me.fundtracker.utils.GlobeProcedureConstants;
import com.me.fundtracker.valueobjects.master.MembersVO;

public class MembersDAOFactory 
{
	private static final Logger logger = Logger.getLogger(MembersDAOFactory.class.getName());
	private static final String CLASS_NAME  = MembersDAOFactory.class.getName();
	private ConnectionManager _connManager = ConnectionManager.getInstance();
	
	public ResultSet getAllMembersDetail()
	{
		String methodName = CLASS_NAME + " :: getAllMembersDetail() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.GET_ALL_MEMBERS_DETAIL);
			
			result = callableStmt.executeQuery();
		}
		catch(Exception ex){
			logger.debug(ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet insertMemberDetails( ArrayList<MembersVO> collMembers )
	{
		String methodName = CLASS_NAME + " :: insertMemberDetails() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			Iterator< MembersVO> iterator = collMembers.iterator();
			
			while( iterator.hasNext() )
			{
				MembersVO memberVO = iterator.next();
				callableStmt = conn.prepareCall(GlobeProcedureConstants.INSERT_MEMBER_DETAILS);
				
				// Set the value for the IN parameter
				callableStmt.setString(1, memberVO.getFirstName());
				callableStmt.setString(2, memberVO.getLastName());
				
				callableStmt.setString(3, memberVO.getNickName());
				callableStmt.setString(4, memberVO.getGender());
				callableStmt.setString(5, memberVO.getAddress());
				callableStmt.setString(6, memberVO.getCity());
				callableStmt.setString(7, memberVO.getPincode());
				callableStmt.setString(8, memberVO.getTelephoneNo());
				callableStmt.setString(9, memberVO.getMobileNo());
				callableStmt.setInt(10, memberVO.getActive());
				
				// Execute the stored procedure to insert new member details.
				callableStmt.executeUpdate();
			}

			result = getAllMembersDetail();
		}
		catch(Exception ex){
			logger.error("Error while executing SQL statement.", ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet updateMemberDetails( MembersVO memberVO )
	{
		String methodName = CLASS_NAME + " :: updateMemberDetails() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.UPDATE_MEMBER_DETAILS);
			
			// Set the value for the IN parameter
			callableStmt.setInt(1, memberVO.getMemberID());
			callableStmt.setString(2, memberVO.getFirstName());
			callableStmt.setString(3, memberVO.getLastName());
			
			callableStmt.setString(4, memberVO.getNickName());
			callableStmt.setString(5, memberVO.getGender());
			callableStmt.setString(6, memberVO.getAddress());
			callableStmt.setString(7, memberVO.getCity());
			callableStmt.setString(8, memberVO.getPincode());
			callableStmt.setString(9, memberVO.getTelephoneNo());
			callableStmt.setString(10, memberVO.getMobileNo());
			callableStmt.setInt(11, memberVO.getActive());
			
			// Execute the stored procedure to update existing member details.
			callableStmt.executeUpdate();
			result = getAllMembersDetail();
		}
		catch(Exception ex){
			logger.error("Error while executing SQL statement.", ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}
	
	public ResultSet deleteMemberDetails( int memberID )
	{
		String methodName = CLASS_NAME + " :: deleteMemberDetails() -- ";
		logger.info(methodName + "Entry");
		Connection conn = null;
		CallableStatement callableStmt = null;
		ResultSet result = null;
			
		try{
			conn = _connManager.getSQLConnectionObject();
			callableStmt = conn.prepareCall(GlobeProcedureConstants.DELETE_MEMBER_DETAILS);
			
			// Set the value for the IN parameter
			callableStmt.setInt(1, memberID);
			
			// Execute the stored procedure to update existing member details.
			callableStmt.executeUpdate();
			result = getAllMembersDetail();
		}
		catch(Exception ex){
			logger.error("Error while executing SQL statement.", ex);
		}
		
		logger.info(methodName + "Exit");
		return result;
	}

}
