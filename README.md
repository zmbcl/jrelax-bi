#JRelax-BI

关于仪表板上不显示图表的问题：
- prefixUrl地址应该设置为http://地址:端口/项目名（项目名可以为空），确保配置的prefix地址可以访问
- 配置文件路径：src/main/resources/resources/application/charts/charts.js
- 如此设置的原因是用于图表的外发，而不限于只能在被系统中显示

运行步骤：
- jrelax-bi.sql导入数据库中（Mysql数据库）
- 修改src/resources/jdbc_mysql.properties 中的jdbc.master中的数据库连接

说明：
* 技术支持：QQ群490249408
* 当前版本号为：1.4
* lib中的jar包已开源，开源地址：http://www.oschina.net/p/jrelax

##版本更新
### V1.4 更新时间 2018-04-19
* 基础框架升级到2.0版本
* 系统管理功能同步更新
* 解决原系统依赖错误问题

### V1.2 更新时间 2017-01-23
* 增加外部数据库连接功能
* 增加虚拟数据源功能（重要更新）
* 报表设计器增加 字体大小、字体颜色、单元格背景色
* 增加条件运算，突出显示符合条件的数据（如：语文分数小于60分的学生标红显示）
* 表单分为1.0和2.0两个版本，两个版本不是升级关系，而是不同的实现方式。  （表单1.0为万能表单，表单2.0为配合工作流使用 后期两个版本分别更新，版本号沿用 1.x和2.x）

### V1.1.1 更新时间 2017-01-12
 * 去除jdbc配置用户名密码加密
 * 自定义报表增加函数计算 sum、avg、count、max

## 功能清单

* 自定义表单
* 数据库管理工具
* 自定义数据源
* 自定义工作流（基于activiti，包含web版本的流程设计器）
* 自定义图表（基于chart.js）
* 自定义表格

## 下一版本计划
* 自定义图表增加钻取功能
* 自定义表单增加动态数据源控件

### 演示地址

* 地址：<http://server2.nethsoft.com:8080/>（已下线）
* 用户名/密码： superadmin 1

### 系统截图
![图片说明](https://static.oschina.net/uploads/space/2016/1209/103549_WQyu_935028.png "1")
![图片说明](https://static.oschina.net/uploads/space/2016/1209/103601_p3Va_935028.png "2")
![图片说明](https://static.oschina.net/uploads/space/2016/1209/103615_PGsb_935028.png "3")

### 如果您觉得此项目对您有价值，给作者赏一杯咖啡钱吧，哈哈哈。
<img src="https://static.oschina.net/uploads/space/2018/0322/152821_Cqkl_935028.png" width='200px' alt="支付宝"/> 
<img src="https://static.oschina.net/uploads/space/2018/0322/152832_GOYV_935028.png" width='200px' alt="微信"/>

### 友情链接

* [zframe](http://www.oschina.net/p/zframe)
* [jrelax](http://www.oschina.net/p/jrelax)