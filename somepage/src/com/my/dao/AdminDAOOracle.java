package com.my.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.vo.Admin;
import com.my.vo.Customer;
import com.my.vo.OrderInfo;
import com.my.vo.Product;

@Repository
public class AdminDAOOracle implements AdminDAO {
	
	@Autowired
	public SqlSession session;

	

	@Override
	public void status(String id,String status, String flag) {
		Map<String,Object> map = new HashMap<>();
		System.out.println(id+"-----------");
		map.put("id", id);
		map.put("status",status);
		map.put("flag",flag);
		session.update("AdminMapper.status",map);
		
	}

	@Override
	public void insert(Product p) {
		session.insert("ProductMapper.insert", p);
	}

	@Override
	public List<OrderInfo> productOrderStat() { // 작업중
		return session.selectList("AdminMapper.productOrderStat");
	}

	@Override
	public List<OrderInfo> dailyOrderStat() {
		return session.selectList("AdminMapper.dailyOrderStat");
	}

	@Override
	public List<HashMap<String, Object>> customerOrderStat(Customer c) {//완성
		/*List<OrderInfo> list = session.selectList("AdminMapper.customerOrderStat");
		for(OrderInfo info: list){
			System.out.println(info.getInfo_c());
			for(OrderLine line:info.getLines()){
				System.out.println(line.getLine_prod_no() +":" + line.getLine_quantity());
			}
			
		}*/
		List<HashMap<String, Object>> list = session.selectList("AdminMapper.customerOrderStat",c);
		return list;
	}

	public Admin selectById(String id) {
		return session.selectOne("AdminMapper.selectById",id );
	}
    
	
	//관리자 정보 수정하기
	public void update(String id, String password) {
		Map<String,Object> map = new HashMap<>();
		map.put("id", id);
		map.put("password",password);
		session.update("AdminMapper.adminmodify",map);
	}
     
	//관리자 추가하기
	public void insert(Admin admin) {
		
		session.insert("AdminMapper.insert",admin);
		
	}

	@Override
	public List<Admin> selectAll() {
		
		return session.selectList("AdminMapper.selectAll");
	}

}
