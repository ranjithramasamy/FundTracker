package com.me.fundtracker.business.master;

import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.me.fundtracker.dao.master.CategoryDAOFactory;
import com.me.fundtracker.valueobjects.master.CategoryAndAccountGroupsVO;
import com.me.fundtracker.valueobjects.master.CategoryGroupVO;
import com.me.fundtracker.valueobjects.master.CategoryVO;

public class CategoryMediator 
{
	private static final Logger logger = Logger.getLogger(CategoryMediator.class.getName());
	private static final String CLASS_NAME  = CategoryMediator.class.getName();
	
	public CategoryAndAccountGroupsVO getAllCategoryAndGroupDetail()
	{
		String methodName = CLASS_NAME + " :: getAllCategoryAndGroupDetail() -- ";
		logger.info(methodName + "Entry");
		CategoryDAOFactory expCategoryDAO = null;
		CategoryAndAccountGroupsVO categoryAndGroups = new CategoryAndAccountGroupsVO();
		
		ResultSet resultset = null;
		
		try
		{
			expCategoryDAO = new CategoryDAOFactory();
			resultset = expCategoryDAO.getAllCategoryDetail();
			categoryAndGroups.setCategoryList(getCategoryList( resultset ));
			resultset = expCategoryDAO.getAllAccountGroupDetail();
			categoryAndGroups.setAccountGroups(getAccountGroupList( resultset ));
		}
		catch(Exception ex){
			logger.error("Error while retrieving the expense category list.", ex);
		}
		
		logger.info(methodName + "Exit");
		return categoryAndGroups;
	}
	
	public ArrayList<CategoryVO> insertCategoryDetails( CategoryVO expCategoryVO )
	{
		String methodName = CLASS_NAME + " :: insertCategoryDetails() -- ";
		logger.info(methodName + "Entry");
		CategoryDAOFactory expCategoryDAO = null;
		ArrayList<CategoryVO> collExpCategroyList = new ArrayList<CategoryVO>();
		ResultSet resultset = null;
		
		try
		{
			expCategoryDAO = new CategoryDAOFactory();
			resultset = expCategoryDAO.insertCategoryDetails( expCategoryVO );
			collExpCategroyList = getCategoryList( resultset );
		}
		catch(Exception ex){
			logger.error("Error while inserting the expense category collection.", ex);
		}
		
		logger.info(methodName + "Exit");
		return collExpCategroyList;
	}
	
	public ArrayList<CategoryVO> updateCategoryDetails( CategoryVO expCategoryVO )
	{
		String methodName = CLASS_NAME + " :: updateCategoryDetails() -- ";
		logger.info(methodName + "Entry");
		CategoryDAOFactory expCategoryDAO = null;
		ArrayList<CategoryVO> collExpCategroyList = new ArrayList<CategoryVO>();
		ResultSet resultset = null;
		
		try
		{
			expCategoryDAO = new CategoryDAOFactory();
			resultset = expCategoryDAO.updateCategoryDetails( expCategoryVO );
			collExpCategroyList = getCategoryList( resultset );
		}
		catch(Exception ex){
			logger.error("Error while updating the expense category details.", ex);
		}
		
		logger.info(methodName + "Exit");
		return collExpCategroyList;
	}
	
	public ArrayList<CategoryVO> deleteCategoryDetail( int categoryID )
	{
		String methodName = CLASS_NAME + " :: deleteCategoryDetail() -- ";
		logger.info(methodName + "Entry");
		CategoryDAOFactory expCategoryDAO = null;
		ArrayList<CategoryVO> collExpCategroyList = new ArrayList<CategoryVO>();
		ResultSet resultset = null;
		
		try
		{
			expCategoryDAO = new CategoryDAOFactory();
			resultset = expCategoryDAO.deleteCategoryDetail( categoryID );
			collExpCategroyList = getCategoryList( resultset );
		}
		catch(Exception ex){
			logger.error("Error while deleting the expense category details.", ex);
		}
		
		logger.info(methodName + "Exit");
		return collExpCategroyList;
	}
	
	// ------------------------------------------------------------------------------------------------------------------------------------
	//												Private Methods Definitions
	// ------------------------------------------------------------------------------------------------------------------------------------
	private ArrayList<CategoryVO> getCategoryList( ResultSet resultset )
	{
		String methodName = CLASS_NAME + " :: getCategoryList() -- ";
		logger.info(methodName + "Entry");
		ArrayList<CategoryVO> collCategroyList = new ArrayList<CategoryVO>();
		CategoryVO categoryVO = null;
		
		try
		{
			if( resultset != null )
			{
				while (resultset.next())
				{
					categoryVO = new CategoryVO();
								
					categoryVO.setCategoryID(resultset.getInt("category_id"));
					categoryVO.setAccountGroupKey(resultset.getString("group_key"));
					categoryVO.setAccountGroupName(resultset.getString("group_name"));
					categoryVO.setDescription(resultset.getString("description"));
					categoryVO.setDefaultAccountType(resultset.getString("default_account_type"));
					collCategroyList.add(categoryVO);
				}
			}
		}
		catch(Exception ex){
			logger.error("Error in retrieving category list.", ex);
		}
		
		logger.info(methodName + "Exit");
		return collCategroyList;
	}
	
	private ArrayList<CategoryGroupVO> getAccountGroupList( ResultSet resultset )
	{
		String methodName = CLASS_NAME + " :: getAccountGroupList() -- ";
		logger.info(methodName + "Entry");
		ArrayList<CategoryGroupVO> collGroupList = new ArrayList<CategoryGroupVO>();
		CategoryGroupVO categoryGroupVO = null;
		
		try
		{
			if( resultset != null )
			{
				while (resultset.next())
				{
					categoryGroupVO = new CategoryGroupVO();
								
					categoryGroupVO.setGroupKey(resultset.getString("group_key"));
					categoryGroupVO.setGroupName(resultset.getString("description"));					
					collGroupList.add(categoryGroupVO);
					
					logger.info(methodName + " Group Key:  " + categoryGroupVO.getGroupKey() + "   Group Name:   " + categoryGroupVO.getGroupName());
				}
			}
		}
		catch(Exception ex){
			logger.error("Error in retrieving account group list.", ex);
		}
		
		logger.info(methodName + "Exit");
		return collGroupList;
	}
}
