package com.my.control;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.my.dao.OrderDAOOrcle;
import com.my.vo.Customer;
import com.my.vo.OrderInfo;
import com.my.vo.OrderLine;
import com.my.vo.Product;

@Controller
public class OrderController {
	
	@Autowired
	OrderDAOOrcle dao =null;
	@Autowired
	private SqlSession sSession;
	
	@RequestMapping(value="/addorder.do", method = RequestMethod.POST )
	public String addorder(HttpSession session) throws Exception{
		//SqlSession sSession;
		Customer c = (Customer)session.getAttribute("loginInfo"); 
		System.out.println(c);
		HashMap<Product, Integer> cart = (HashMap<Product, Integer>)session.getAttribute("cart");
		String forwardURL = null;
		int quantity = 0;
		
		if(cart != null){
			if(c== null){
				forwardURL = "/loginform.jsp";
				System.out.println("로그인 안되어있어요, 로그인 해쥬세염");
			}else if(c!=null){
				Set<Product> products = cart.keySet();
				List<OrderLine> line = new ArrayList<>();
				OrderInfo info= null;
				for(Product p : products){
					quantity = cart.get(p);
					line.add(new OrderLine(0, p, quantity));
					info = new OrderInfo(0, null, c, line);
					//dao.insert(info,sSession);					
					forwardURL="/orderlist.do";
					session.removeAttribute("cart");
					System.out.println("주문완료, 땡큐");
				}
				dao.insert(info,sSession);
			}
		}else if(cart == null){
			System.out.println("카트에 아무것도 없능데??");
			forwardURL="/productlistresult.jsp";
		}
		
		System.out.println(forwardURL);
		return forwardURL;
		
	}
		
	
	@RequestMapping("/orderlist.do")
	public String orderlist(String info_date,
							String info_no,
							HttpSession session,
							Model model
					
							){
		session.removeAttribute("list");
		Customer c = (Customer)session.getAttribute("loginInfo");
		String id = c.getId();
		System.out.println("orderlist.do 의 리스트 뽑아올 id: "+id);
		//session.setAttribute("date", info_date);
		//session.setAttribute("info_no", info_no);
		
		List<OrderInfo> list = new ArrayList<>();
			try {
				System.out.println("주문들어갈 ID :"+id);
				list = dao.selectById(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("총 가져올 리스트 : "+list);
			model.addAttribute("list", list);
		System.out.println("총 주문제품 페이지로 넘어갑니다");
		return "/orderlistresult.jsp";
	}
}


