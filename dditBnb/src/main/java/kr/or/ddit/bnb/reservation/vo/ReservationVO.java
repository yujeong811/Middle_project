package kr.or.ddit.bnb.reservation.vo;

public class ReservationVO {
	private String reser_id    ;
	private String sche_id     ;
	private String reser_stat  ;
	private int reser_per   ;
	private String reser_req   ;
	private int reser_price ;
	private String reser_date  ;
	
	public String getReser_id() {
		return reser_id;
	}
	public void setReser_id(String reser_id) {
		this.reser_id = reser_id;
	}
	public String getSche_id() {
		return sche_id;
	}
	public void setSche_id(String sche_id) {
		this.sche_id = sche_id;
	}
	public String getReser_stat() {
		return reser_stat;
	}
	public void setReser_stat(String reser_stat) {
		this.reser_stat = reser_stat;
	}
	public int getReser_per() {
		return reser_per;
	}
	public void setReser_per(int reser_per) {
		this.reser_per = reser_per;
	}
	public String getReser_req() {
		return reser_req;
	}
	public void setReser_req(String reser_req) {
		this.reser_req = reser_req;
	}
	public int getReser_price() {
		return reser_price;
	}
	public void setReser_price(int reser_price) {
		this.reser_price = reser_price;
	}
	public String getReser_date() {
		return reser_date;
	}
	public void setReser_date(String reser_date) {
		this.reser_date = reser_date;
	}
	
}
