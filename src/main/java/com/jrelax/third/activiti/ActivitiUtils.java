package com.jrelax.third.activiti;

import com.jrelax.kit.ObjectKit;
import com.jrelax.web.system.entity.Role;
import com.jrelax.web.system.entity.User;
import org.activiti.engine.identity.Group;
import org.activiti.engine.impl.persistence.entity.GroupEntity;
import org.activiti.engine.impl.persistence.entity.UserEntity;

import java.util.ArrayList;
import java.util.List;

public class ActivitiUtils {
	
	/**
	 * 系统User转换成Activiti工作流UserEntity
	 * @param user
	 * @return
	 */
	public static UserEntity toActivitiUser(User user){
		if(ObjectKit.isNull(user))
			return null;
		UserEntity ue = new UserEntity();
		ue.setId(user.getId());
		ue.setFirstName(user.getUserName());
		ue.setLastName(user.getRealName());
		ue.setEmail(user.getEmail());
		ue.setPassword(user.getPassword());
		ue.setRevision(1);
		return ue;
	}
	
	/**
	 * 系统Role转换成Activiti工作流Group
	 * @param role
	 * @return
	 */
	public static GroupEntity toActivitiGroup(Role role){
		if(ObjectKit.isNull(role))
			return null;
		GroupEntity ge = new GroupEntity();
		ge.setRevision(1);
		ge.setType("assignment");
		ge.setId(role.getId());
		ge.setName(role.getName());

		return ge;
	}
	
	/**
	 * 系统Role列表转换成Activiti工作流Group列表
	 * @param roles
	 * @return
	 */
	public static List<Group> toActivitiGroupList(List<Role> roles){
		List<Group> groups = new ArrayList<Group>();

		for(Role role : roles){
			if(ObjectKit.isNotNull(role))
				groups.add(toActivitiGroup(role));
		}

		return groups;
	}
}
