package com.my.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.my.vo.OrderInfo;
import com.my.vo.OrderLine;

// 주문정보와 처리는 함께하기때문에   orderinfo + orderline 합쳐서 1개로 클래스 만들자.
@Repository
public class OrderDAOOrcle {

	@Autowired
	private SqlSession session;

	//IO
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = IOException.class)
	public void insert(OrderInfo info,SqlSession session) throws Exception{
			
				insertInfo(info,session);
				insertLine(info,session);
			
	}

	public void insertInfo(OrderInfo info,SqlSession session ) throws SQLException{

			session.insert("OrderInfoMapper.insertInfo",info);
	}
	

	public void insertLine(OrderInfo info,SqlSession session) throws SQLException , Exception{
		
			List<OrderLine> lines = info.getLines();
			for(OrderLine line : lines){
			session.insert("OrderInfoMapper.insertLine",line);
			}
			
	}

	
	public List<OrderInfo> selectById(String id) throws Exception{
		
		return session.selectList("OrderInfoMapper.selectById", id);
		
	}

}

/*
	*//**
	 * 
	 * 주문번호에 해당 주문정보를 반환한다.
	 * @param info_no 주문번호
	 * @return
	 *//*
	public OrderInfo infoNo(int info_no){

		return null;

	}


	*//**
	 * 
	 * 상품에 해당 주문목록을 반환한다.
	 * @param prod_no 상품번호
	 * @return
	 *//*
	public List<OrderInfo> selectByProdoNO(String prod_no){

		return null;

	}



	//시작하는 날부터 to날까지의 주문목록 반환한다.
	*//**
	 * 
	 * 주문일자에 해당 주문목록을 반환한다.
	 * @param frDate 주문시작일자
	 * @param toDate 주문종료일자
	 * @return
	 *//*
	public List<OrderInfo> selectByDate(String frDate, String toDate){
		return null;

	}

}
*/