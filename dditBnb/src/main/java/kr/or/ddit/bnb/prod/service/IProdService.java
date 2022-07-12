package kr.or.ddit.bnb.prod.service;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.bnb.prod.vo.ProdConvenVO;
import kr.or.ddit.bnb.prod.vo.ProdImgVO;
import kr.or.ddit.bnb.prod.vo.ProdVO;
import kr.or.ddit.bnb.prod.vo.ReviewVO;

public interface IProdService {
	
	
	//상품숙소 등록
	public int insertProd(ProdVO prodVo);
	
	//상품이미지 등록 
	public int insertProdImg(ProdImgVO prodimgVo);
	
	//상품편의시설 등록 
	public int insertProdConven(ProdConvenVO prodconvenVo);
	
	//상품리뷰 등록
	public int insertRev(ReviewVO revVo);
	
	//상품리뷰 수정
	public int updateRev(ReviewVO revVo);
	
	//상품리뷰 삭제
	public int deleteRev(String review_id);
	
	//상품리뷰 조회
	public List<ReviewVO> selectRev(String prod_id);
	
	//숙소등록삭제 상태 변경 n을 y로 변경
	public int updateProd(ProdVO prodVo);
	
	public List<ProdVO> HostProdList(String memId);

}
