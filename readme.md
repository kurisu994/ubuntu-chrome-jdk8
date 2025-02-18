## 介绍
ubuntu20.04 + chrome + chromedriver + jdk8的docker镜像

chromedriver默认路径是`/driver`
如需更改需自行调整位置
```Dockerfile
RUN mkdir -p /driver
RUN mv chromedriver /driver/
```
把其中`/driver`修改为想要的路径即可