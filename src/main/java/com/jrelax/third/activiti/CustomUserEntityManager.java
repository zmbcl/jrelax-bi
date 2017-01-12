package com.jrelax.third.activiti;

import com.jrelax.kit.ObjectKit;
import com.jrelax.kit.StringKit;
import com.jrelax.orm.dao.ILazyInitializer;
import com.jrelax.web.system.entity.Role;
import com.jrelax.web.system.service.UserService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.Page;
import org.activiti.engine.impl.UserQueryImpl;
import org.activiti.engine.impl.persistence.entity.GroupEntity;
import org.activiti.engine.impl.persistence.entity.IdentityInfoEntity;
import org.activiti.engine.impl.persistence.entity.UserEntityManager;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class CustomUserEntityManager extends UserEntityManager{
	@Autowired
	private UserService userService;
	@Override
	public User findUserById(String userId) {
		if(StringKit.isEmpty(userId))
			return null;
		com.jrelax.web.system.entity.User u = userService.getById(userId);
		User user = ActivitiUtils.toActivitiUser(u);
		return user;
	}
	
	@Override
	public List<Group> findGroupsByUser(String userId) {
		List<Group> groups = new ArrayList<Group>();
		userService.setLazyInitializer(user -> Hibernate.initialize(user.getRoles()));
		List<Role> roles = userService.getById(userId).getRoles();
		for(Role role : roles){
			GroupEntity ge = ActivitiUtils.toActivitiGroup(role);
			if(ObjectKit.isNotNull(ge))
				groups.add(ge);
		}
		return groups;
	}
	
	@Override
	public List<User> findUserByQueryCriteria(UserQueryImpl query, Page page) {
		throw new RuntimeException("not implement method.");
	}
	@Override
	public IdentityInfoEntity findUserInfoByUserIdAndKey(String userId,
			String key) {
		throw new RuntimeException("not implement method.");
	}
	@Override
	public List<String> findUserInfoKeysByUserIdAndType(String userId,
			String type) {
		throw new RuntimeException("not implement method.");
	}
	@Override
	public List<User> findPotentialStarterUsers(String proceDefId) {
		throw new RuntimeException("not implement method.");
	}
	@Override
	public List<User> findUsersByNativeQuery(Map<String, Object> parameterMap,
			int firstResult, int maxResults) {
		throw new RuntimeException("not implement method.");
	}
	@Override
	public long findUserCountByQueryCriteria(UserQueryImpl query) {
		throw new RuntimeException("not implement method.");
	}
	@Override
	public long findUserCountByNativeQuery(Map<String, Object> parameterMap) {
		throw new RuntimeException("not implement method.");
	}
}
