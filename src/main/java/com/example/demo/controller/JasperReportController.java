package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.mapper.CustomerMapper;
import com.example.demo.mapper.PolicyMapper;
import com.example.demo.model.Customer;
import com.example.demo.model.Policy;
import com.example.demo.service.JasperReportService;

@Controller
@RequestMapping("/jasperReport")
public class JasperReportController {

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private PolicyMapper policyMapper;

    @Autowired
    private JasperReportService jasperReportService;

    @GetMapping
    public String index(@RequestParam(name = "name", defaultValue = "") String name,
            @RequestParam(name = "page", defaultValue = "1") int page,
            Model model) {
        int pageSize = 10;
        int offset = (page - 1) * pageSize;

        long totalRecords = customerMapper.countByName(name == null ? "" : name);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        if (totalPages == 0)
            totalPages = 1;

        List<Customer> customers = customerMapper.findByNamePaged(name, pageSize, offset);

        model.addAttribute("customers", customers);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalRecords", totalRecords);
        model.addAttribute("searchName", name);

        return "jasperReport";
    }

    @GetMapping("/policies")
    @ResponseBody
    public List<Policy> policies(@RequestParam("customerId") Long customerId) {
        if (customerId == null)
            return new ArrayList<>();
        return policyMapper.findByCustomerId(customerId);
    }

    @GetMapping("/view")
    public ResponseEntity<byte[]> viewPdf(@RequestParam("customerId") Long customerId) throws Exception {
        List<Policy> policies = policyMapper.findByCustomerId(customerId);
        String title = "Policies for customer " + customerId;
        byte[] pdf = jasperReportService.generatePolicyListPdf(policies, title);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDispositionFormData("inline", "policy_report.pdf");
        return ResponseEntity.ok().headers(headers).body(pdf);
    }
}
