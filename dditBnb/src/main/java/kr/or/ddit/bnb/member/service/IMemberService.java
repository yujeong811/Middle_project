package kr.or.ddit.bnb.member.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.bnb.member.vo.FavorListVO;
import kr.or.ddit.bnb.member.vo.MemberVO;
import kr.or.ddit.bnb.member.vo.ReserDetailVO;
import kr.or.ddit.bnb.member.vo.ReserListVO;

public interface IMemberService {
	// 회원가입
	public int insertMember(MemberVO memVo);
	
	// 로그인
	public MemberVO getMember(MemberVO memVo);
	
	// 힌트질문 비교
	public MemberVO getMemberHint(String memId);
	
	// id 중복검사
	public int idCheck(String memId);
	
	// 아이디 찾기
	public String findId(MemberVO memVo);
	
	// 비밀번호 찾기
	public MemberVO findPass(MemberVO memVo);
	
	// 비밀번호 재설정
	public int updatePass(MemberVO memVo);
	
	// 마이페이지/회원정보 조회
	public MemberVO getMemberList(String memId);
	
	// 마이페이지/회원정보 수정
	public int updateMember(MemberVO memVo);
	
	// 마이페이지/회원탈퇴
	public int deleteMember(String memId);
	
	// 마이페이지/예약내역목록
	public List<ReserListVO> reserList(String memId);
	
	// 마이페이지/예약내역목록 이미지
//	public List<String> getImg(String prod_id);
	
	// 마이페이지/예약내역상세
	public ReserDetailVO reserDetail(Map<String, Object> resMap);
	
	// 마이페이지/예약내역취소
	public int deleteReser(Map<String, Object> resDMap);
	
    // 마이페이지/찜 목록
	public List<FavorListVO> favorList(String memId);
	
	// 마이페이지/찜 삭제
	public int deleteFavor(Map<String, Object> resfMap);
	
	//전체 회원 목록
	public List<MemberVO> getAllMemberList();
	
	public String getEmail(String mail);

}
