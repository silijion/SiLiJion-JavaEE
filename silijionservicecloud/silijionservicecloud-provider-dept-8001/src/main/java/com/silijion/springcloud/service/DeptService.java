package com.silijion.springcloud.service;

import com.silijion.springcloud.entities.Dept;

import java.util.List;

/**
*@description 部门service
*@author      SiLiJion
*@date        2019/12/6  0:16
*@version     1.0
*/
public interface DeptService {
    public boolean add(Dept dept);
    public Dept    get(Long id);
    public List<Dept> list();
}
