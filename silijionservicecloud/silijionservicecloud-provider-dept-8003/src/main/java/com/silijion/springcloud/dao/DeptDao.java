package com.silijion.springcloud.dao;

import com.silijion.springcloud.entities.Dept;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
*@description 部门查询dao
*@author      SiLiJion
*@date        2019/12/6  0:14
*@version     1.0
*/
@Mapper
public interface DeptDao {
    public boolean addDept(Dept dept);

    public Dept findById(Long id);

    public List<Dept> findAll();
}
