package com.jrelax.ext.plugins;

import com.jrelax.bi.DBPool;
import com.jrelax.core.plugin.IPlugin;
import com.jrelax.core.plugin.annotation.Plugin;
import com.jrelax.orm.datasource.DataSourceSwitcher;
import com.jrelax.web.bi.entity.BiDatabase;
import com.jrelax.web.bi.service.BiDatabaseService;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.SessionFactoryUtils;

import javax.sql.DataSource;
import java.beans.PropertyVetoException;
import java.util.List;

/**
 * 初始化系统中设置的数据库连接
 * Created by zengchao on 2017-01-18.
 */
@Plugin(value="BI数据库初始化", loadOnStartup = true)
public class DBPoolPlugin implements IPlugin{
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private BiDatabaseService databaseService;
    @Override
    public boolean init() {
        //将当前系统的数据源放入池中
        DataSourceSwitcher sourceSwitcher = (DataSourceSwitcher) SessionFactoryUtils.getDataSource(databaseService.getBaseDao().getSessionFactory());
        DBPool.getInstance().create("local", sourceSwitcher.getDataSource());
        //添加数据汇集/交换数据库
        try {
            DBPool.getInstance().create("BIExchange", "org.h2.Driver", "jdbc:h2:mem:bi", "", "");
        } catch (PropertyVetoException e) {
            e.printStackTrace();
        }
        //获取数据库中定义的数据源
        List<BiDatabase> list = databaseService.listAll();
        for(BiDatabase database : list){
            try {
                DBPool.getInstance().create(database.getId(), database.getDriver(), database.getUrl(), database.getUsername(), database.getPassword());
            } catch (PropertyVetoException e) {
                logger.error("【"+database.getName()+"】数据库连接失败");
            }
        }
        logger.info("BI数据库初始化完成，当前数量："+DBPool.getInstance().size());
        return true;
    }

    @Override
    public void destroy() {
        DBPool.getInstance().destroyAll();
        logger.info("BI数据库已释放");
    }
}
