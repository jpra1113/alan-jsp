package com.example.demo.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import com.example.demo.model.Customer;
import com.example.demo.model.Policy;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Service
public class JasperReportService {

    public byte[] generateCustomerListPdf(List<Customer> customers, String reportTitle) throws Exception {
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(customers);

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("ReportTitle", reportTitle);

        try (InputStream reportStream = new ClassPathResource("reports/customer_list.jrxml").getInputStream()) {
            JasperReport jasperReport = JasperCompileManager.compileReport(reportStream);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, dataSource);
            return JasperExportManager.exportReportToPdf(jasperPrint);
        }
    }

    public byte[] generatePolicyListPdf(List<Policy> policies, String reportTitle) throws Exception {
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(policies);

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("ReportTitle", reportTitle);

        try (InputStream reportStream = new ClassPathResource("reports/policy_list.jrxml").getInputStream()) {
            JasperReport jasperReport = JasperCompileManager.compileReport(reportStream);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, dataSource);
            return JasperExportManager.exportReportToPdf(jasperPrint);
        }
    }

    /**
     * 新增：編譯主報表與子報表，並返回保單詳細 PDF 報表位元組
     */
    public byte[] generatePolicyDetailsPdf(List<Policy> policies, String reportTitle) throws Exception {
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(policies);

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("ReportTitle", reportTitle);

        try (InputStream subreportStream = new ClassPathResource("reports/policy_details_subreport.jrxml").getInputStream();
             InputStream reportStream = new ClassPathResource("reports/policy_details.jrxml").getInputStream()) {
            
            // Runtime 動態編譯子報表並作為 Parameter 傳入主報表
            JasperReport subReport = JasperCompileManager.compileReport(subreportStream);
            parameters.put("DetailSubreport", subReport);

            // 編譯主報表並填寫數據
            JasperReport mainReport = JasperCompileManager.compileReport(reportStream);
            JasperPrint jasperPrint = JasperFillManager.fillReport(mainReport, parameters, dataSource);
            return JasperExportManager.exportReportToPdf(jasperPrint);
        }
    }

    public String generateAndSavePolicyListPdf(List<Policy> policies, String reportTitle, String outputDir)
            throws Exception {
        byte[] pdfBytes = generatePolicyListPdf(policies, reportTitle);

        Path outputPath = Paths.get(outputDir);
        if (!Files.exists(outputPath)) {
            Files.createDirectories(outputPath);
        }

        String fileName = "policy_report_" + System.currentTimeMillis() + ".pdf";
        File outputFile = new File(outputDir, fileName);

        try (FileOutputStream fos = new FileOutputStream(outputFile)) {
            fos.write(pdfBytes);
        }

        return outputFile.getAbsolutePath();
    }

    public String generateAndSaveCustomerListPdf(List<Customer> customers, String reportTitle, String outputDir)
            throws Exception {
        byte[] pdfBytes = generateCustomerListPdf(customers, reportTitle);

        Path outputPath = Paths.get(outputDir);
        if (!Files.exists(outputPath)) {
            Files.createDirectories(outputPath);
        }

        String fileName = "customer_report_" + System.currentTimeMillis() + ".pdf";
        File outputFile = new File(outputDir, fileName);

        try (FileOutputStream fos = new FileOutputStream(outputFile)) {
            fos.write(pdfBytes);
        }

        return outputFile.getAbsolutePath();
    }
}
