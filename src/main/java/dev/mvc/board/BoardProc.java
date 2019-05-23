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
  public int create(BoardVO boardVO) {
    return boardDAO.create(boardVO);
  }

  @Override
  public List<Categrp_BoardVO> list() {
    return boardDAO.list();
  }
  
  @Override
  public List<BoardVO> list_menu() {
    return boardDAO.list_menu(); 
  }

  @Override
  public List<Categrp_BoardVO> list_by_categrp(int categrpno) {
    return boardDAO.list_by_categrp(categrpno);
  }
  
  @Override
  public List<Categrp_BoardVO> list_by_categrp_id(int categrpno) {
    return boardDAO.list_by_categrp_id(categrpno);
  }

  @Override
  public BoardVO read(int boardno) {
    return boardDAO.read(boardno);
  }

  @Override
  public int update(BoardVO boardVO) {
    return boardDAO.update(boardVO);
  }

  @Override
  public int delete(int categoryno) {
    return boardDAO.delete(categoryno);
  }

  @Override
  public int delete_by_categrp(int categrpno) {
    return boardDAO.delete_by_categrp(categrpno);
  }

  @Override
  public int count_by_board(int boardno) {
    return boardDAO.count_by_board(boardno);
  }
  
  @Override
  public int delete_contents_by_board(int boardno) {
    return boardDAO.delete_contents_by_board(boardno); 
  }

  @Override
  public String getId(int memberno) {
    return boardDAO.getId(memberno);
  }

}