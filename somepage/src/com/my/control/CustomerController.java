package com.my.control;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.my.service.CustomerService;
import com.my.vo.Customer;

@Controller
//@SessionAttributes("loginInfo")   모델의 어트리뷰트는 세션에 추가시켜라
// model.addAttribute("loginInfo",customer);	   하는것과 똑같다.

public class CustomerController {

	@Autowired  
	//CustomerDAOOracle dao=null;
	private CustomerService service;
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public String login(String id, String pwd, HttpSession session,Model model) throws Exception{
		
		String msg = "-1";
		session.removeAttribute("loginInfo");
		Customer customer;
		customer = service.selectById(id);
			
		if(customer ==null){	
			msg = "-1";
		}else if(customer != null){
			String dbId = customer.getId();
			String dbpwd = customer.getPassword();
			
			
			//탈퇴또는 삭제아이디는 로그인 불가
			Customer c = service.selectById(id);
			String status = c.getStatus();
			if("d".equals(status)){
				msg ="-1";
			//정상고객 로그인	
			}else if(!"d".equals(status) && dbId.equals(id) && (dbpwd.equals(pwd))){		
				session.setAttribute("loginInfo",customer);	
				msg = "1";
			}
		}
				
		model.addAttribute("msg", msg);
		return "result.jsp";
	}
	
	@RequestMapping(value="/signup.do", method = RequestMethod.POST)
	public String signup(String id, @RequestParam("pwd") String p, String name,Model model){
		
		String msg = "-1";
		try {
			Customer c = new Customer(id, p, name);
			System.out.println("컨트롤러값"+c);
			if(id.length() > 3){
				msg = "id값이 너무 큽니다.";					
			}else if(!"".equals(p)&& !"".equals(name)){	
			service.regist(c);
			msg = "1";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("msg",msg);
		return "/result.jsp";
	}
	
	@RequestMapping(value="checkid.do" , method=RequestMethod.POST)
	public String checkid(String id, Model model){
		String msg = "1";
		Customer customer;
		try {
			customer = service.selectById(id);
			String dbId = null;
			if(customer!=null){
				dbId = customer.getId();
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
	
	@RequestMapping(value="logout.do")
	public String logout(HttpSession session, 
						Model model,
						HttpServletRequest request){
		request.setAttribute("msg", request.getContextPath());
		session.removeAttribute("loginInfo");
		return "result.jsp";
		
		//리무브 대신 사용할 수 있음 ↓
		//  >> status.setComplete();   세션있는 값을 삭제하라!
	}
	
	/*@RequestMapping(value="selectById.do", method=RequestMethod.POST)
	public String selectById(@RequestParam("searchValue") String id,
							Model model) throws Exception{
		
		
		Customer c = service.selectById(id);
		System.out.println(c);
		
		model.addAttribute("c",c);
		model.addAttribute("msg","1");
		return "customerlist.jsp";
		
	}
	
	@RequestMapping(value="selectAll.do")
	public String selectAll(String id,
							Model model) throws Exception{
		
		List<Customer> list= service.selectAll();
		model.addAttribute("list",list);
		return "customerlist.jsp";
	}*/
	
	
	@RequestMapping(value="selectAll.do")
	public String customerList( @RequestParam(required=false, defaultValue="0")  int searchItem,
								@RequestParam(required=false, defaultValue="")  String searchValue,
								String searchCk,
								Model model) throws Exception{
		
		System.out.println("searchItem :"+searchItem+",searchValue :"+searchValue+",searchCk :"+searchCk);
		List<Customer> list=new ArrayList<>();
		String msg="-1";
		
		//첫 화면 전체고객 반환 & 밸류 입력없이 체크막스만 체크했을 경우
		if("".equals(searchItem)&&"".equals(searchValue)){
			
			//전체고객 조회
			System.out.println("customercontroller 전체고객 조회 들어갑니다.");
			list = service.selectAll();
			
		}else if(!"".equals(searchItem)&&"".equals(searchValue)){
			//체크값없이 조회 클릭
			if("delete".equals(searchCk)){
				searchCk = searchCk.substring(0, 1);
				list = service.selectByChk(searchCk);
				
			}else if("blackcon".equals(searchCk)){
				searchCk = searchCk.substring(0, 1);
				list = service.selectByChk(searchCk);
			}else if("clear".equals(searchCk)){
				searchCk = null;
				list = service.selectByChk(searchCk);
			}else{
			//체크, 검색밸류 없이 검색 클릭
			System.out.println("customercontroller 전체고객 조회 들어갑니다.");
			list = service.selectAll();
			}
		}else if("id".equals(searchItem)){
			Customer c =service.selectById(searchValue);
			
			//검색시 체크값이 있을 경우에  체크값에 아이디
			if("blackcon".equals(searchCk)&&"b".equals(c.getStatus())){
				list.add(c);
			}
			if("delete".equals(searchCk)&&"d".equals(c.getStatus())){
				list.add(c);
			}
			if("clear".equals(searchCk)&&"".equals(c.getStatus())){
				list.add(c);
			}
			if(!"blackcon".equals(searchCk)&&!"delete".equals(searchCk)
					&&!"clear".equals(searchCk)){
				list.add(c);
			}

		}else if("name".equals(searchItem)){
			/*Customer c =service.sele*/

				List<Customer> allNameList = service.selectByName(searchValue);
				list = new ArrayList<>();
				String status =null;
				Customer c = null;
				//체크되었을 때 리스트중 조건 걸러내기
				for (Iterator<Customer> iterator = allNameList.iterator(); iterator.hasNext(); ) {
					c = iterator.next();   // 한줄씩 가져오기
					status = c.getStatus();
					System.out.println("customercontroller status : " + status);
					
					if("blackcon".equals(searchCk)&&"b".equals(c.getStatus())){
						c =service.selectById(c.getId());
						 list.add(c);
					}
					if("delete".equals(searchCk)&&"d".equals(c.getStatus())){
						 c =service.selectById(c.getId());;
						 list.add(c);
					}
					
					if("clear".equals(searchCk)){
						if(!"b".equals(c.getStatus())&&!"d".equals(c.getStatus())){
						 c =service.selectById(c.getId());;
						 list.add(c);
						}
					}
					if(!"blackcon".equals(searchCk)&&!"delete".equals(searchCk)&&!"clear".equals(searchCk)){
						 c =service.selectById(c.getId());;
						list.add(c);
					}

				}



				
				/*for(Customer c : list){
					
					status = c.getStatus();
					System.out.println("customercontroller status : " + status);
					//c.getStatus();
					if("blackcon".equals(searchCk)&&"b".equals(c.getStatus())){
						 c =service.selectById(searchValue);
					}else if("delete".equals(searchCk)&&"d".equals(c.getStatus())){
						 c =service.selectById(searchValue);
					}
					
					list.add(c);
				}*/
			
			msg="1";
			model.addAttribute("msg",msg);
		}
		
		
		int pageno = list.size();
		System.out.println("pageno:"+pageno);		
		model.addAttribute("list",list);		
		model.addAttribute("pageno",pageno);
		return "customerlist.jsp";
	}
	
	@RequestMapping(value="cusmodify.do",method=RequestMethod.POST)
	public String update(String id,
			String nowpwd,
			String nowpwd1,
		    String newpwd1,
		    String newpwd2,
			String newname1,
			String newname2,
			Model model,
			HttpSession session,
			String value 
			) throws Exception{
		
		String msg = "-1";
        String dbPwd = service.selectById(id).getPassword();
        Customer c = null;
        //비밀번호 수정하기
        System.out.println("dbPwd:"+dbPwd+",nowpwd1:"+nowpwd1);
        if("modpwdbt".equals(value)&& dbPwd.equals(nowpwd1)){
        	
	        if(!"".equals(newpwd1)&&!"".equals(newpwd2)){
	        	System.out.println("newpwd1:"+newpwd1+",newpwd2:"+newpwd2);
				msg ="1";
				service.modifyPassword(id, newpwd1);
				c=service.selectById(id);
				session.removeAttribute("loginInfo");
				session.setAttribute("loginInfo", c);
				
	        }
        //이름 수정하기
        }else if("modnamebt".equals(value)&& dbPwd.equals(nowpwd)){
        	if(!"".equals(newname1)&&!"".equals(newname2)){
        		System.out.println("newname1:"+newname1+",newname2:"+newname2);
        		msg ="1";
        		c=new Customer(id,nowpwd,newname1);
				service.modify(c);
				session.removeAttribute("loginInfo");
				session.setAttribute("loginInfo", c);
	        }
        }
        
		
		model.addAttribute("msg", msg);
		return "result.jsp";
	}
	
}