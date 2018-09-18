import java.util.List;

import com.me.fundtracker.controller.FundTrackerServiceController;
import com.me.fundtracker.valueobjects.transaction.DailyExpenseVO;



public class TestSQLJDBC {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		FundTrackerServiceController fundController = new FundTrackerServiceController();
		List<DailyExpenseVO> collMembersList = fundController.getAllDailyExpenseDetails("12/11/2012", "12/11/2012");
		
		System.out.println(collMembersList.size());
	}

}
