package com.xin.service;

import java.util.List;

import com.xin.bean.Academy;
import com.xin.commons.utils.PageInfo;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author com.xin
 * @since 2017-02-28
 */
public interface IAcademyService{
	List<Academy> selectByName(String school);
	List<Academy> selectAll();
	boolean deleteById(int id);
	Academy selectById(int id);
	boolean updateById(Academy academy);
	boolean insertByid(Academy academy);
	void selectDataGrid(PageInfo pageInfo);
}
