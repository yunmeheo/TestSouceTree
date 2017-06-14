package com.my.service;

import java.util.List;

import com.my.vo.Customer;

public interface CustomerService {
	
	/**
	 * 고객 가입한다
	 * @param customer 고객객체
	 * @throws Exception
	 */
	void regist(Customer customer) throws Exception;
	/**
	 * 로그인한다.
	 * @param id 아이디
	 * @param pwd 비밀번호
	 * @throws Exception 로그인 실패시에 예외발생한다.
	 */
	void login(String id, String pwd) throws Exception;
	
	/**
	 * 아이디에 해당하는 고객을 반환한다
	 * @param id 아이디
	 * @return 고객객체 아이디에 해당고객이 없을 경우 null을 반환한다.
	 * @throws Exception 
	 */
	Customer selectById(String id) throws Exception;
	
	/**
	 * 이름에 해당하는 고객을 반환한다
	 * @param Name 이름
	 * @return 고객객체 이름에 해당고객이 없을 경우 null을 반환한다.
	 * @throws Exception
	 */
	public List<Customer> selectByName(String name) throws Exception;
	
	/**
	 * 고객정보를 수정한다4
	 * @param c 고객객체 null값을 갖는 프로퍼티는 수정하지 않는다.
	 * @throws Exception 
	 */
	void modify(Customer c) throws Exception;
	
	/**
	 * 비밀번호를 수정한다.
	 * @param c
	 * @throws Exception
	 */
	void modifyPassword(Customer c)throws Exception;
	void modifyPassword(String id, String password)throws Exception;

	/**
	 * 고객정보를 삭제한다.
	 * @param c
	 * @throws Exception
	 */
	void remove(Customer c) throws Exception;
	void remove(String id) throws Exception;
	
	/**
	 * 
	 * @return 모든 고객의 정보를 반환한다.
	 * @throws Exception
	 */
	public List<Customer> selectAll() throws Exception;
	
	/**
	 * 
	 * @param searchCk 체크값
	 * @return 체크값에 대한 고객정보를 반환한다.
	 */
	List<Customer> selectByChk(String searchCk);
	
}