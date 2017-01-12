package com.jrelax.third.activiti;

import org.activiti.engine.impl.interceptor.Session;
import org.activiti.engine.impl.interceptor.SessionFactory;
import org.activiti.engine.impl.persistence.entity.UserEntityManager;
import org.activiti.engine.impl.persistence.entity.UserIdentityManager;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 自定义用户管理工厂
 * @author zengchao
 *
 */
public class CustomUserEntityManagerFactory implements SessionFactory{
	
	@Autowired
	private UserEntityManager userEntityManager;
	
	public void setUserEntityManager(UserEntityManager userEntityManager) {
		this.userEntityManager = userEntityManager;
	}
	public Class<?> getSessionType() {
		return UserIdentityManager.class;
	}

	public Session openSession() {
		return userEntityManager;
	}

}
