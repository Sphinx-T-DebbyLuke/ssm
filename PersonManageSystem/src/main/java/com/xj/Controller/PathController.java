package com.xj.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/Path")
public class PathController {
    @RequestMapping(value = "/{pathUrl}")

    public String toPath(@PathVariable String pathUrl){
        return pathUrl;
    }
}
