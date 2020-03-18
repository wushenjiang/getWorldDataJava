
package service;

import java.sql.SQLException;
import java.util.List;

import dao.DataDao;
import domain.WorldData;

/** 
* @author: connor
* @version：2020年3月17日 下午4:25:59 
* 
*/
public class DataService {

	public List<WorldData> getWorldData() throws SQLException {
		DataDao dao = new DataDao();
		return dao.getWorldData();
	}

	public List<WorldData> searchByCondition(String condition, String content) throws SQLException {
		List<WorldData> list = null;
		DataDao dao = new DataDao();
		if(condition.equals("时间")) {
			list =dao.searchByTime(content);
		}
		if(condition.equals("国家")) {
			list = dao.searchByCountry(content);
		}
		return list;
	}

	public List<WorldData> searchByConditionJson(String condition, String content) throws SQLException {
		List<WorldData> list = null;
		DataDao dao = new DataDao();
		if(condition.equals("时间")) {
			list =dao.searchByTimeJson(content);
		}
		if(condition.equals("国家")) {
			list = dao.searchByCountry(content);
		}
		return list;
	}

}
 