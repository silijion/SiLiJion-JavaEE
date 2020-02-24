package com.qm.silijion;

import cn.itcast.domain.User;
import org.apache.commons.beanutils.BeanUtils;
import org.junit.Test;

import java.lang.reflect.InvocationTargetException;

public class BeanUtilsTest {

    @Test
    public void test(){

        User user = new User();
        try {
            BeanUtils.setProperty(user,"username","silijion");
            System.out.println(user);

            String gender = BeanUtils.getProperty(user, "username");
            System.out.println(gender);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }





    }
}
