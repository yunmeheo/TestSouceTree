package com.my.control;

import java.util.HashMap;
import java.util.Set;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.my.vo.Product;



@Controller
public class CartController {
	
	@RequestMapping(value="addcart.do", method = RequestMethod.GET)
	public String add(HttpSession session,
			@RequestParam("no") String prod_no,
			@RequestParam("name") String prod_name,
			@RequestParam("price") int prod_price,
			int quantity){
		
				Product product = new Product (prod_no,prod_name,prod_price);
				HashMap<Product,Integer> cart = (HashMap<Product,Integer>)session.getAttribute("cart");
				if(cart == null){
					cart = new HashMap();
					session.setAttribute("cart", cart);
				}
				Integer inCartQuantity = cart.get(product);
				if(inCartQuantity == null){
				}else{
					quantity += inCartQuantity;
				}
				cart.put(product, quantity);	
				System.out.println("product:"+product);
				System.out.println("quantity:"+quantity);
				Set<Product> products = cart.keySet();  
				for(Product inCartproduct : products){
					int q = cart.get(inCartproduct);
					System.out.println(inCartproduct.getProd_no()+":" +q);
				}
		return "result.jsp";
	}

	@RequestMapping(value="cartlist.do", method = RequestMethod.GET)
	public String cartlist(){
		
		return "/cartlistresult.jsp";
	}
}
