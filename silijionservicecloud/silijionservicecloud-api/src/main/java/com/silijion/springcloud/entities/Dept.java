package com.silijion.springcloud.entities;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
*@description 部门实体类
*@author      SiLiJion
*@date        2019/12/5  23:41
*@version     1.0
*/
@NoArgsConstructor
@Data
@Accessors(chain=true)
public class Dept implements Serializable {

    private static final long serialVersionUID = -7480020553374012732L;

    //主键
    private Long  deptno;
    //部门名称
    private String  dname;
    //来自那个数据库，因为微服务架构可以一个服务对应一个数据库，同一个信息被存储到不同数据库
    private String  db_source;


}
