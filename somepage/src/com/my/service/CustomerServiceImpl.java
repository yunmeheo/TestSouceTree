package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dao.CustomerDAOOracle;
import com.my.vo.Customer;

@Service
public class CustomerServiceImpl implements CustomerService{

	@Autowired
	CustomerDAOOracle dao;
	
	@Override
	public void regist(Customer customer) throws Exception {
		dao.insert(customer);
	}

	@Override
	public void login(String id, String pwd) throws Exception {
		Customer c = dao.selectById(id);
		if(c==null || !c.getPassword().equals(pwd)){
			throw new Exception("로그인 실패");
		}
	}

	@Override
	public Customer selectById(String id) throws Exception {
		Customer c = dao.selectById(id);
		return c;
	}

	@Override
	public void modify(Customer c) throws Exception {
			dao.modifyName(c);
	}

	@Override
	public void modifyPassword(Customer c) throws Exception {
			
	}

	@Override
	public void modifyPassword(String id, String password) throws Exception {
		dao.modifyPassword(id, password);
	}

	@Override
	public void remove(Customer c) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void remove(String id) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Customer> selectAll() throws Exception {
		List<Customer> list = dao.selectAll();
		return list;
	}

	@Override
	public List<Customer> selectByName(String name) throws Exception {
		List<Customer> c = dao.selectByName(name);
		return c;
	}

	@Override
	public List<Customer> selectByChk(String searchCk) {
		List<Customer> list = dao.selectByChk(searchCk);
		return list;	}

}