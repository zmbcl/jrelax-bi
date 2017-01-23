package com.jrelax.web.bi.service;

import com.jrelax.bi.DBKit;
import com.jrelax.bi.DBPool;
import com.jrelax.kit.ObjectKit;
import com.jrelax.web.bi.entity.BiDatasource;
import com.jrelax.web.bi.entity.BiDatasourceMeta;
import com.jrelax.web.support.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 数据源数据结构
 * Created by zengchao on 2016-12-15.
 */
@Service
public class BiDatasourceMetaService extends BaseService<BiDatasourceMeta>{
    @Autowired
    private BiDatasourceService biDatasourceService;
    @Autowired
    private BiDatasourceParamsService biDatasourceParamsService;

    /**
     * 获取数据源数据结构
     * @param id
     * @return
     */
    public List<BiDatasourceMeta> getMetadataForEntity(String id){
        final List<BiDatasourceMeta> list = new ArrayList<>();
        BiDatasource datasource = biDatasourceService.getById(id);
        if(ObjectKit.isNotNull(datasource)){
            //否则根据sql重新计算
            Map<String, String> paramsMap = biDatasourceParamsService.getParamsForMap(datasource.getId());
            String sql = biDatasourceService.mergeSql(datasource.getSqlCmd(), paramsMap);

            DBKit dbKit = new DBKit(DBPool.getInstance().getDataSource(datasource.getDb()));
            try {
                Connection connection = dbKit.getConnection();
                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery(sql);
                ResultSetMetaData metaData = rs.getMetaData();

                for (int i = 1; i <= metaData.getColumnCount(); i++) {
                    BiDatasourceMeta meta = new BiDatasourceMeta();
                    meta.setDatasource(datasource);
                    meta.setName(metaData.getColumnName(i));
                    meta.setLabel(metaData.getColumnLabel(i));
                    meta.setType(metaData.getColumnClassName(i));
                    list.add(meta);
                }

                rs.close();
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

//            this.baseDao.getSession().doWork(new Work() {
//                @Override
//                public void execute(Connection connection) throws SQLException {
//                    ResultSet rs = connection.createStatement().executeQuery(sql);
//
//                    ResultSetMetaData metaData = rs.getMetaData();
//
//                    for (int i = 1; i <= metaData.getColumnCount(); i++) {
//                        BiDatasourceMeta meta = new BiDatasourceMeta();
//                        meta.setDatasource(datasource);
//                        meta.setName(metaData.getColumnName(i));
//                        meta.setLabel(metaData.getColumnLabel(i));
//                        meta.setType(metaData.getColumnClassName(i));
//                        list.add(meta);
//                    }
//                }
//            });
        }
        return list;
    }
}
