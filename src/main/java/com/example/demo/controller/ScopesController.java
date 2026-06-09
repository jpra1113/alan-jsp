package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/learning/jsp")
public class ScopesController {

    @Autowired
    private ServletContext context;

    @GetMapping("/scopes")
    public String courseScopes(Model model, HttpSession session) {
        // 1. 設定基礎資料
        model.addAttribute("requestData", "Request 專屬資料 (單次請求有效)");
        session.setAttribute("sessionData", "Session 專屬資料 (瀏覽器關閉前有效)");
        context.setAttribute("applicationData", "Application 專屬資料 (伺服器運行期間有效)");

        // 2. 進階：結構化資料展示 (用於 EL 深度練習)
        model.addAttribute("courseTags", Arrays.asList("JSP", "Servlet", "EL", "JSTL"));
        
        Map<String, String> userInfo = new HashMap<>();
        userInfo.put("level", "高級工程師");
        userInfo.put("region", "台灣");
        session.setAttribute("detailedUser", userInfo);

        // 3. 核心教學：衝突測試 (Conflict Test)
        // 刻意在各作用域放入同名屬性，測試 EL 的尋找順序
        model.addAttribute("conflictVar", "來自 [Request] 的覆蓋");
        session.setAttribute("conflictVar", "來自 [Session] 的覆蓋");
        context.setAttribute("conflictVar", "來自 [Application] 的覆蓋");

        // 4. 系統資訊
        context.setAttribute("serverStartTime", new java.util.Date());

        return "scopes";
    }
}
