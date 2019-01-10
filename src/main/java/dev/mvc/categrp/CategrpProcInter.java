package dev.mvc.categrp;

import java.util.List;

public interface CategrpProcInter {
  /**
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="CategrpVO"> 
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int create(CategrpVO categrpVO);

  /**
   * 목록
   * <select id="list" resultType="CategrpVO">
   * @return
   */
  public List<CategrpVO> list();

  /**
   * 조회
   * <select id="read" resultType="CategrpVO" parameterType="int">
   * @param categrpno
   * @return
   */
  public CategrpVO read (int categrpno);
   
  /**
   * 수정 처리
   * <update id="update" parameterType="CategrpVO"> 
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int update(CategrpVO categrpVO);

  /**
   * 삭제 처리
   * <delete id="delete" parameterType="int">
   * @param categrpno
   * @return 처리된 레코드 갯수
   */
  public int delete (int categrpno);
  
  public int count_by_categrp(int categrpno);
}








