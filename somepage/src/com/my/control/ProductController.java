package com.my.control;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.my.dao.ProductDAOOracle;
import com.my.vo.Admin;
import com.my.vo.Customer;
import com.my.vo.Product;

@Controller
public class ProductController {
	
	@Autowired
	ProductDAOOracle dao = null;
	
	
	//선택적으로 전달될 수있는 데이터다 = @RequestParam(required=false)
	//매개변수에서 nullpoint 피해갈 수 있다.
	@RequestMapping(value="productlist.do")
	public String productlist( @RequestParam(required=false, defaultValue="") String searchItem, 
							   @RequestParam(required=false, defaultValue="") String searchValue, 
							   Model model,
							   HttpSession session) throws Exception{
		List<Product> list = new ArrayList<>();
			Product p = new Product();
			System.out.println("상품searchItem"+searchItem);
			if("".equals(searchItem)){
				list = dao.selectAll();
				
			}else if("name".equals(searchItem) && !"".equals(searchValue)){
				list = dao.selectByName(searchValue);
				
			}else if("no".equals(searchItem) && !"".equals(searchValue)){
				p = dao.selectByNo(searchValue);
				if(p != null){
				list.add(p);
				} 
			}
			model.addAttribute("list", list);
		
		/*//관리자요청페이지 고객요청페이지 나누기
		Admin admin = (Admin) session.getAttribute("adminLoginInfo");
		Customer customer = (Customer) session.getAttribute("loginInfo");
		
		//고객이라면
		if("".equals(admin)){
			url= "/productlistresult.jsp";
		//관리자라면
		}else if("".equals(customer)){
			url="/admproductlistresult.jsp";
		}*/
		
		return "/productlistresult.jsp";
		
	}
	
	
	@RequestMapping(value="productdetail.do", method=RequestMethod.POST)
	@ResponseBody
	public Product productdetail(String no){
		Product product= new Product();
		try {
				product = dao.selectByNo(no);
				return product;
		} catch (Exception e) {
			e.printStackTrace();
		}
		//model.addAttribute("product", product);
		Product pError = new Product();
		pError.setProd_no("-1");
		return pError;
	}


	@RequestMapping(value ="insertProduct.do", method=RequestMethod.POST)
	public String insertProduct(String no,
			String name,
			int price,
			Model model) throws Exception{
		String msg ="-1";
		Product p= new Product(no,name,price);
		
		System.out.println(p);
		
		if(p!=null &&p.getProd_no().length() < 5){
			//String dbNo = pDao.selectByNo(no).getProd_no();
			dao.insert(p);
			msg="1";
		}
		
		model.addAttribute("msg", msg);
		return "result.jsp";
	}


	@RequestMapping(value ="modifyProduct.do")
	public String modifyProduct(String prod_no, 
								String prod_name,
								int prod_price,
								Model model) throws Exception{
		String msg="-1";
		if(!"".equals(prod_no)&&!"".equals(prod_name)&&!"".equals(prod_price)){
			
			Product p = new Product(prod_no,prod_name,prod_price);
			dao.modify(p);
			msg="1";
			//상품명만 수정할때
			
			
			
			
			//제목만 수정할 때
			
			
			
			
			
			
			
		}
		
		
		model.addAttribute("msg",msg);
		return "result.jsp";
	}
	
	
	
}
