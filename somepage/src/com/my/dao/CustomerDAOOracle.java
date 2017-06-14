package com.my.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.stereotype.Repository;

import com.my.vo.Customer;

@Repository
public class CustomerDAOOracle implements CustomerDAO {

	@Autowired
	private SqlSession session;
	
	//스프링에서는 마이바티스 객체를 관리하기때문에 close 사용하지 않는다.
	@Override
	public void insert(Customer c) throws Exception {
		
	try {
		    System.out.println(c);
			session.insert("CustomerMapper2.insert",c);
		}catch(DuplicateKeyException e){
			throw new Exception("이미존재하는 아이디 입니다.");
		}catch(BadSqlGrammarException e){
			throw new Exception("SQL 구문오류!");
		}catch(Exception e){
				throw e;
		}
	}

	@Override
	public List<Customer> selectAll() throws Exception {
		
		return session.selectList("CustomerMapper2.selectAll");
		
		
	}

	
	@Override
	public Customer selectById(String id) throws Exception {
	
		return session.selectOne("CustomerMapper2.selectById",id);
		
	}

	
	@Override
	public List<Customer> selectByName(String name) throws Exception {
		
		System.out.println("customerdaooracle name:"+name);
		return session.selectList("CustomerMapper2.selectByName",name); 
		
	}

	@Override
	public void modifyPassword(String id, String password) throws Exception {
		
		//System.out.println(id+","+password);
		
		Map<String,Object> map = new HashMap<>();
		map.put("id", id);
		map.put("password",password);
		session.update("CustomerMapper2.modifyPassword",map);		
	}
	

	@Override
	public void modifyName(Customer c) throws Exception {

		/*Map<String,Object> map = new HashMap<>();
		map.put("id", id);
		map.put("name",name);*/
		System.out.println("customerDAOOracle :" +c);
		session.update("CustomerMapper2.modifyName",c);	
		
		
	}

	public List<Customer> selectByChk(String searchCk) {
		System.out.println("customerDAOOracle searchCk:" +searchCk);
		return session.selectList("CustomerMapper2.selectByChk",searchCk);
	}
	
	
	
	
	
	
}