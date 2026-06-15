package com.example.demo.controller;

import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import com.example.demo.dto.PolicyDTO;
import com.example.demo.mapper.CustomerMapper;
import com.example.demo.mapper.PolicyMapper;
import com.example.demo.model.Customer;
import com.example.demo.model.Policy;
import com.example.demo.service.JasperReportService;

@Controller
@RequestMapping("/jasperReport")
public class JasperReportController {

    private static final Logger logger = LoggerFactory.getLogger(JasperReportController.class);

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

    @GetMapping(value = "/policies", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<PolicyDTO> policies(@RequestParam("customerId") Long customerId) {
        logger.info("Getting policies for customerId: {}", customerId);
        if (customerId == null)
            return new ArrayList<>();
        List<Policy> policies = policyMapper.findByCustomerId(customerId);
        logger.info("Found {} policies", policies.size());
        if (policies.size() > 0) {
            Policy firstPolicy = policies.get(0);
            logger.info(
                    "First policy: policyNumber={}, type={}, sumInsured={}, premiumAmount={}, startDate={}, endDate={}, status={}",
                    firstPolicy.getPolicyNumber(), firstPolicy.getType(), firstPolicy.getSumInsured(),
                    firstPolicy.getPremiumAmount(), firstPolicy.getStartDate(), firstPolicy.getEndDate(),
                    firstPolicy.getStatus());
        }
        List<PolicyDTO> result = policies.stream().map(p -> new PolicyDTO(
                p.getPolicyNumber(),
                p.getType(),
                p.getSumInsured(),
                p.getPremiumAmount(),
                p.getStartDate(),
                p.getEndDate(),
                p.getStatus())).collect(Collectors.toList());
        logger.info("Returning {} DTOs", result.size());
        if (result.size() > 0) {
            PolicyDTO firstDTO = result.get(0);
            logger.info(
                    "First DTO: policyNumber={}, type={}, sumInsured={}, premiumAmount={}, startDate={}, endDate={}, status={}",
                    firstDTO.getPolicyNumber(), firstDTO.getType(), firstDTO.getSumInsured(),
                    firstDTO.getPremiumAmount(), firstDTO.getStartDate(), firstDTO.getEndDate(),
                    firstDTO.getStatus());
        }
        return result;
    }

    @GetMapping("/view")
    public ResponseEntity<byte[]> viewPdf(@RequestParam("customerId") Long customerId) throws Exception {
        List<Policy> policies = policyMapper.findByCustomerId(customerId);
        String title = "Policies for customer " + customerId;
        byte[] pdf = jasperReportService.generatePolicyListPdf(policies, title);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        // Set Content-Disposition to inline so it displays in iframe instead of
        // downloading
        headers.set("Content-Disposition", "inline; filename=\"policy_report.pdf\"");
        return ResponseEntity.ok().headers(headers).body(pdf);
    }

    @GetMapping(value = "/view-embed", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, String> viewPdfEmbed(@RequestParam("customerId") Long customerId) throws Exception {
        List<Policy> policies = policyMapper.findByCustomerId(customerId);
        String title = "Policies for customer " + customerId;
        byte[] pdf = jasperReportService.generatePolicyListPdf(policies, title);

        // Convert PDF to Base64 for embedding in iframe
        String base64Pdf = Base64.getEncoder().encodeToString(pdf);

        Map<String, String> result = new HashMap<>();
        result.put("pdfData", "data:application/pdf;base64," + base64Pdf);
        return result;
    }
}
