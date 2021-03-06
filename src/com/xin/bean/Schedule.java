package com.xin.bean;

import java.util.Date;
import java.util.List;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;

/**
 * @author com.xin
 * @since 2017-02-28
 */
public class Schedule {

	@TableId("s_id")
	private Integer sId;
	@TableField("user_id")
	private Long userId;
	@TableField("s_title")
	private String sTitle;
	@TableField("s_content")
	private String sContent;
	@TableField("s_date")
	private Date sDate;
	@TableField("s_finishdate")
	private Date sFinishdate;
	@TableField("s_flag")
	private Integer sFlag;
	private String Day;
	
	private Date begintime;
	private Date endtime;
	private List<User> listUser;

	public Integer getSId() {
		return sId;
	}

	public void setSId(Integer sId) {
		this.sId = sId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getSContent() {
		return sContent;
	}

	public void setSContent(String sContent) {
		this.sContent = sContent;
	}

	public Date getSDate() {
		return sDate;
	}

	public void setSDate(Date sDate) {
		this.sDate = sDate;
	}

	public Date getBegintime() {
		return begintime;
	}

	public void setBegintime(Date begintime) {
		this.begintime = begintime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public List<User> getListUser() {
		return listUser;
	}

	public void setListUser(List<User> listUser) {
		this.listUser = listUser;
	}

	public Integer getsFlag() {
		return sFlag;
	}

	public void setsFlag(Integer sFlag) {
		this.sFlag = sFlag;
	}

	public String getDay() {
		return Day;
	}

	public void setDay(String day) {
		Day = day;
	}

	public String getsTitle() {
		return sTitle;
	}

	public void setsTitle(String sTitle) {
		this.sTitle = sTitle;
	}

	public Date getsFinishdate() {
		return sFinishdate;
	}

	public void setsFinishdate(Date sFinishdate) {
		this.sFinishdate = sFinishdate;
	}

}
