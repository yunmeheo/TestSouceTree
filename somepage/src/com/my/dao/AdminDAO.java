package com.my.dao;

import java.util.HashMap;
import java.util.List;

import com.my.vo.Admin;
import com.my.vo.Customer;
import com.my.vo.OrderInfo;
import com.my.vo.Product;

public interface AdminDAO {
	
	/**
	 * 고객의 상태를 변경한다  삭제 'd', 관리대상고객 'b'
	 * @param id 아이디
	 */
	void status(String id, String status, String flag);
	
	/**
	 * 상품을 등록한다.
	 * @param p 상품
	 */
	public void insert(Product p);
	
	/**
	 * 고객별 최고주문상품 주문통계 [관리자모드, 사용자모드] 
	 * @return 고객별로 가장 많이 주문한 상품을 반환한다.
	 */
	public List<OrderInfo> productOrderStat();
	
	/**
	 * 일자별 주문통계 [관리자모드,사용자모드] 전체고객대상
	 * @return 일자별 가장 많이 주문된 상품을 반환한다.
	 */
	public List<OrderInfo> dailyOrderStat();
	
	
	/**
	 * 고객별 최고주문상품 주문통계 [관리자모드, 사용자모드] 
	 * @return 상품별 가장 많인 주문한 고객을 반환한다.
	 */
	public List<HashMap<String, Object>> customerOrderStat(Customer c);
	
	/**
	 * 특정 아이디값의 고객정보를 반환한다.
	 * @param id 아이디
	 * @return
	 */
	public Admin selectById(String id);
	
	
	public List<Admin> selectAll();

	
	
	
	/*customer테이블의 status 컬럼값 변경(고객탈퇴)
	탈퇴 d
	블랙컨슈머 b
	상품등록
	주문통계
	고객별 주문통계[관리자모드, 사용자모드]   고객별로 가장 많이 주문한 상품을 반환한다.
		    최고 주문상품
		 상품별 주문통계[관리자모드]   상품별 가장 많인 주문한 고객을 반환한다.
		    최고주문자
		 일자별 주문통계[관리자모드,사용자모드]  일자별 가장 많이 주문된 상품을 반환한다.
		 전체고객대상
		    최다 주문상품[관리자모드,사용자모드]    
		    최다 주문자[관리자모드]*/

}
