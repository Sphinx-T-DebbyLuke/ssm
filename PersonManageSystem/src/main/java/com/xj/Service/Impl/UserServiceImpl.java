package com.xj.Service.Impl;

import com.xj.Mapper.EmpMapper;
import com.xj.Mapper.UserMapper;
import com.xj.POJO.*;
import com.xj.Service.UserService;
import com.xj.util.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper user;
	@Autowired
	private EmpMapper empmapper;
	@Override
	public User loginByUser(User u) {
		if(u.getPassword()!=null||!"".equals(u.getPassword())){
			u.setPassword(MD5.getMD5(u.getPassword()));
		}
		return user.loginByUser(u);
	}
	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public List<User> getUserList(PageSize pageSize) {
		Integer totolUser = user.totolUser(pageSize);
		pageSize.handledata(totolUser);
		return user.getUserList(pageSize);
	}
	@Override
	public void UserAdd(User u) {
		Date date=new Date();
		u.setCreatedate(date);
		if(u.getPassword()!=null||!"".equals(u.getPassword())){
			u.setPassword(MD5.getMD5(u.getPassword()));
		}
		user.UserAdd(u);
	}
	@Override
	public void updateByUserstatus(User u) {
		user.updateByUserstatus(u);
	}
	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public List<User> getDymicUserStatus() {
		return user.getDymicUserStatus();
	}
	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public User getUserById(Integer id) {
		return user.getUserById(id);
	}
	@Override
	public void updateUser(User u) {
		if(u.getPassword()!=null||!"".equals(u.getPassword())){
			u.setPassword(MD5.getMD5(u.getPassword()));
		}
		user.updateUser(u);
	}
	@Override
	public void deleteUserByList(QueryVo vo) {
		user.deleteUserByList(vo);
	}
	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public boolean checkLoginnameRepeat(String loginname) {
		User u = user.checkLoginnameRepeat(loginname);
		boolean repOrNo=false;
		if(u==null){
			repOrNo=true;
		}
		return repOrNo;
	}
	@Override
	public void GetCheckCode(HttpServletRequest req, HttpServletResponse resp) {
		BufferedImage image=new BufferedImage(80, 30, BufferedImage.TYPE_BYTE_INDEXED);//内存映像对象
		Graphics g=image.getGraphics();//画笔
		Random r=new Random();
		g.setColor(new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255)));//设置画笔颜色
		g.fillRect(0, 0, 80, 30);//填充颜色区域
		String number="";
		for(int i=0;i<5;i++) {
			int h=(int)(18+10*r.nextDouble());
			String cc=getNumber(1);
			g.setColor(new Color(0, 0, 0));//设置字体颜色
			g.setFont(new Font("", Font.LAYOUT_NO_LIMIT_CONTEXT, h));//设置画笔字体(随机大小)
			number+=cc;
			g.drawString(cc, 80/5*i, 25);//加入数字及加入位置
		}
		for(int i=0;i<8;i++) {
			g.drawLine(r.nextInt(80), r.nextInt(30), r.nextInt(80), r.nextInt(30));//画8根干扰线
		}
		resp.setContentType("image/jpeg");//采用图像的压缩格式
		OutputStream os;
		try {
			os = resp.getOutputStream();
			javax.imageio.ImageIO.write(image, "jpeg", os);//输出到前端页面
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		HttpSession session=req.getSession();
		session.setAttribute("checkCode", number);//绑定session对象
	}
	@Override
	public String getNumber(int size) {
		String mus="ABCDEFGHIJKLMNOPQRSJUVWSYZ0123456789";
		Random r=new Random();
		String str="";
		for(int i=0;i<size;i++) {
			str+=mus.charAt(r.nextInt(mus.length()));
		}
		return str;
	}
	@Override
	public List<User> getUserListIdName() {
		return user.getUserListIdName();
	}
	@Override
	public qiandao getSalary(qiandao qq,HttpServletRequest req) {
		User u = (User) req.getSession().getAttribute("username");
		User userById = user.getUserById(u.getId());
		qq.setNowdataString(userById.getCheckNum());
		if(qq.getNowdataString()!=null&&!"".equals(qq.getNowdataString())){
			String[] arr=qq.getNowdataString().split(",");
			qq.setQiandaoNum(arr.length);
		}else{
			qq.setQiandaoNum(0);
		}
		//计算薪水
		Employee checkEmpById = empmapper.CheckEmpById(userById.getEmp_id());
		Integer salaryByMon=checkEmpById.getJob().getSalary();
		Double salaryByDate=(double) (salaryByMon/qq.getCurrentMon());
		qq.setSalary(salaryByDate*qq.getQiandaoNum());
		System.out.println("结束："+qq);
		return qq;
	}
	@Override
	public void UpdateSalary(qiandao qq) {
		user.UpdateSalary(qq);
	}
}
