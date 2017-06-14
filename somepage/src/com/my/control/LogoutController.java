package com.my.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//@Controller
public class LogoutController{

	@RequestMapping(value="logout.do")
	public String execute(HttpSession session, Model model){
		
		//HttpSession session = request.getSession();
				session.removeAttribute("loginInfo");
				//String forwarURL="result.do";
				
				//model.setAttribute("msg", request.getContextPath());
		
		//return forwarURL;
				return "result.jsp";
	}
	
	
	
	
	
	
	
	
	
	

}
