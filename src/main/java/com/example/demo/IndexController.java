package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    /**
     * 當訪問 / 或 /index 時，導向 index.jsp
     */
    @GetMapping({"/", "/index"})
    public String index() {
        // 根據 application.properties 設定，會對應到 /WEB-INF/jsp/index.jsp
        return "index";
    }
}
