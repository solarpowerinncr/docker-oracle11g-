## Oracle Database 11.2.0.4 Docker Image
基于[官方Dockerfile](https://github.com/oracle/docker-images/tree/master/OracleDatabase)修改而成
参考：https://github.com/woqutech/docker-images/tree/master/Oracle/11.2.0.4

- ONLINE REDO LOG自动调整为1G大小
- 设置用户名密码永不过期
- 关闭Concurrent Statistics Gathering功能
- TEMP表空间设置为30G大小
- SYSTEM表空间设置为1G大小
- SYSAUX表空间设置为1G大小
- UNDO表空间设置为10G大小


### Image构建

```
1. 下载本目录的所有文件
2. 下载11.2.0.4 Patchset：p13390677_112040_Linux-x86-64_1of7.zip p13390677_112040_Linux-x86-64_2of7.zip
3. 执行构建命令：
	docker build -t oracle/database:11.2.0.4-ee .
```
文件说明：

- Dockerfile：构建Image文件
- checkSpace.sh：安装前检查系统可用空间
- setupLinuxEnv.sh：配置安装环境，创建所需用户和目录
- installDBBinaries.sh：安装11gR2脚本
- db_inst.rsp：静默安装的响应文件
- checkDBStatus.sh：检查数据库状态
- runOracle.sh：启动程序
- startDB.sh：启动已存在数据库
- createDB.sh：创建并初始化新数据库
- dbca.rsp.tmpl：静默创建数据库的响应文件


### Image使用举例

```
docker run -d --name oracledb \
-p 1521:1521 \
-e ORACLE_SID=orcl \
-e ORACLE_PWD=oracle \
-e ORACLE_CHARACTERSET=AL32UTF8 \
-e SGA_SIZE=8G \
-e PGA_SIZE=8G \
-e ENABLE_ARCH=true \
-v /home/sherry/oradata:/opt/oracle/oradata \
oracle/database:11.2.0.4-ee
```
参数说明：
- ORACLE_SID：数据库名
- ORACLE_PWD：数据库密码
- ORACLE_CHARACTERSET：编码方式
- SGA_SIZE：SGA大小
- PGA_SIZE：PGA大小(官方image指定的是固定的内存大小，如需修改，需要在数据库创建之后手动调整)
- ENABLE_ARCH：是否开启归档
- -v /home/oracle/oradata:/opt/oracle/oradata：挂载主机目录

### docker-compose.yml
```
version: '2'

services:
  database:
    image: oracle/database:11.2.0.4-ee
    environment:
      - ORACLE_SID=orcl
      - ORACLE_PWD=oracle
      - ORACLE_CHARACTERSET=AL32UTF8
      - SGA_SIZE=8G
      - PGA_SIZE=8G
      - ENABLE_ARCH=true      
    volumes:
      - /home/oracle/oradata:/opt/oracle/oradata
    ports:
      - 1521:1521
```