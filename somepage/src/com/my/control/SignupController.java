package com.my.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.my.dao.CustomerDAOOracle;
import com.my.vo.Customer;

//@Controller
public class SignupController{
	
	@Autowired
	CustomerDAOOracle dao =null;
	
	@RequestMapping(value="/signup.do", method = RequestMethod.POST)
	public String execute(String id,@Param("pwd") String p, String name,Model model){
		
	//@Param은 요청전달데이터의 이름과 매개변수의 매핑을 도와줌
		String msg = "";
		try {
			Customer c = new Customer(id, p, name);
			if(id.length() > 3){
				msg = "Please input your id below three letters";					
			}else if(!"".equals(p)&& !"".equals(name)){	
			dao.insert(c);
			msg = "1";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("msg",msg);
		/*String forwarURL="/result.jsp";
		return forwarURL;*/
		return "/result.jsp";
	}
}
