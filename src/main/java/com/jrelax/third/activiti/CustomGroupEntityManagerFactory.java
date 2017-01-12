package com.jrelax.third.activiti;

import org.activiti.engine.impl.interceptor.Session;
import org.activiti.engine.impl.interceptor.SessionFactory;
import org.activiti.engine.impl.persistence.entity.GroupEntityManager;
import org.activiti.engine.impl.persistence.entity.GroupIdentityManager;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 自定义用户组管理工厂
 * @author zengchao
 *
 */
public class CustomGroupEntityManagerFactory implements SessionFactory{
	@Autowired
	private GroupEntityManager groupEntityManager;
	
	public void setGroupEntityManager(GroupEntityManager groupEntityManager) {
		this.groupEntityManager = groupEntityManager;
	}

	public Class<?> getSessionType() {
		return GroupIdentityManager.class;
	}

	public Session openSession() {
		return groupEntityManager;
	}

}
