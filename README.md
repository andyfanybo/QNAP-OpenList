# QNAP-OpenList
基于 QNAP 威联通 NAS 的 OpenList  
OpenList Based on QNAP NAS

## 安装注意事项 Installation Notes

安装前先去【控制台】→【应用程序】→【Web服务器】→【☑️启用Web服务器】，不要更改默认80端口  
Before installation, go to [Control Panel] → [Applications] → [Web Server] → [☑️Enable Web Server], and do not change the default port 80.

## 登录密码 Login Password

生成临时登录密码，默认用户名 admin，进入 NAS 的 ssh  
Generate a temporary login password. The default username is admin. Log in to the NAS via SSH.
```
sudo -i
```
```
cd /share/CACHEDEV1_DATA/.qpkg/OpenList
```
```
./openlist admin random
```

更多 OpenList 教程参阅：https://doc.oplist.org  
For more OpenList tutorials, visit: https://doc.oplist.org

<img width="1900" height="939" alt="image" src="https://github.com/user-attachments/assets/221d59b9-5b7f-4add-998a-c6dc2c535794" />
