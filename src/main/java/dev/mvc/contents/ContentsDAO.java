package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.contents.ContentsDAO") // DBMS 저장소 접근 
public class ContentsDAO implements ContentsDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public ContentsDAO() {
    System.out.println("--> ContentsDAO created.");
  }

  @Override
  public int create(ContentsVO contentsVO) {
    return sqlSessionTemplate.insert("contents.create", contentsVO);
  }

  @Override
  public List<ContentsVO> list_all_board() {
    return sqlSessionTemplate.selectList("contents.list_all_board");
  }

  @Override
  public int total_count() {
    return sqlSessionTemplate.selectOne("contents.total_count");
  }

  @Override
  public List<ContentsVO> list_by_board(int boardno) {
    return sqlSessionTemplate.selectList("contents.list_by_board", boardno);
  }

  @Override
  public ContentsVO read(int contentsno) {
    return sqlSessionTemplate.selectOne("contents.read", contentsno);
  }

  @Override
  public int update(ContentsVO contentsVO) {
    return sqlSessionTemplate.update("contents.update", contentsVO);
  }

  @Override
  public int delete(int contentsno) {
    return sqlSessionTemplate.update("contents.delete", contentsno);
  }

  @Override
  public List<ContentsVO> list_by_board_search(HashMap hashMap) {
    return sqlSessionTemplate.selectList("contents.list_by_board_search", hashMap);
  }

  @Override
  public int search_count(HashMap hashMap) {
    return sqlSessionTemplate.selectOne("contents.search_count", hashMap);
  }
  
  @Override
  public List<ContentsVO> list_by_board_search_paging(HashMap<String, Object> hashMap) {
    //return sqlSessionTemplate.selectList("contents.list_by_board_search_paging", hashMap);
    return sqlSessionTemplate.selectList("contents.list_by_board_search_paging2", hashMap);
  }
  
  @Override
  public int updateAnsnum(ContentsVO contentsVO) {
    return sqlSessionTemplate.update("contents.updateAnsnum", contentsVO); 
  }

  @Override
  public int reply(ContentsVO contentsVO) {
    return sqlSessionTemplate.insert("contents.reply", contentsVO);
  }

  
}









