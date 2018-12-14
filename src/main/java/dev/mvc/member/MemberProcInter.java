package dev.mvc.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface MemberProcInter {
 
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
   * �α��ε� ȸ�� �������� �˻��մϴ�.
   * @param request
   * @return true: ������
   */
  public boolean isMember(HttpSession session);
  
  /**
   * �α��ε� ȸ�� �������� �˻��մϴ�.
   * @param request
   * @return true: ������
   */
  public boolean isMaster(HttpSession session);
  
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
  * 
  * @param mno ȸ�� ��ȣ
  * @param passwd ������ �н����� ��
  * @return
  */
 public int passwd_update(int memberno, String passwd);
 
 /**
  * ���ڵ� 1�� ����
  * @param mno ������ ȸ�� ��ȣ
  * @return ������ ���ڵ� ����
  */
 public int delete(int memberno);
 
 /**
  * �α���
  * @param id
  * @param passwd
  * @return
  */
 public int login(String id, String passwd);
 
 /**
  * �α��� ���� ����
  * @param logVO
  * @return
  */
 public int create_login_list(String ip, String sf, int memberno);
 
 /**
  * �α��� ���� ��ȸ(ȣ��)
  * @return
  */
 public List<LogVO> login_list();
}