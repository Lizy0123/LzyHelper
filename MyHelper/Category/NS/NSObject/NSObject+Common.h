//
//  NSObject+Common.h
//  LzyHelper
//
//  Created by Lzy on 2017/11/10.
//  Copyright © 2017年 Lzy. All rights reserved.
//
#define kPath_ImageCache @"ImageCache"
#define kPath_ResponseCache @"ResponseCache"
#define kKeyWindow [UIApplication sharedApplication].keyWindow

#import <Foundation/Foundation.h>

@interface NSObject (Common)
#pragma mark - 判断
+(BOOL)isNull:(id)value;
+(BOOL)isDictionary:(id)dic;/*判断是否是字典*/
+(BOOL)isArray:(id)array;/*判断是否是数组*/
+(BOOL)isArrayEmpty:(NSArray *)array;
+(BOOL)isString:(id)str;/*判断是否是字符串*/
+(BOOL)isMobileNumber:(NSString *)mobileNum;
+(BOOL)isMobileNum:(NSString *)mobNum;/*判断是否是手机号*/
+(BOOL)isEmailAddress:(NSString *)email;
+(BOOL)isTelNumber:(NSString *)number;
+(BOOL)isIdentityCardNumber: (NSString *)identityCard;


+(BOOL)isNumber:(NSString *)str;
+(BOOL)isInt:(id)str;
+(BOOL)isFloat:(id)str;




#pragma mark - 样式
+(NSString *)moneyStyle:(NSString *)money;
+(UIView *)lineViewWithFrame:(CGRect)rect color:(UIColor *)color;
+(NSString *)currentDateString;/** 获取当前的时间 */
+(NSString *)formateTimeString:(NSString *)timeStr;
+(NSString *)revertTimeString:(NSString *)timeStr;
+(int)compareDateStr:(NSString*)date01 withDateStr:(NSString*)date02;
+(NSMutableAttributedString *)attributedStr:(NSString *)str color:(UIColor *)color length:(NSInteger)strLength;

#pragma mark - 工具
+(void)archiverWithSomeThing:(id)someThing someName:(NSString *)name;
+(id)unarchiverWithName:(NSString *)name;
+(void)serveCategory;





#pragma mark - 提示
#pragma mark Toast
+(void)ToastActivityShow;
+(void)ToastActivityHide;
+(void)ToastShowStr:(NSString *)str;
+(void)ToastShowStr:(NSString *)str during:(CGFloat)during;
+(void)ToastShowCustomeStr:(NSString *)str during:(CGFloat)during;
+(void)ToastHide;
+(void)ToastHideAll;

#pragma mark MBProgressHUD
+ (void)HUDShowStr:(NSString *)tipStr;
+ (id)HUDActivityShowStr:(NSString *)titleStr;
+ (NSUInteger)HUDActivityHide;
#pragma mark Tip M

+ (void)showHudTipStr:(NSString *)tipStr;
+ (instancetype)showHUDQueryStr:(NSString *)titleStr;
+ (NSUInteger)hideHUDQuery;
+ (void)showStatusBarQueryStr:(NSString *)tipStr;
+ (void)showStr:(NSString *)tipStr;
+ (void)showStatusBarErrorStr:(NSString *)errorStr;







#pragma mark File M
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName;
//创建缓存文件夹
+ (BOOL)createDirInCache:(NSString *)dirName;

//图片
+ (BOOL)saveImage:(UIImage *)image imageName:(NSString *)imageName inFolder:(NSString *)folderName;
+ (NSData*)loadImageDataWithName:( NSString *)imageName inFolder:(NSString *)folderName;
+ (BOOL)deleteImageCacheInFolder:(NSString *)folderName;
+ (BOOL)deleteResponseCache;
+ (NSUInteger)getResponseCacheSize;



//网络请求
+ (BOOL)isSave:(BOOL)isSave responseData:(NSDictionary *)data toPath:(NSString *)requestPath;//缓存请求回来的json对象
+ (id)canLoad:(BOOL)canLoad loadResponseWithPath:(NSString *)requestPath;//返回一个NSDictionary类型的json数据
+ (BOOL)haveFiel:(BOOL)haveFiel deleteResponseCacheForPath:(NSString *)requestPath;


/**
 获取倒计时

 @param button 倒计时按钮
 */
+(void)startTime:(UIButton*)button;
+ (NSString *)formateTime:(NSString *)time;
+ (NSString *)formateTimeYM:(NSString *)time;
@end
