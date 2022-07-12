package kr.or.ddit.bnb.admin.service;

import java.util.List;

import kr.or.ddit.bnb.admin.vo.QNAVO;
import kr.or.ddit.bnb.admin.vo.QNA_ANSVO;


public interface IQnAansService {


	
//	//회원용 게시판 조회
	public List<QNAVO> MemQuestionList();
	
	//관리자용 게시판 조회
	public List<QNAVO> QuestionList();
	
	//질문 답변
	int insertAnswer(QNA_ANSVO answerVO);
	
	//질문 삭제
	public int deleteQuestion(String qna_id);
	
	//질문 삭제
	public int deleteAns(String qna_id);
	
//	//회원용 게시판 작성
	public int insertQuestion(QNAVO qnaVo);
	
	//게시판 상세보기
	public List<QNA_ANSVO> SeeQuestion(String qna_id);

	

	
		
	



}
