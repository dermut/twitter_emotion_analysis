package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
 
@Repository("dev.mvc.member.MemberDAO") // DBMS 저장소 접근
public class MemberDAO implements MemberDAOInter {
  
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
 
  public MemberDAO() {
    System.out.println("--> MemberDAO created.");
  }

  @Override
  public int checkId(String id) {
    int cnt = sqlSessionTemplate.selectOne("member.checkId", id);
    return cnt;
  }

  @Override
  public int create(MemberVO memberVO) {
    int cnt = sqlSessionTemplate.insert("member.create", memberVO);
    return cnt;
  }

  @Override
  public List<MemberVO> list() {
    List<MemberVO> list = sqlSessionTemplate.selectList("member.list");
    
    return list;
  }

  @Override
  public MemberVO read(int memberno) {
    MemberVO memberVO = sqlSessionTemplate.selectOne("member.read", memberno);
    return memberVO;
  }

  @Override
  public MemberVO readById(String id) {
    MemberVO memberVO = sqlSessionTemplate.selectOne("member.readById", id);
    return memberVO;
  }

  @Override
  public int update(MemberVO memberVO) {
    int count = sqlSessionTemplate.update("member.update", memberVO);
    return count;
  }

  @Override
  public int passwd_update(Map<String, Object> map) {
    int count = sqlSessionTemplate.update("member.passwd_update", map);
    return count;
  }

  @Override
  public int delete(int memberno) {
    int count = sqlSessionTemplate.delete("member.delete", memberno);
    return count;
  }

  @Override
  public int login(Map map) {
    int count = sqlSessionTemplate.selectOne("member.login", map);
    return count;
  }

  @Override
  public int create_login_list(Map map) {
    int count = sqlSessionTemplate.insert("member.create_login_list", map);
    return count;
  }

  @Override
  public List<LogVO> login_list() {
    List<LogVO> list = sqlSessionTemplate.selectList("member.login_list");
    return list; 
  }
  
  @Override
  public List<LogVO> login_list_paging(HashMap<String, Object> hashmap) {
    List<LogVO> list = sqlSessionTemplate.selectList("member.login_list_paging", hashmap);
    return list;
  }

  @Override
  public int search_count(int memberno) {
    int num = sqlSessionTemplate.selectOne("member.search_count", memberno);
    return num; 
  }
}