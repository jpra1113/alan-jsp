package com.example.demo.mapper;

import com.example.demo.model.PolicyDetail;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface PolicyDetailMapper {
    @Select("SELECT * FROM policy_details WHERE policy_id = #{policyId}")
    List<PolicyDetail> findByPolicyId(@Param("policyId") Long policyId);
}
