package dev.mvc.categrp;

import java.util.List;

public interface CategrpProcInter {
  /**
   * ī�װ� �׷� ���
   * <insert id="create" parameterType="CategrpVO"> 
   * @param categrpVO
   * @return ó���� ���ڵ� ����
   */
  public int create(CategrpVO categrpVO);

  /**
   * ���
   * <select id="list" resultType="CategrpVO">
   * @return
   */
  public List<CategrpVO> list();

  /**
   * ��ȸ
   * <select id="read" resultType="CategrpVO" parameterType="int">
   * @param categrpno
   * @return
   */
  public CategrpVO read (int categrpno);
   
  /**
   * ���� ó��
   * <update id="update" parameterType="CategrpVO"> 
   * @param categrpVO
   * @return ó���� ���ڵ� ����
   */
  public int update(CategrpVO categrpVO);

  /**
   * ���� ó��
   * <delete id="delete" parameterType="int">
   * @param categrpno
   * @return ó���� ���ڵ� ����
   */
  public int delete (int categrpno);
  
  public int count_by_categrp(int categrpno);
}








