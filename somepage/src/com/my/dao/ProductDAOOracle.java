package com.my.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.vo.Product;

@Repository
public class ProductDAOOracle implements ProductDAO {
	
	@Autowired
	private SqlSession session;

	
	@Override
	public void insert(Product p) throws Exception {
			
			session.insert("ProductMapper.insert", p);
			//session.commit();
	}
	
	
	@Override
	public List<Product> selectAll() throws Exception{
		
		return session.selectList("ProductMapper.selectAll");
		
		}
	
	
	@Override
	public Product selectByNo(String no) throws Exception {
		
		return session.selectOne("ProductMapper.selectByNo",no);	
		
	}
	
	
	@Override
	public List<Product> selectByName(String word) {
		
		return session.selectList("ProductMapper.selectByName", word);
		
	}


	@Override
	public void modify(Product p) throws Exception {

		session.update("ProductMapper.modify", p);
	}

	
	
	
}
