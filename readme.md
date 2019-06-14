# 毕业设计代码
无人机着艇目标跟踪算法实现

原代码来自
[https://github.com/xuduo35/STAPLE](https://github.com/xuduo35/STAPLE)  


# 代码概述
主体使用STAPLE算法进行跟踪，分为数据集测试模式与跟踪模式  
- 在线学习，无需任何训练集
- 在原有STAPLE算法基础上加入了融合参数与在线学习率的自适应，效果有所增加


# 环境配置
1.opencv环境(无需扩展包、cuda包)  
2.arm平台上的NEON（intel对应的是SSE），无需人为配置，一般都是自动配置好的  
若出现error:  
```
error: ‘isnan’ was not declared in this scope
(https://blog.csdn.net/Wistral/article/details/82314912)
```


# 代码使用
```
mkdir build
cd build
cmake ..
make
```




