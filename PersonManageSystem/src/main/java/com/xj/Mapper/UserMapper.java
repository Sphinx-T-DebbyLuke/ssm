package com.xj.Mapper;

import java.util.List;

import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import com.xj.POJO.User;
import com.xj.POJO.qiandao;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMapper {
	//登录
	User loginByUser(User u);
	//用户列表
	List<User> getUserList(PageSize pageSize);
	//用户添加
	void UserAdd(User user);
	//计算总行数
	Integer totolUser(PageSize pageSize);
	//修改用户在线状态
	void updateByUserstatus(User u);
	//动态获取用户状态
	List<User> getDymicUserStatus();
	//根据id查询用户
	User getUserById(Integer id);
	//修改用户信息
	void updateUser(User u);
	//批量删除
	void deleteUserByList(QueryVo vo);
	//查询注册或添加时的登录名是否重复
	User checkLoginnameRepeat(String loginname);
	//获取日志页面显示id和empname
	List<User> getUserListIdName();
	//更新用户薪水
	void UpdateSalary(qiandao qq);
}
