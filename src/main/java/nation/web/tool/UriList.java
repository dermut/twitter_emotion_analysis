package nation.web.tool;
 
import java.util.ArrayList;
 
public class UriList {
  public static ArrayList<String> getGuest_list(){ // class가 메모리에 로딩될때 한번 실행
    ArrayList<String> guest_list = new ArrayList<String>();
    guest_list.add("/index.jsp");
    guest_list.add("/notice/list.jsp");
    guest_list.add("/notice/read.jsp");
    
    return guest_list;
  }
  
}