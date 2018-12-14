package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MemberDAOInter {
 
  /**
   * �ߺ� ���̵� �˻�
   * @param id
   * @return �ߺ� ���̵� ����
   */
  public int checkId(String id);
  
  /**
  ȸ�� ���
  @param memberVO
  @return ��ϵ� ȸ���� 1 or 0
  */
  public int create(MemberVO memberVO);
  
  /**
   * ȸ�� ��ü ���
   * @return
   */
  public List<MemberVO> list();
  
  /**
   * ��ȸ
   * @param mno
   * @return
   */
 public MemberVO read(int memberno);
  
  /**
   * ��ȸ
   * @param id
   * @return
   */
 public MemberVO readById(String id);
 
 /**
  * ����
  * @param memberVO
  * @return
  */
 public int update(MemberVO memberVO);
 
 /**
  * �н����� ���� 
  * @param map
  * @return
  */
public int passwd_update(Map<String, Object> map);
 
 /**
  * ���ڵ� 1�� ����
  * @param mno ������ ȸ�� ��ȣ
  * @return ������ ���ڵ� ����
  */
 public int delete(int memberno);
 
 /**
  * �α���
  * @param map
  * @return
  */
 public int login(Map map);
 
 /**
  * �α��� ���� ����
  * @param logVO
  * @return
  */
 public int create_login_list(Map map);
 
 /**
  * �α��� ���� ��ȸ(ȣ��)
  * @return
  */
 public List<LogVO> login_list();
 
}