package dev.mvc.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.board.BoardProc")
public class BoardProc implements BoardProcInter {
  @Autowired
  @Qualifier("dev.mvc.board.BoardDAO")
  private BoardDAOInter boardDAO = null;

  public BoardProc() {
    System.out.println("--> BoardProc created.");
  }

  @Override
  public int create(BoardVO categoryVO) {
    return boardDAO.create(categoryVO);
  }

  @Override
  public List<Categrp_BoardVO> list() {
    return boardDAO.list();
  }

  @Override
  public List<Categrp_BoardVO> list_by_categrp(int categrpno) {
    return boardDAO.list_by_categrp(categrpno);
  }

  @Override
  public Categrp_BoardVO read(int categoryno) {
    return boardDAO.read(categoryno);
  }

  @Override
  public int update(BoardVO categoryVO) {
    return boardDAO.update(categoryVO);
  }

  @Override
  public int delete(int categoryno) {
    return boardDAO.delete(categoryno);
  }
}



