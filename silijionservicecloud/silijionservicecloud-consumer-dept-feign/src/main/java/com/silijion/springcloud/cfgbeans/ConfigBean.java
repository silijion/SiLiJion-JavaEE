package com.silijion.springcloud.cfgbeans;

import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

/**
*@description 配置类
*@author      SiLiJion
*@date        2019/12/6  0:27
*@version     1.0
*/
@Configuration
public class ConfigBean {

    /**
     * RestTemplate提供了多种便捷访问远程Http服务的方法，
     * 是一种简单便捷的访问restful服务模板类，是Spring提供的用于访问Rest服务的客户端模板工具集
     * @return
     */
    @Bean
    @LoadBalanced  //获得Rest时加入Ribbon的配置 用于ribbon负载均衡
    public RestTemplate getRestTemplate()
    {
        return new RestTemplate();
    }



}
