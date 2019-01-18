package dev.mvc.board;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.board.BoardDAO") // DBMS 저장소 접근 
public class BoardDAO implements BoardDAOInter {
  @Autowired  // 빈을 스프링이 만들어서 자동 할당, 개발자는 new 사용 안함.
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public BoardDAO() {
    System.out.println("--> BoardDAO created.");
  }

  @Override
  public int create(BoardVO boardVO) {
    return sqlSessionTemplate.insert("board.create", boardVO);
  }

  @Override
  public List<Categrp_BoardVO> list() {
    return sqlSessionTemplate.selectList("board.list");
  }

  @Override
  public List<Categrp_BoardVO> list_by_categrp(int categrpno) {
    return sqlSessionTemplate.selectList("board.list_by_categrp", categrpno);
  }

  @Override
  public BoardVO read(int boardno) {
    return sqlSessionTemplate.selectOne("board.read", boardno);
  }

  @Override
  public int update(BoardVO boardVO) {
    return sqlSessionTemplate.update("board.update", boardVO);
  }

  @Override
  public int delete(int boardno) {
    return sqlSessionTemplate.delete("board.delete", boardno);
  }

  @Override
  public int delete_by_categrp(int categrpno) {
    return sqlSessionTemplate.delete("board.delete_by_categrp", categrpno);
  }

  @Override
  public int count_by_board(int boardno) {
    return sqlSessionTemplate.selectOne("board.count_by_board", boardno);
  }
  
  @Override
  public int delete_contents_by_board(int boardno) {
    return sqlSessionTemplate.delete("board.delete_contents_by_board", boardno);
  }

  @Override
  public String getId(int memberno) {
    return sqlSessionTemplate.selectOne("board.getId", memberno);
  }
  
}












