package com.my.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.my.dao.AdminDAOOracle;
import com.my.dao.CustomerDAOOracle;
import com.my.vo.Admin;
import com.my.vo.Customer;
import com.my.vo.OrderInfo;

@Controller
public class AdminController {
	
	@Autowired
	public AdminDAOOracle dao = null;
	
	@Autowired
	public CustomerDAOOracle cDao = null;
	
	
	@RequestMapping(value="/adminLogin.do", method=RequestMethod.POST)
	public String login(String id, String pwd, HttpSession session,Model model) throws Exception{
		
		String msg = "-1";
		session.removeAttribute("adminLoginInfo");
		Admin admin;
		admin = dao.selectById(id);
		
		if(admin ==null){	
			msg = "-1";
		}else if(admin != null){
			System.out.println("관리자 로그인 합니다.");
			String dbId = admin.getId();
			String dbpwd = admin.getPassword();

			if(dbId.equals(id) && (dbpwd.equals(pwd))){		
				session.setAttribute("adminLoginInfo",admin);	
				msg = "1";
			}
		}
		model.addAttribute("msg", msg);
		return "result.jsp";
	}
	
	//어드민추가
	@RequestMapping(value="/adminsignup.do", method = RequestMethod.POST)
	public String adminsignup(String id, 
						@RequestParam("pwd") String p, 
						String name,
						Model model){
		
		String msg = "";
		try {
			Admin admin = new Admin(name,id, p);
			System.out.println("컨트롤러값"+admin);
			
			if(id.length() > 5){
				msg = "id값이 너무 큽니다.";					
			
			}else if(!"".equals(p)&& !"".equals(name)){	
			dao.insert(admin);
			msg = "1";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("msg",msg);
		return "/result.jsp";
	}
	
	//어드민 총리스트
	@RequestMapping(value="adminselectAll.do")
	public String selectAll(Model model){
		
		List<Admin> list = new ArrayList<>();
		list = dao.selectAll();
		model.addAttribute("list",list);
		return "adminlistresult.jsp";
	}
	
	//로그아웃
	@RequestMapping(value="adminLogout.do")
	public String logout(HttpSession session, 
						Model model,
						HttpServletRequest request){
		request.setAttribute("msg", request.getContextPath());
		session.removeAttribute("adminLoginInfo");
		return "result.jsp";
	}
	
	// 상태바꾸기
	@RequestMapping(value ="status.do", method=RequestMethod.POST)
	public String status(String id,
			             String status,
			             Model model,
			             HttpSession session) throws Exception{
		
		String msg = "-1";
		System.out.println("id:"+id+"---status:"+status);
		
		//버튼("bt")일때, 체크("ck")일때 구분
		String flag = "bt";
		
		//탈퇴처리
		if(status.equals("delete")){
			
			//고객요청일경우에 버튼
			if(!"".equals(session.getAttribute("loginInfo"))){
				status = "d";
				msg = "1";
				flag = "bt";
				session.removeAttribute("loginInfo");
			}else if(!"".equals(session.getAttribute("adminLoginInfo"))){
			//관리자요청일 경우에
			    status = "d";
				msg = "1";
				
			}
			
		//블랙컨슈머
		}else if(status.equals("blackcon")){
		status = "b";
	    msg = "1";
		}else if(status.equals("clear")){
		status = "";
	    msg = "1";	
		}
		
		//들어오는 id값이 다수일경우에 flag = "ck"
		String[] noLen = id.split(",");
		if(noLen.length > 1){
			flag = "ck";
		}
		
		dao.status(id, status, flag);	
		model.addAttribute("msg",msg);
		return "result.jsp";
	}
	
	//통계뽑기
	@RequestMapping(value="statistics.do")
	public  String statstics(String stat,
			Model model,
			String id,
			String best){
		
		model.addAttribute("best",best);
		System.out.println("best :"+best);
		
		System.out.println("stat :"+stat);
		List<OrderInfo> list = new ArrayList<>();
		List<HashMap<String, Object>> listCustomer=null;
		Customer c = new Customer(id,null,null);
		
		if("customer".equals(stat)){
			//고객요청과 admin 요청이 있다.
			System.out.println("주문하려는 고객정보"+c);
			listCustomer = dao.customerOrderStat(c);
			
			String idSize = c.getId();
			
			
			
			
			model.addAttribute("list",listCustomer);

		}else if("product".equals(stat)){
			list = dao.productOrderStat();
			model.addAttribute("list",list);
			
		}else if("daily".equals(stat)){
			
			list = dao.dailyOrderStat();
			model.addAttribute("list",list);
		}	
		
		
		model.addAttribute("stat",stat);
		
		//model.addAttribute("list",listCustomer);
		return "statisticslistresult.jsp";		
	}
	
	//정보수정
	@RequestMapping(value="adminmodify.do",method=RequestMethod.POST)
	public String update(String id,
			String nowpwd,
		    String newpwd1,
		    String newpwd2,
		    String newname1,
		    String newname2,
			Model model
			){
		String msg = "-1";
		System.out.println("id :"+id+",nowpwd:"+nowpwd+ ",newpwd1 :"+newpwd1);
		String dbPwd = dao.selectById(id).getPassword();
		
		if(dbPwd.equals(nowpwd)&&!"".equals(nowpwd)
		   &&!"".equals(newpwd1)&&!"".equals(newpwd2)){
			
			dao.update(id, newpwd1);
			msg ="1";
		}
		model.addAttribute("msg", msg);
		return "result.jsp";
	}
	
	
	@RequestMapping(value="admcheckid.do" , method=RequestMethod.POST)
	public String checkid(String id, Model model){
		String msg = "1";
		Admin admin=null;
		try {
			admin = dao.selectById(id);
			String dbId = null;
			if(admin!=null){
				dbId = admin.getId();
				if(dbId.equals(id)){
				msg = "-1";
				}else if(!dbId.equals(id)){
				msg = "1";	
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("msg", msg);
		return "/result.jsp";
		
	}
	
	
	
	

}
