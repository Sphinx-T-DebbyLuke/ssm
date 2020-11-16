package com.xj.Controller;

import com.xj.HandleExceptions.MessageException;
import com.xj.POJO.*;
import com.xj.Service.EmpService;
import com.xj.Service.SyslogService;
import com.xj.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping(value = "/User")
public class UserController {
    @Autowired
    private UserService user;
    @Autowired
    private EmpService empservice;
    @Autowired
    private SyslogService logservice;
    //登录
    @RequestMapping(value="/login.action")
    public String loginUser(User u,HttpServletRequest req) throws MessageException {
        String checkCode=u.getUsername();
        Object checkCodeObject = req.getSession().getAttribute("checkCode");
        String ss="";
        if(checkCodeObject!=null){
            String checkCode2 =(String)checkCodeObject;
            if(checkCode.equalsIgnoreCase(checkCode2)){
                User u1=user.loginByUser(u);
                if(u1==null){
                    throw new MessageException("用户名或密码错误!");
                }else{
                    ss="index";
                    req.getSession().setAttribute("username", u1);
                    u1.setUserstatus(2);
                    try {
                        user.updateByUserstatus(u1);
                    }catch (Exception e){
                        throw new MessageException("更新用户状态错误");
                    }
                }
            }else{
                throw new MessageException("验证码错误！");
            }
        }else{
            ss="forward:/login.jsp";
        }
        return ss;
    }
    //用户列表(带有查询和分页功能)
    @RequestMapping(value="/UserList.action",method={RequestMethod.GET,RequestMethod.POST})
    public String UserList(PageSize page, Model model) throws MessageException {
        List<User> userList = user.getUserList(page);
        page.setUserlist(userList);
        model.addAttribute("pageSize", page);
        try {
            List<Employee> getallEmpidOrnameTobind = empservice.getallEmpidOrnameTobind();
            model.addAttribute("allEmpidOrnameList", getallEmpidOrnameTobind);
        }catch (Exception e){
            throw new MessageException("查询用户列表错误!");
        }
        return "User";
    }
    //用户注册
    @RequestMapping(value="/UserRegister.action")
    public @ResponseBody
    String UserRegister(User u){
        u.setUsername("普通用户");
        try {
            user.UserAdd(u);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }
    //添加用户
    @RequestMapping(value="/UserAdd.action")
    public String UserAdd(User u, HttpServletRequest req){
        Syslog syslog=new Syslog("用户管理","添加了["+u.getLoginname()+"]用户");
        try {
            logservice.addSyslog(syslog, req);

            user.UserAdd(u);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/User/UserList.action";
    }
    //退出登录
    @RequestMapping(value="/quitSys.action")
    public String quitSys(HttpServletRequest req){
        User u = (User) req.getSession().getAttribute("username");
        req.getSession().removeAttribute("username");
        u.setUserstatus(1);
        try {
            user.updateByUserstatus(u);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/login.jsp";
    }

    //根据id查询用户
    @RequestMapping(value="/getUserById.action")
    public @ResponseBody User getUserById(Integer id){
        User u=user.getUserById(id);
        return u;
    }
    //修改用户信息
    @RequestMapping(value="/updateUserInfo.action")
    public @ResponseBody String updateUserInfo(User u,HttpServletRequest req){
        Syslog syslog=new Syslog("用户管理","修改了["+u.getLoginname()+"]的用户信息");
        try {
            logservice.addSyslog(syslog, req);
        } catch (Exception e) {
            e.printStackTrace();
        }
        User u2=(User)req.getSession().getAttribute("username");
        if(u.getEmp()!=null){
            if(u.getEmp().getId()!=0){
                Employee empById = empservice.CheckEmpById(u.getEmp().getId());
                u.setEmp_name(empById.getName());
            }else if(u.getEmp().getId()==0){
                u.setEmp_name(null);
            }
        }
        user.updateUser(u);
        if(u.getId()==u2.getId()){
            if(u.getUsername()==null||"".equals(u.getUsername())){
                u.setUsername(u2.getUsername());
            }
            req.getSession().setAttribute("username", u);
        }
        return "success";
    }
    //删除用户信息（可批量删除）
    @RequestMapping(value="/deleteUserInfo.action")
    public String deleteUserInfo(QueryVo vo, HttpServletRequest req){
        String logdetail="";
        for (int i=0;i<vo.getIds().size();i++) {
            User userById = user.getUserById(vo.getIds().get(i));
            if(i==0){
                logdetail+=userById.getLoginname();
            }else{
                logdetail+=","+userById.getLoginname();
            }
        }
        Syslog syslog=new Syslog("用户管理","删除了["+logdetail+"]的用户信息");
        try {
            logservice.addSyslog(syslog,req);

            user.deleteUserByList(vo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/User/UserList.action";
    }
    //查询注册或添加时的登录名是否重复
    @RequestMapping(value="/checkLoginnameRepeat.action")
    public @ResponseBody String checkLoginnameRepeat(String loginname){
        String repOrNo="false";
        boolean repeat = user.checkLoginnameRepeat(loginname);
        if(repeat){
            repOrNo="success";
        }
        return repOrNo;
    }
    //获取验证码
    @RequestMapping(value="/GetCheckCode.action")
    public void GetCheckCode(HttpServletRequest req, HttpServletResponse resp){
        user.GetCheckCode(req, resp);
    }
}
