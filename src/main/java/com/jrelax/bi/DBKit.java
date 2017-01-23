package com.jrelax.bi;

import com.jrelax.orm.support.Record;
import com.jrelax.orm.support.Records;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 数据库操作工具
 * Created by zengchao on 2017-01-18.
 */
public class DBKit {
    private DataSource dataSource = null;

    public DBKit(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    /**
     * 获取数据库连接
     *
     * @return
     * @throws SQLException
     */
    public Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    /**
     * 关闭resultSet
     *
     * @param statement
     * @param resultSet
     */
    private void close(ResultSet resultSet, Statement statement, Connection connection) {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (statement != null) {
                statement.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void setParams(PreparedStatement statement, Object... params) {
        if (params == null) return;
        for (int i = 1; i <= params.length; i++) {
            try {
                statement.setObject(i, params[i - 1]);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 获取单行数据
     *
     * @param sql
     * @param params
     * @return
     */
    public Record get(String sql, Object... params) {
        Record record = new Record();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            setParams(statement, params);
            rs = statement.executeQuery();

            if (rs.next()) {
                ResultSetMetaData metaData = rs.getMetaData();
                for (int i = 1; i <= metaData.getColumnCount(); i++) {
                    String label = metaData.getColumnLabel(i);
                    record.set(label, rs.getObject(label));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs, statement, connection);
        }
        return record;
    }

    /**
     * 获取单行数据（Map）
     *
     * @param sql
     * @param params
     * @return
     */
    public Map<String, Object> getMap(String sql, Object... params) {
        Map<String, Object> map = new HashMap<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            setParams(statement, params);
            rs = statement.executeQuery();

            if (rs.next()) {
                ResultSetMetaData metaData = rs.getMetaData();
                for (int i = 1; i <= metaData.getColumnCount(); i++) {
                    String label = metaData.getColumnLabel(i);
                    map.put(label, rs.getObject(label));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs, statement, connection);
        }
        return map;
    }

    /**
     * 获取集合数据
     *
     * @param sql
     * @param params
     * @return
     */
    public Records list(String sql, Object... params) {
        Records records = new Records();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            setParams(statement, params);
            rs = statement.executeQuery();

            while (rs.next()) {
                Record record = new Record();
                ResultSetMetaData metaData = rs.getMetaData();
                for (int i = 1; i <= metaData.getColumnCount(); i++) {
                    String label = metaData.getColumnLabel(i);
                    record.set(label, rs.getObject(label));
                }
                records.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs, statement, connection);
        }
        return records;
    }

    /**
     * 获取集合数据
     *
     * @param sql
     * @param params
     * @return
     */
    public List<Map<String, Object>> listToMap(String sql, Object... params) {
        List<Map<String, Object>> list = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            setParams(statement, params);
            rs = statement.executeQuery();

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                ResultSetMetaData metaData = rs.getMetaData();
                for (int i = 1; i <= metaData.getColumnCount(); i++) {
                    String label = metaData.getColumnLabel(i);
                    map.put(label, rs.getObject(label));
                }
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs, statement, connection);
        }
        return list;
    }

    /**
     * 执行更新
     *
     * @param sql
     * @param params
     * @return
     */
    public int execute(String sql, Object... params) {
        int result = -1;
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            setParams(statement, params);
            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(null, statement, connection);
        }
        return result;
    }
}
