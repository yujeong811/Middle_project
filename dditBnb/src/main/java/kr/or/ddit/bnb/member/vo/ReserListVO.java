package kr.or.ddit.bnb.member.vo;

import java.util.List;

public class ReserListVO {
	private List<String> img_link;
	private String prod_name;
	private String prod_add1;
	private String check_in;
	private String check_out;
	private String reser_id;
	private String prod_id;
	
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
	public List<String> getImg_link() {
		return img_link;
	}
	public void setImg_link(List<String> img_link) {
		this.img_link = img_link;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getProd_add1() {
		return prod_add1;
	}
	public void setProd_add1(String prod_add1) {
		this.prod_add1 = prod_add1;
	}
	public String getCheck_in() {
		return check_in;
	}
	public void setCheck_in(String check_in) {
		this.check_in = check_in;
	}
	public String getCheck_out() {
		return check_out;
	}
	public void setCheck_out(String check_out) {
		this.check_out = check_out;
	}
	public String getReser_id() {
		return reser_id;
	}
	public void setReser_id(String reser_id) {
		this.reser_id = reser_id;
	}
}                             
