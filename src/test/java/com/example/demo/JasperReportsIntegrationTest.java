package com.example.demo;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.File;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.demo.model.Customer;
import com.example.demo.service.JasperReportService;

@SpringBootTest
class JasperReportsIntegrationTest {

    @Autowired
    private JasperReportService jasperReportService;

    @Test
    void shouldGenerateCustomerReportPdf() throws Exception {
        List<Customer> customers = List.of(
                new Customer(1L, "Alice", 30, 1200.0),
                new Customer(2L, "Bob", 28, 950.0),
                new Customer(3L, "Charlie", 45, 2200.0));

        byte[] pdfBytes = jasperReportService.generateCustomerListPdf(customers, "Customer List Report");

        assertThat(pdfBytes).isNotNull();
        assertThat(pdfBytes).isNotEmpty();
    }

    @Test
    void shouldGenerateAndSaveCustomerReportPdfToFile() throws Exception {
        List<Customer> customers = List.of(
                new Customer(1L, "Alice", 30, 1200.0),
                new Customer(2L, "Bob", 28, 950.0),
                new Customer(3L, "Charlie", 45, 2200.0),
                new Customer(4L, "Diana", 35, 1800.0),
                new Customer(5L, "Eve", 42, 2100.0));

        String outputDir = "reports";
        String outputPath = jasperReportService.generateAndSaveCustomerListPdf(customers, "Customer List Report",
                outputDir);

        File pdfFile = new File(outputPath);
        assertThat(pdfFile).exists();
        assertThat(pdfFile.length()).isGreaterThan(0);

        System.out.println("✅ PDF generated successfully: " + outputPath);
    }
}
