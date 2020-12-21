package com.xj.HandleExceptions;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserHandleException implements HandlerExceptionResolver{

	@Override
	public ModelAndView resolveException(HttpServletRequest req, HttpServletResponse resp, Object obj,
			Exception e) {
		ModelAndView mv=new ModelAndView();
		if(e instanceof MessageException){
			//已知异常
			MessageException me=(MessageException)e;
			mv.addObject("error",me.getMsg() );
		}else{
			//未知异常
			mv.addObject("error", "网络超时!");
		}
		mv.setViewName("forward:/login.jsp");
		return mv;
	}

}
