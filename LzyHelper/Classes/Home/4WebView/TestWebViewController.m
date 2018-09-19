//
//  TestWebViewController.m
//  LzyHelper
//
//  Created by apple on 2018/7/24.
//  Copyright © 2018年 Lzy. All rights reserved.
//

#import "TestWebViewController.h"

@interface TestWebViewController ()<UIWebViewDelegate, UIScrollViewDelegate>{
    UIWebView *_webView;
}
@property (nonatomic, strong) UIView* webBrowserView;
@property (nonatomic, strong) UIWebView* webss;
@property (nonatomic, strong) UIImageView* headerImageView;
@property (nonatomic, strong) UIView* headView;


@property (nonatomic ,strong) UIWebView *urlWebView;

@end

@implementation TestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configWebView1];
}
-(void)configWebView1{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,kScreen_Height)];
    [self.view addSubview:_webView];

    _webView.scrollView.contentInset = UIEdgeInsetsMake(240, 0, 0, 0);
    // 在webView上添加一个imgView 在 imgView上添加一个label
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test.jpg"]];
    view.frame = CGRectMake(0, -240, _webView.frame.size.width, 240);
    [_webView.scrollView addSubview:view];
    
    NSString *pathFile = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:pathFile encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:nil];
}
-(void)configWebView0{
    self.webss = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,kScreen_Height)];
    
    self.webss.delegate= self;
    self.webss.scrollView.delegate = self;
    [self.view addSubview:self.webss];
    
    self.webBrowserView = self.webss.scrollView.subviews[0];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-20, 0, kScreen_Width+40, 200)];
    [self.webss addSubview:self.headerImageView];
    
    
    CGRect frame = self.webBrowserView.frame;
    frame.origin.y = CGRectGetMaxY(self.headerImageView.frame);
    self.webBrowserView.frame = frame;
    [self.webss sendSubviewToBack:self.headerImageView];
    
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    self.headView.backgroundColor = [UIColor blueColor];
    [self.webss.scrollView addSubview:self.headView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.jd.com/"]];
    [self.webss loadRequest:request];//加载网页
}
-(void)configWebView{
    self.urlWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.urlWebView .delegate = self;//设置代理
    self.urlWebView .scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    self.urlWebView .scrollView.bouncesZoom = NO; //不能拖动
    self.urlWebView .dataDetectorTypes = UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]];
    [self.urlWebView loadRequest:request];//加载网页
    [self.view addSubview:self.urlWebView ];
    
    
    
    // ------加载
    [self.urlWebView reload];
    // ------停止加载
    [self.urlWebView stopLoading];
    // ------返回
    [self.urlWebView goBack];
    // ------前进
    [self.urlWebView goForward];
    


}


// ------开始请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
// ------开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
// ------结束加载
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // ------获取当前网页全部图片URL
    NSString *imageUrls = [self.urlWebView stringByEvaluatingJavaScriptFromString:@"var str=new Array();" "$('img').each(function(){str.push($(this).attr('src'));});" "str.join(',');"];
    // ------获取当前网页第一张图片URL
    NSString *firstImageUrl = [self.urlWebView stringByEvaluatingJavaScriptFromString:@"var images = document.getElementsByTagName('img');images[0].src.toString();"];
    // ------获取当前网页title
    NSString *currentTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    // ------获取当前网页URL
    NSString *currentURL = webView.request.URL.absoluteString;
    // ------获取当前网页的html
    NSString *lJs = @"document.documentElement.innerHTML";
    NSString *currentHTML = [webView stringByEvaluatingJavaScriptFromString:lJs];
    // ------网页缩放
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom = 2.0"];
}
// ------请求失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}



@end
