package com.me.fundtracker.business.master;

import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.me.fundtracker.dao.master.MembersDAOFactory;
import com.me.fundtracker.valueobjects.master.MembersVO;

public class MembersMediator 
{
	private static final Logger logger = Logger.getLogger(MembersMediator.class.getName());
	private static final String CLASS_NAME  = MembersMediator.class.getName();
	
	public ArrayList<MembersVO> getAllMembersDetail()
	{
		String methodName = CLASS_NAME + " :: getAllMembersDetail() -- ";
		logger.info(methodName + "Entry");
		MembersDAOFactory membersDAO = null;
		ArrayList<MembersVO> collMembersList = new ArrayList<MembersVO>();
		ResultSet resultset = null;
		
		try
		{
			membersDAO = new MembersDAOFactory();
			resultset = membersDAO.getAllMembersDetail();
			collMembersList = getMembersList( resultset );
		}
		catch(Exception ex){
			logger.error("Error while retrieving the members list.", ex);
		}
		
		logger.info(methodName + "Exit");
		return collMembersList;
	}
	
	public ArrayList<MembersVO> insertMemberDetails( ArrayList<MembersVO> collMembers )
	{
		String methodName = CLASS_NAME + " :: insertMemberDetails() -- ";
		logger.info(methodName + "Entry");
		MembersDAOFactory membersDAO = null;
		ArrayList<MembersVO> collMembersList = new ArrayList<MembersVO>();
		ResultSet resultset = null;
		
		try
		{
			membersDAO = new MembersDAOFactory();
			resultset = membersDAO.insertMemberDetails( collMembers );
			collMembersList = getMembersList( resultset );
		}
		catch(Exception ex){
			logger.error("Error while inserting the members collection.", ex);
		}
		
		logger.info(methodName + "Exit");
		return collMembersList;
	}
	
	public ArrayList<MembersVO> updateMemberDetails( MembersVO memberVO )
	{
		String methodName = CLASS_NAME + " :: getAllExpenseCategoryDetail() -- ";
		logger.info(methodName + "Entry");
		MembersDAOFactory membersDAO = null;
		ArrayList<MembersVO> collMembersList = new ArrayList<MembersVO>();
		ResultSet resultset = null;
		
		try
		{
			membersDAO = new MembersDAOFactory();
			resultset = membersDAO.updateMemberDetails( memberVO );
			collMembersList = getMembersList( resultset );
		}
		catch(Exception ex){
			logger.error("Error while updating the members details.", ex);
		}
		
		logger.info(methodName + "Exit");
		return collMembersList;
	}
	
	public ArrayList<MembersVO> deleteMemberDetails( int memberID )
	{
		String methodName = CLASS_NAME + " :: getAllExpenseCategoryDetail() -- ";
		logger.info(methodName + "Entry");
		MembersDAOFactory membersDAO = null;
		ArrayList<MembersVO> collMembersList = new ArrayList<MembersVO>();
		ResultSet resultset = null;
		
		try
		{
			membersDAO = new MembersDAOFactory();
			resultset = membersDAO.deleteMemberDetails( memberID );
			collMembersList = getMembersList( resultset );
		}
		catch(Exception ex){
			logger.error("Error while deleting the members details.", ex);
		}
		
		logger.info(methodName + "Exit");
		return collMembersList;
	}
	
	
	// ------------------------------------------------------------------------------------------------------------------------------------
	//												Private Methods Definitions
	// ------------------------------------------------------------------------------------------------------------------------------------
	private ArrayList<MembersVO> getMembersList( ResultSet resultset )
	{
		String methodName = CLASS_NAME + " :: getMembersList() -- ";
		logger.info(methodName + "Entry");
		ArrayList<MembersVO> collMembersList = new ArrayList<MembersVO>();
		MembersVO memberVO = null;
		
		try
		{
			if( resultset != null )
			{
				while (resultset.next())
				{
					memberVO = new MembersVO();
								
					memberVO.setMemberID(resultset.getInt("member_id"));
					memberVO.setFirstName(resultset.getString("first_name"));
					memberVO.setLastName(resultset.getString("last_name"));
					memberVO.setNickName(resultset.getString("nick_name"));
					memberVO.setAddress(resultset.getString("address"));
					memberVO.setCity(resultset.getString("city"));
					memberVO.setGender(resultset.getString("gender"));
					memberVO.setPincode(resultset.getString("pincode"));
					memberVO.setTelephoneNo(resultset.getString("telephone_no"));
					memberVO.setMobileNo(resultset.getString("mobile_no"));
					memberVO.setActive(resultset.getInt("active"));
					collMembersList.add(memberVO);
				}
			}
		}
		catch(Exception ex){
			logger.error("Error in retrieving members list.", ex);
		}
		
		logger.info(methodName + "Exit");
		return collMembersList;
	}
}
