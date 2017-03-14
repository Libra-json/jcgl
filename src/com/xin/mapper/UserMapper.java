package com.xin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.xin.bean.User;
import com.xin.bean.vo.UserVo;

/**
 *
 * User 表数据库控制层接口
 *
 */
public interface UserMapper extends BaseMapper<User> {
	
    UserVo selectUserVoById(@Param("id") Long id);
    UserVo homeLogin(UserVo userVo);
    List<UserVo> selectUserVoPage(Pagination page, Map<String, Object> params);

}