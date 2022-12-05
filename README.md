# ebusiness
e-commerce app
在swift中使用 第三方OC库

No 1, 创建头文件Bridging-Header.h
No 2, 在Bridging-Header.h中引用这个OC的库名
No 3, Build Settings中搜索bridg, 找到Objective-C Bridging Header, 添加 Bridging-Header.h

No 1，
![image](https://user-images.githubusercontent.com/86242993/205653768-aa9a9ca4-dea5-4c56-9a39-5d0c46728679.png)
No 2,
![image](https://user-images.githubusercontent.com/86242993/205654057-d4ff593c-9bb4-4119-a517-10d4bef6c20e.png)
No 3,
![image](https://user-images.githubusercontent.com/86242993/205654170-dd665347-c761-4726-8a7d-524c2a400b96.png)



No 4, 配置完后，OC的方法会被转化成swift的调用方法，我们只需要按照swift的调用方法使用即可
