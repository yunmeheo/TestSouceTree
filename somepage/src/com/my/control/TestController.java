package com.my.control;

import java.util.Arrays;
import java.util.Locale;

import javax.validation.Valid;

import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.my.validator.MyValidator;
import com.my.vo.Customer;

@Controller
@SessionAttributes("customer")
public class TestController implements MessageSourceAware {
	
	private MessageSource ms;
	@Override
	public void setMessageSource(MessageSource ms) {
		this.ms = ms;
	}
	
	@RequestMapping("/test.do")
	public void test(){
		Locale locale = Locale.getDefault();
		String[] args = {"허윤미"};
		String greeting = ms.getMessage("greeting", args, Locale.getDefault());
		
		System.out.println(greeting);
	}
	
	@RequestMapping("/validtest.do")
	public String validtest(@Valid @ModelAttribute("c") Customer c , Errors errors, Model model){
		
		//new MyValidator().validate(c, errors);
		if(errors.hasErrors()){
			//System.out.println(errors);
			System.out.println(errors.getFieldError("id"));
			//실패시 원래화면 그대로 보여주기
			return "/validtestform.jsp";
		}
		model.addAttribute("msg","성공!");
		return "/result.jsp";
	}
	
	@InitBinder
	protected void initBider(WebDataBinder binder){
		binder.setValidator(new MyValidator());
	}
	//
	
	//한 컨트롤러에서 쓰이는 공유 attribute, 매핑값이 변경되어도 똑같이 불러올 수 있다.
	//커멘트객체에 사용할경우 
	@ModelAttribute("msg")
	public String a(){
		return "hello";
	}
	
	//비어있는 객체를 만들고 /modeltest3.do가 /modeltest3.do?id=1&password=2&name=3로 값을 채운다.
	@ModelAttribute("customer")
	public Customer c(){
		System.out.println("c() 메서드호출");
		return new Customer();
	}
	
	@RequestMapping("/modeltest.do")
	public String modeltest1(Model model){
		model.addAttribute("attr1","one");
		return "/modeltestresult.jsp";
	}
	
	@RequestMapping("/modeltest2.do")
	public String modeltest2(Model model){
		model.addAttribute("attr2","one");
		return "/modeltestresult.jsp";
	}
	
	@RequestMapping("/modeltest3.do")
	public String modeltest3(@ModelAttribute("customer") Customer c,
			  				Model model){
		model.addAttribute("attr3","one");
		return "/modeltestresult.jsp";
	}
	
	@RequestMapping("/modeltest4.do")
	public String modeltest4(SessionStatus status){
		status.setComplete();
		return "/modeltestresult.jsp";
	}
	
	
	@RequestMapping("/result.jsp")
	public void result(){
		
		System.out.println("result.jsp를 요청했습니다.");
		
	}
	
	// viewresolver로 등록해뒀기 때문에.jsp를 쓰지 않아도 자동 포워딩 된다.
	
	 @RequestMapping("/resolver.do")
	 public String resolver(Model model){
		 model.addAttribute("msg", "InternalResourceViewResolver 사용");
		 return "result";    
	 }
	 
	 
	 
	 @RequestMapping("/result.do")
	 public void resolver1(Model model){
		 model.addAttribute("msg", "InternalResourceViewResolver 사용");
	 }
	 
	 @RequestMapping("/jsontest1.do")
	 public @ResponseBody String jsontest1(){
		 return "a=hello&b=test";
	 }
	
	 @RequestMapping("/jsontest2.do")
	 public @ResponseBody Customer jsontest(){
		 return new Customer("id2","p2","n2");
	 }
	 
	 /*@RequestMapping("/jsontest.do")
	 public @ResponseBody Customer jsontestList(){
		 
		List<Customer> list = null;
		list = Arrays.asList(
		 new Customer("id1","p1","n1"),
		 new Customer("id2","p2","n2")
		 );
		return new Customer(list);
	 }*/
	
	
	

}
