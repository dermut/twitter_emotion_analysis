package dev.mvc.contents;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface ContentsProcInter {

  /**
   * 컨텐츠 등록
   * @param contentsVO
   * @return
   */
  public int create(ContentsVO contentsVO);
  
  /**
   * 전체 목록
   * @return
   */
  public List<ContentsVO> list_all_board();
  
  /**
   * 전체 글수
   * @return
   */
  public int total_count();
  
  /**
   * 카테고리별 목록
   * @param boardno
   * @return
   */
  public List<ContentsVO> list_by_board(int boardno);

  /**
   * 조회
   * @param contentsno
   * @return
   */
  public ContentsVO read(int contentsno);

  /**
   * 파일 목록 추출
   * @param contentsVO
   * @return
   */
  public ArrayList<FileVO> getThumbs(ContentsVO contentsVO);
  
  /**
   * 수정처리
   * @param vo
   * @return
   */
  public int update(ContentsVO contentsVO);
   
  /**
   * 삭제
   * @param contentsno
   * @return
   */
  public int delete(int contentsno);
  
  /**
   * 검색 목록
   * @param boardno
   * @return
   */
  public List<ContentsVO> list_by_board_search(HashMap hashMap);

  /**
   * board별 검색된 레코드 갯수
   * @return
   */
  public int search_count(HashMap hashMap);
  
  /**
   * 검색 목록 + 페이징
   * @param hashMap
   * @return
   */
  public List<ContentsVO> list_by_board_search_paging(HashMap<String, Object> hashMap);

  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param boardno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging(int boardno, int search_count, int nowPage, String word);
  
  public int reply_create(ReplyVO replyVO);
  
  public List<ReplyVO> reply_list();
  
  public List<ReplyVO> reply_by_contents(int contentsno);
  
  public ReplyVO reply_read(int replyno);
  
  public int reply_update(ReplyVO replyVO);
  
  public int reply_delete(int replyno);
  
  public int count_reply_by_contents(int contentsno);
}







