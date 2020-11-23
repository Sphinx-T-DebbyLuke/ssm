package com.xj.interceptors;

import com.xj.HandleExceptions.MessageException;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserInterceptor implements HandlerInterceptor{

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object obj) throws Exception {
		String uri=req.getRequestURI();
		if(!uri.contains("login")){
			if(!uri.contains("UserRegister")&&!uri.contains("quitSys")&&
					!uri.contains("checkLoginnameRepeat")&&!uri.contains("GetCheckCode")){
				Object user=req.getSession().getAttribute("username");
				if(user==null){
					throw new MessageException("用户未登录!");
				}
			}
		}
		return true;
	}

}
