package kr.or.ddit.bnb.prod.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.bnb.member.vo.FavorListVO;
import kr.or.ddit.bnb.prod.vo.ProdConvenVO;
import kr.or.ddit.bnb.prod.vo.ProdImgVO;
import kr.or.ddit.bnb.prod.vo.ProdVO;
import kr.or.ddit.bnb.prod.vo.ReviewVO;

public class ProdDaoImpl implements IProdDao{
	
	private static ProdDaoImpl dao;
	
	private ProdDaoImpl() {
		
	}
	public static ProdDaoImpl getInstance() {
		if(dao==null)dao=new ProdDaoImpl();
		
		return dao;
	}

	@Override
	public int insertProd(SqlMapClient smc, ProdVO prodVo) throws SQLException {
       int cnt=0;
       
       
		Object obj= smc.insert("prod.insertProd",prodVo);
       if(obj==null) cnt=1;
       
       return cnt;
		 
	}

	@Override
	public int insertProdImg(SqlMapClient smc, ProdImgVO prodimgVo) throws SQLException {
		
	    int cnt=0;
	       
	       
			Object obj= smc.insert("prod.insertProdImg",prodimgVo);
	       if(obj==null) cnt=1;
	       
	       return cnt;
	}
	@Override
	public int insertProdConven(SqlMapClient smc, ProdConvenVO prodconvenVo) throws SQLException {
		
		
		int cnt=0;
	       
	       
		Object obj=smc.insert("prod.insertProdConven",prodconvenVo);
       if(obj==null) cnt=1;
       
       return cnt;
	}
	@Override
	public int insertRev(SqlMapClient smc, ReviewVO revVo) throws SQLException {
		int cnt = 0;
		Object obj = smc.insert("review.insertRev", revVo);
		if(obj!=null) cnt = 1;
			
		return cnt;
	}
	@Override
	public int updateRev(SqlMapClient smc, ReviewVO revVo) throws SQLException {
		int cnt = 0;
		
		cnt = smc.update("review.updateRev", revVo);
		
		return cnt;
	}
	@Override
	public int deleteRev(SqlMapClient smc, String review_id) throws SQLException {
		int cnt = 0;
		
		cnt = smc.delete("review.deleteRev", review_id);
		
		return cnt;
	}
	@Override
	public List<ReviewVO> selectRev(SqlMapClient smc, String prod_id) throws SQLException {
		List<ReviewVO> revList = (List<ReviewVO>) smc.queryForList("review.selectRev", prod_id);
		
		return revList;
	}
	
	@Override
	public int updateProd(SqlMapClient smc, ProdVO prodVo) throws SQLException {
		return smc.update("prod.updateProd",prodVo);
	}
	@Override
	public List<ProdVO> HostProdList(SqlMapClient smc, String memId) throws SQLException {
      List<ProdVO> resHostProd = (List<ProdVO>) smc.queryForList("prod.HostProdList", memId);
		
		return resHostProd ;
	}
	
	

}
