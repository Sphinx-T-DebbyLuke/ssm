package com.xj.util;

import javax.servlet.http.HttpServletRequest;

public class imageUtil {
    private static String seperator=System.getProperty("file.separator");
    public static String generateThumbnail(String fileName,Integer id, HttpServletRequest req,String headerImgOrDocument){
        String path=req.getServletContext().getRealPath("upload")+seperator;
        if(headerImgOrDocument.equals("headerImg")){
            path+="headimage"+seperator+id+seperator+fileName;
        }else if(headerImgOrDocument.equals("Document")){
            path+="document"+seperator+fileName;
        }
        return path;
    }
}
