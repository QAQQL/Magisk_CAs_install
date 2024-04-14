## 使用方法

pem证书转.0

https://slproweb.com/products/Win32OpenSSL.html

```shell
# openssl version
# OpenSSL 1.1.1s  1 Nov 2022

# openssl >= 1.0 执行
openssl x509 -inform PEM -subject_hash_old -in xxxx.pem

# openssl < 1.0 执行
openssl x509 -inform PEM -subject_hash -in xxxx.pem


# 或使用 pem_2_0.bat 脚本
.\others\pem_2_0.bat 你的pem文件
# 或直接拖动pem文件到bat上
```

使用7zip打包,并安装该zip为模块,重启生效

```bash
cd Magisk_CAs_install
del ./Magisk_CAs_install.zip
.\others\7z.exe a -aoa -y -xr!".git" -xr!"README.md" -xr!"others" ./Magisk_CAs_install.zip *

# 或使用 pack_zip.bat 脚本
.\others\pack_zip.bat
```
