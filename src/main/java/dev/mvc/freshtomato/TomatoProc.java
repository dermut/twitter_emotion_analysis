package dev.mvc.freshtomato;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.freshtomato.TomatoProc")
public class TomatoProc implements TomatoProcInter {
  @Autowired
  @Qualifier("dev.mvc.freshtomato.TomatoDAO")
  private TomatoDAOInter tomatoDAO = null;
  
  @Override
  public int create(TomatoVO tomatoVO) {
    return tomatoDAO.create(tomatoVO);
  }

  @Override
  public TomatoVO read(int ftno) {
    return tomatoDAO.read(ftno);
  }
  
  
}
