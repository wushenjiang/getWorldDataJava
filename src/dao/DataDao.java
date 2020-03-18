
package dao;

import java.sql.SQLClientInfoException;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.sun.xml.internal.messaging.saaj.packaging.mime.util.QEncoderStream;

import domain.WorldData;
import utils.DataSourceUtils;

/** 
* @author: connor
* @version：2020年3月17日 下午4:26:44 
* 
*/
public class DataDao {

	public List<WorldData> getWorldData() throws SQLException {
		QueryRunner queryRunner  = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from worlddata";
		return queryRunner.query(sql, new BeanListHandler<WorldData>(WorldData.class));
	}

	public List<WorldData> searchByTime(String content) throws SQLException {
		QueryRunner queryRunner  = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from worlddata where lastUpdateTime like ?";
		return queryRunner.query(sql, new BeanListHandler<WorldData>(WorldData.class),"%"+content+"%");
	}

	public List<WorldData> searchByCountry(String content) throws SQLException {
		QueryRunner queryRunner  = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from worlddata where countryname = ?";
		return queryRunner.query(sql, new BeanListHandler<WorldData>(WorldData.class),content);
	}

	public List<WorldData> searchByTimeJson(String content) throws SQLException {
		QueryRunner queryRunner  = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from worlddata where countryname = '0' and lastUpdateTime like ? ";
		return queryRunner.query(sql, new BeanListHandler<WorldData>(WorldData.class),"%"+content+"%");
	}
	
}
 