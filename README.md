# 让Flutter调用图片像Android一样简单

## 1. 添加注解参考res.dart
ImagesPath(fileName="创建的类名",path="资源目录")

## 2. 直接在assets、images添加完资源之后执行
```flutter packages pub run build_runner build --delete-conflicting-outputs```
构建即可生成.g.dart 参考res.g.dart

## 3. 调用参考main.dart
Image.asset(Res.gsws...)

[具体](https://note.youdao.com/s/d9N1AasC):https://note.youdao.com/s/d9N1AasC
