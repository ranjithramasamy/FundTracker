package com.me.fundtracker.utils.transaction
{
	import com.me.fundtracker.valueobjects.transaction.ExpenseFilterVO;

	public class TransactionUtil
	{
		public function getExpenseFilterVO() : ExpenseFilterVO
		{
			var filterVO : ExpenseFilterVO = new ExpenseFilterVO();
			filterVO.fromDate = _fundTrackerUtil.formatDate(_view.filter_comp.fromDate, TransactionGlobeConstants.DATE_FORMAT);
			filterVO.toDate = _fundTrackerUtil.formatDate(_view.filter_comp.toDate, TransactionGlobeConstants.DATE_FORMAT);
			event.expenseFilterVO = filterVO;
		}
	}
}