package com.example.demo.model;

public class PolicyDetail {
    private Long id;
    private Long policyId;
    private String detailName;
    private String detailValue;

    public PolicyDetail() {}

    public PolicyDetail(Long id, Long policyId, String detailName, String detailValue) {
        this.id = id;
        this.policyId = policyId;
        this.detailName = detailName;
        this.detailValue = detailValue;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPolicyId() {
        return policyId;
    }

    public void setPolicyId(Long policyId) {
        this.policyId = policyId;
    }

    public String getDetailName() {
        return detailName;
    }

    public void setDetailName(String detailName) {
        this.detailName = detailName;
    }

    public String getDetailValue() {
        return detailValue;
    }

    public void setDetailValue(String detailValue) {
        this.detailValue = detailValue;
    }
}
