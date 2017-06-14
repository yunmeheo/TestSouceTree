package com.my.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.my.dao.CustomerDAOOracle;
import com.my.vo.Customer;

//@Controller
public class LoginController{
	
	@Autowired   // dao객체를 자동주입 받겠다.
	CustomerDAOOracle dao=null;

	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public String execute(String id, String pwd, HttpSession session,Model model){
		
		String msg = "-1";
		session.removeAttribute("loginInfo");

		//dao = new CustomerDAOOracle();
		Customer customer;
		try {
			customer = dao.selectById(id);
			String dbId = customer.getId();
			String dbpwd = customer.getPassword();
			
			if(dbId !=null){
				if(customer != null){
					if(dbId.equals(id) && (dbpwd.equals(pwd))){		
						session.setAttribute("loginInfo",customer);	
						msg = "1";
					}
				}
			}else{
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("msg", msg);
		String forwarURL="result.jsp";
		return forwarURL;
	}
		
}
	