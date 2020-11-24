package com.xj.util;

import com.xj.HandleExceptions.MessageException;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

public class EncryptPropertyPlaceHolderConfigurer extends PropertyPlaceholderConfigurer {
    //需要加密的字段数组
    private String[] encryptPropNames={"mysql.username","mysql.password"};

    //对关键的属性进行转换
    protected String convertProperty(String propertyName,String propertyValue){
        if(isEncryProperty(propertyName)){
            //对已加密的字段进行解密工作
            String decryptValue= null;
            try {
                decryptValue = DESUtil.getDecryptString(propertyValue);
            } catch (MessageException e) {
                throw new RuntimeException("解密失败!");
            }
            return decryptValue;
        }else{
            //没有加密则直接返回值
            return propertyValue;
        }
    }
    //判断该属性是否已经加密
    private boolean isEncryProperty(String propertyName){
        //若等于需要加密的field,则进行加密
        for(String encryPropertyName : encryptPropNames){
            if(encryPropertyName.equals(propertyName)){
                return true;
            }
        }
        return false;
    }
}
