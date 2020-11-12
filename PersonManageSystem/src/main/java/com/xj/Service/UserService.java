package com.xj.Service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import com.xj.POJO.User;
import com.xj.POJO.qiandao;

public interface UserService {
	//登录
	User loginByUser(User u);
	//用户列表
	List<User> getUserList(PageSize pageSize);
	//用户添加
	void UserAdd(User u);
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
	boolean checkLoginnameRepeat(String loginname);
	//获取验证码
	void GetCheckCode(HttpServletRequest req, HttpServletResponse resp);
	String getNumber(int size);
	//获取日志页面显示id和empname
	List<User> getUserListIdName();
	//获得工资薪水
	qiandao getSalary(qiandao qq, HttpServletRequest req);
	//更新用户薪水
	void UpdateSalary(qiandao qq);
}
