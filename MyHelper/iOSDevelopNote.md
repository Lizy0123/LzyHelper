# 学习网上优秀开源项目的练习Demo


//跳转至App Store核心代码
```
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSStristringWithFormat:@"https://itunes.apple.com/cn/app/linkmore/id1095614663?mt=8"]]];
// PS：此处地址为App Store内应用的地址，获取方式--打开iTunes——>应用——>App Store——>搜索“app名称”——>右键APP拷贝链接
```
```
AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
manager.requestSerializer =[AFHTTPRequestSerializer serializer];
manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript",nil];
NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/cn/linkmore?id=%@",STOREAPPID];
[manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

} progress:^(NSProgress * _Nonnull uploadProgress) {
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

NSArray *array = responseObject[@"results"];
NSDictionary *dic = array[0];
NSString *appStoreVersion = dic[@"version"];
//打印版本号
NSLog(@"商店版本号:%@",appStoreVersion);

} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

}];
```
ios label上显示特殊字符 % "

今天在label上显示一个拼接的百分比

label.text = [NSString stringWithFormater:@"%d%",i];

结果后面的%就是报错，然后查半天也不出来，就在群里面问人问出来的。

在不拼接字符串的情况下是可以直接显示的，但是如果在拼接字符串的情况下这样写就会报错。

正确的写法：

label.text = [NSString stringWithFormater:@"%d%%",i];

另外要打印其他特殊字符，只需在前面加上   \

例如：@" \" "
