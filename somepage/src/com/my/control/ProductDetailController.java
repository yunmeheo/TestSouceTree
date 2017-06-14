package com.my.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.my.dao.ProductDAOOracle;
import com.my.vo.Product;

//@Controller
public class ProductDetailController{
	
	@Autowired
	ProductDAOOracle dao =null;

	@RequestMapping(value="productdetail.do", method=RequestMethod.GET)
	public String execute(String no,Model model){
			
		//public Product selectByNo(String no) throws Exception 
		//들어오는 상품번호로  selectByNo 호출해서 그 값을 다시 돌려보내자
		//String no = request.getParameter("no");
		Product product= new Product();
		try {
			//dao = new ProductDAOOracle();
			if(no != null){
				product = dao.selectByNo(no);
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("product", product);
		
		return "productdetailresult.jsp";
		
	}

}
