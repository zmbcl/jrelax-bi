package com.jrelax.third.activiti;

import com.jrelax.kit.ObjectKit;
import com.jrelax.orm.dao.ILazyInitializer;
import com.jrelax.web.system.entity.Role;
import com.jrelax.web.system.entity.User;
import com.jrelax.web.system.service.UserService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.GroupQuery;
import org.activiti.engine.impl.GroupQueryImpl;
import org.activiti.engine.impl.Page;
import org.activiti.engine.impl.persistence.entity.GroupEntity;
import org.activiti.engine.impl.persistence.entity.GroupEntityManager;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 自定义Activiti用户组管理器
 * @author zengchao
 *
 */
@Service
public class CustomGroupEntityManager extends GroupEntityManager{
	
	@Autowired
	private UserService userService;
	
	@Override
	public Group createNewGroup(String groupId) {
		return super.createNewGroup(groupId);
	}
	@Override
	public void insertGroup(Group group) {
		super.insertGroup(group);
	}
	@Override
	public void updateGroup(Group updatedGroup) {
		super.updateGroup(updatedGroup);
	}
	@Override
	public void deleteGroup(String groupId) {
		super.deleteGroup(groupId);
	}
	@Override
	public GroupQuery createNewGroupQuery() {
		return super.createNewGroupQuery();
	}
	
	@Override
	public List<Group> findGroupByQueryCriteria(GroupQueryImpl query, Page page) {
		throw new RuntimeException("not implement method.");
	}
	@Override
	public long findGroupCountByNativeQuery(Map<String, Object> parameterMap) {
		throw new RuntimeException("not implement method.");
	}
	@Override
	public long findGroupCountByQueryCriteria(GroupQueryImpl query) {
		throw new RuntimeException("not implement method.");
	}
	@Override
	public List<Group> findGroupsByNativeQuery(
			Map<String, Object> parameterMap, int firstResult, int maxResults) {
		throw new RuntimeException("not implement method.");
	}
	/**
	 * 根据用户查找用户组
	 */
	@Override
	public List<Group> findGroupsByUser(String userId) {
		List<Group> groups = new ArrayList<Group>();
		userService.setLazyInitializer(user -> Hibernate.initialize(user.getRoles()));
		User user = userService.getById(userId);
		if(ObjectKit.isNotNull(user)){
			List<Role> roles = user.getRoles();
			for(Role role : roles){
				GroupEntity ge = ActivitiUtils.toActivitiGroup(role);

				groups.add(ge);
			}
		}
		return groups;
	}
}
