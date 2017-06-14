package com.my.control;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.Response;

import org.apache.jasper.tagplugins.jstl.core.Redirect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.dao.BoardDAOOracle;
import com.my.vo.Repboard;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class RepboardController {
	
	@Autowired
	BoardDAOOracle dao = null;
	
	@RequestMapping(value="/repboardlist.do")
	public String list(
			@RequestParam(required=false, defaultValue="")  String searchItem,
			@RequestParam(required=false, defaultValue="")  String searchValue,
			String startPage,
			String endPage,
			Model model){
		String msg = "-1";
		List<Repboard> list = new ArrayList<>();
		List<Repboard> listlist = new ArrayList<>();
		String dbSubject =null;
		System.out.println("검색하기 확인중-searchItem :"+searchItem);
		int start=0;
		int end = 9;
		
		//★★전체 검색
		if("".equals(searchItem)){
			
			list = dao.selectAll();
			//★★페이징
			if(startPage != null){
				start = (Integer.parseInt(startPage))*10-10;
			}
			if(endPage != null){
				end = Integer.parseInt(endPage)-1;
			}
			System.out.println("시작페이지:" + start);
			System.out.println("끝페이지:" + end);
			model.addAttribute("start",start);
			model.addAttribute("end",end);
			if(list.size()%10!=0 && list.size()/10==start/10){
				for(int i = start; i <= list.size()-1; i++){
					listlist.add(list.get(i));
				}
			}else{
				for(int i = start; i <= end; i++){
					listlist.add(list.get(i));
				}
			}
		}else if(!"".equals(searchValue) &&"subject".equals(searchItem)){
			//★★제목으로 검색
			System.out.println("제목검색 확인중-searchValue :"+searchValue);
			listlist = dao.selectByName(searchValue);
		
		}else if(!"".equals(searchValue) &&"no".equals(searchItem)){
			//★★번호로 검색		
			int inputNo = Integer.parseInt(searchValue);
			System.out.println("번호검색 확인중-searchValue :"+searchValue);
			listlist = dao.selectByNo(inputNo);

		}else{
			System.out.println("입력값이 없어");
			msg="-1";
		}
		
		int list_size = list.size();
		model.addAttribute("listlist", listlist);
		model.addAttribute("list_size", list_size);
		model.addAttribute("List", list);
		model.addAttribute("msg", msg);

		return "repboardlistresult.jsp";

	}
		
	@RequestMapping(value="/reborddetail.do")
	public String detailList(@RequestParam("no") String strNo,
						   Model model,
						   HttpSession session){
		//session.removeAttribute("no");
		//리스트에서 클릭된 no를 키로 가져온다.
		//String strNo = request.getParameter("no");
		int no = Integer.parseInt(strNo);
		System.out.println(no);
		//session.setAttribute("no", no);
		//객체생성
		//BoardDAOOracle bdDao = new BoardDAOOracle();
		//가져온 키로 selectByNo 실행
		//session.setAttribute("replyNo", no);
		List<Repboard> content = new ArrayList<>();
		content = dao.selectByNo(no);
		//session.removeAttribute("no");
		//리스트에 저장하기
		model.addAttribute("Content", content);
		//model.addAttribute("replyNo", no);
		
		//포워딩
		System.out.println("제목:"+no+"로찾아올거야");
		//String forwardURL = "repboarddetailresult.jsp";
		
		
		return "/repboarddetailresult.jsp";
		
	}
	
	@RequestMapping(value="/repcheckpassword.do", method =RequestMethod.POST)
	public String checkpwd(String selectItem,
						   String password,
						   int no,
						   Model model){

		//삭제인지 수정인지 선택한 값을 가지고 오자
		//String selectItem = request.getParameter("selectItem");
		//파라메터에서 가져오기
		//String password = request.getParameter("password");
		//int no = Integer.parseInt(request.getParameter("no"));		

		//세션에 저장되어있던 번호와 비번
		System.out.println("비밀번호 확인중 - no:"+no);
		System.out.println("비밀번호 확인중 - password:"+password);
		
		//디비에서 비번을 확인해보자
		//BoardDAOOracle bdDao = new BoardDAOOracle();
		//Repboard rb = new Repboard();
		boolean checkpw = false;
		String forwardURL=null;
		
		checkpw = dao.chkPassword(no,password);
		System.out.println(checkpw);
		if(checkpw){ // 비번확인 성공
			//★★업데이트 
			if("update".equals(selectItem) ){
				//forwardURL= "writeboard.jsp";
				model.addAttribute("msg", "1");
				model.addAttribute("password",password);
				
			}//★★삭제일경우 
			else if("delete".equals(selectItem)){
				
				//삭제완료
				dao.delete(no);
				model.addAttribute("msg", "2");
				
			}else if("reply".equals(selectItem)){
				
				model.addAttribute("msg", "3");
				
			}
		}else{ // 비번확인 실패
			model.addAttribute("msg", "-1");
		}
		
		return "result.jsp";
	}
	
	@RequestMapping(value="/updaterepboard.do")
	public String update(String subject,
			String content,
			String password,
			int no,
			Model model
			){
		String msg = "-1";
		System.out.println("no :"+no+"subject :"+ subject+ "content :"+content+"password :"+  password  );
		
		if(subject !=null && content !=null){
		dao.update(no, subject, content, password);
		//수정완료
		msg = "입력완료!";
		}else if(content == null &&content == null){
		//내용을 입력하세요.	
		msg = "다시입력해주세요.!";
		}
		model.addAttribute("msg", msg);
		return "/index.jsp";
	}
	
	/*@RequestMapping(value="/writeboard.do")
	public String write(String subject,String content,String password,Model model){
		
		String msg = "-1";
		Repboard rb = new Repboard(subject,content,password);
		
		//등록성공확인하기
		if(!"".equals(subject)&&!"".equals(content) &&!"".equals(password)){
			dao.insert(rb);
			msg ="1";
		}else{
			msg ="-1";
		}
		//String forwordURL = "repboardlistresult.jsp";
	model.addAttribute("msg", msg);	
	return "/result.jsp";
	}*/
	
	@RequestMapping(value="/writeboard.do")
	public String write(HttpServletRequest request,HttpServletResponse response,
						Model model) throws IOException{
		
		String msg = "-1";
		MultipartRequest multi= null;
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}	
		int sizeLimit = 10 * 1024 * 1024 ; // 10메가입니다.
		String savePath = request.getSession().getServletContext().getRealPath("/upload"); 
		System.out.println("request getContentType : " + request.getContentType());
		try{
		multi= new MultipartRequest
			(request, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
		 }catch (Exception e){
			e.printStackTrace();
		} 
	    String filename = multi.getFilesystemName("filename");
	    String subject = multi.getParameter("subject");
	    String content = multi.getParameter("content");
	    String password = multi.getParameter("password");
		System.out.println("filename"+filename);
		System.out.println("subject"+subject);
		System.out.println("content"+content);
		System.out.println("password"+password);
		//파일있을 때
		if(!"".equals(filename)){
		
			if(!"".equals(subject)&&!"".equals(content) &&!"".equals(password)){
				System.out.println("파일등록중----------");
				Repboard rb = new Repboard(subject,content,password,filename);
				System.out.println(rb);
				dao.insert(rb);
				msg ="파일 업로드 완료-수정중";
			}
		//파일없을 때
		}else{
			if(!"".equals(subject)&&!"".equals(content) &&!"".equals(password)){
			Repboard rb = new Repboard(subject,content,password);
			dao.insert(rb);
			msg ="글쓰기완료-수정중";
			}
		}
	
	
	/*int no =dao.selectMaxNo();	
	List<Repboard> result = new ArrayList<>();
	result = dao.selectByNo(no);
	model.addAttribute("Content", result);
	System.out.println("제목:"+no+"로찾아올거야");
	model.addAttribute("msg", msg);	
	response.sendRedirect("writeresultlist.jsp");*/
	return "/writedetail.do";	
	
	}
	
	//글쓰고 바로 쓴 리스트 보여주기
	@RequestMapping(value="/writedetail.do")
	public String writedetail(HttpServletRequest request,HttpServletResponse response,
						Model model) throws IOException{
	
	
	int no =dao.selectMaxNo();	
	List<Repboard> result = new ArrayList<>();
	result = dao.selectByNo(no);
	model.addAttribute("Content", result);
	System.out.println("제목:"+no+"로찾아올거야");
	/*response.sendRedirect("writeresultlist.jsp");*/
		
	return "/writeresultlist.jsp";
	}
	
	
	
	
	@RequestMapping(value="/replyrepboard.do")
	public String reply(Model model,
			@RequestParam("parent_no") int replyParent_no,
			@RequestParam("content") String replyContent,
			@RequestParam("subject") String replySubject,
			@RequestParam("password") String replyPassword){
		//BoardDAOOracle bdDao = new BoardDAOOracle();
		//Repboard rb = null;
		
		//int replyParent_no = Integer.parseInt(request.getParameter("parent_no"));
		System.out.println(replyParent_no);
		//String replyContent = request.getParameter("content");
		//String replySubject = request.getParameter("subject");
		//String replyPassword = request.getParameter("password");
		model.addAttribute("replyParent_no", replyParent_no);
		
		System.out.println("답글달기 준비중 - parent_no :"+replyParent_no+"subject :"+ replyContent+ "content :"+replySubject+"password :"+  replyPassword );
		
		if(!"".equals(replyContent)){
			
			if(!"".equals(replySubject) && !"".equals(replyPassword)){
				//등록성공
				model.addAttribute("msg", "1");
				dao.insert(new Repboard(replyParent_no,replySubject,replyContent,replyPassword));
				
			}else{
				//내용을 입력 해 주세요.
				model.addAttribute("msg", "-2");
			}
		}else{
			//제목을 입력 해 주세요.
			model.addAttribute("msg", "-2");
		}
		return "/result.jsp";
	}
	
	/*@RequestMapping("fileinsert.do")
	public void fileinsert(HttpServletRequest request) throws IOException{
		
		int sizeLimit = 10 * 1024 * 1024 ; // 10메가입니다.
		String savePath = request.getSession().getServletContext().getRealPath("/upload");    // 파일이 업로드될 실제 tomcat 폴더의 WebContent 기준
		MultipartRequest multi= 
				new MultipartRequest
				(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
		
		String filename = multi.getFilesystemName("filename");
		String title = multi.getParameter("title"); 
		String writer = multi.getParameter("writer");
		int count = 0; 
		String content = multi.getParameter("content"); 
		String regip = request.getRemoteAddr();
	}*/
	
}
