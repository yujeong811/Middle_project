package kr.or.ddit.bnb.reservation.serveice;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.bnb.member.vo.FavorListVO;
import kr.or.ddit.bnb.prod.vo.ConvenVO;
import kr.or.ddit.bnb.prod.vo.ProdVO;
import kr.or.ddit.bnb.reservation.vo.PaymentVO;
import kr.or.ddit.bnb.reservation.vo.ReservationDetailVO;
import kr.or.ddit.bnb.reservation.vo.ReservationVO;
import kr.or.ddit.bnb.reservation.vo.SchedulVO;

public interface IReservationService {
	/**
	 * 
	 * @param addr
	 * @return
	 */
	public List<ProdVO> locationReturn(String addr);
	
	/**
	 * 
	 * @param map
	 * @return
	 */
	public List<ProdVO> searchProd(Map<String, Object> map);
	
	/**
	 * 
	 * @param map
	 * @return
	 */
	public List<ProdVO> filter(Map<String, Object> map);
	
	/**
	 * 
	 * @param prod_id
	 * @return
	 */
	public List<String> getImg(String prod_id);
	
	/**
	 * 
	 * @param smc
	 * @param favorVO
	 * @return
	 * @throws SQLException
	 */
	public int addFavor(FavorListVO favorVO);
	
	/**
	 * 
	 * @param prod_id
	 * @return
	 */
	public double getStar(String prod_id);
	
	public List<ConvenVO> getConven(String prod_id);
	
	
	/**
	 * 
	 * @param scheVo
	 * @return
	 */
	public int insertSchedule(SchedulVO scheVo);
	
	/**
	 * 
	 * @param reserVo
	 * @return
	 */
	public String insertReservation(SchedulVO scheVo, ReservationVO reserVo);
	
	/**
	 * 
	 * @param map
	 * @return
	 */
	public int getSchePrice(Map<String, Object> map);
	
	/**
	 * 
	 * @param payVo
	 * @return
	 */
	public int insertPayment(Map<String, String> paramap);
	
	public ProdVO getProdDetail(String prod_id);
	
	public int checkSchedule(SchedulVO scheVo);
	
	//예약신청한 고객
	public List<SchedulVO>checkReserList(String prodId);
		
	//이미사용중인 고객
	public List<SchedulVO>alreadayUseProd(String prodId);
	
	//찜 목록 삭제
	public int removeFavor(Map<String, String> map);
	
	//예약상세정보 조회
	public ReservationDetailVO getReserDetail(String reser_id);
}
