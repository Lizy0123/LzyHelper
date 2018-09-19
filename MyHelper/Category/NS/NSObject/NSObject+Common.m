//
//  NSObject+Common.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/10.
//  Copyright © 2017年 Lzy. All rights reserved.
//
#define kPath_ImageCache @"ImageCache"
#define kPath_ResponseCache @"ResponseCache"
#define kHUDQueryViewTag 101
#import "NSObject+Common.h"
//#import "JDStatusBarNotification.h"
//#import "YLAppDelegate.h"
#import "MBProgressHUD+Add.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"
#import "Helper.h"

@implementation NSObject (Common)
#pragma mark - 判断
+(BOOL)isNull:(id)value{
    if (!value) return YES;
    if ([value isKindOfClass:[NSNull class]]) return YES;
    return NO;
}
+(BOOL)isDictionary:(id)dic{
    if (!dic) {
        return NO;
    }
    if ((NSNull *)dic == [NSNull null]) {
        return NO;
    }
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    if ([dic count] <= 0) {
        return NO;
    }
    return YES;
}
+ (BOOL)isArray:(id)array{
    if (!array) {
        return NO;
    }
    if ((NSNull *)array == [NSNull null]) {
        return NO;
    }
    if (![array isKindOfClass:[NSArray class]]) {
        return NO;
    }
    if ([array count] <= 0) {
        return NO;
    }
    if (array == nil) {
        NO;
    }
    return YES;
}
+(BOOL)isArrayEmpty:(NSArray *)array
{
    return (array == nil || [array count] == 0);
}

+(BOOL)isString:(id)str{
    if (!str) {
        return NO;
    }
    if ((NSNull *)str == [NSNull null]) {
        return NO;
    }
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([str isEqualToString:@""]) {
        return NO;
    }
    if (((NSString *)str).length == 0) {
        return NO;
    }
    if ([str isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([str isEqualToString:@"<null>"]) {
        return NO;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return YES;
}
#pragma 手机号判断
//+(BOOL)isMobileNum:(NSString *)mobNum{
//    //    电信号段:133/149/153/173/177/180/181/189
//    //    联通号段:130/131/132/145/155/156/171/175/176/185/186
//    //    移动号段:134/135/136/137/138/139/147/150/151/152/157/158/159/178/182/183/184/187/188
//    //    虚拟运营商:170
//
//    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|7[0135-8]|8[0-9])\\d{8}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    return [regextestmobile evaluateWithObject:mobNum];
//}
//判断手机号码格式是否正确
+(BOOL)isMobileNum:(NSString *)mobNum{
    mobNum = [mobNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobNum.length != 11){
        return NO;
    }else{
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8])|(198))\\d{8}|(1705)\\d{7}$";/*** 移动号段正则表达式*/
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6])|(166))\\d{8}|(1709)\\d{7}$";/*** 联通号段正则表达式*/
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9])|(199))\\d{8}$";/*** 电信号段正则表达式*/
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobNum];
        
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobNum];
        
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobNum];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum{
    /** * 手机号码 * 移动:134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188 * 联通:130,131,132,152,155,156,185,186 * 电信:133,1349,153,177,180,189  *大陆地区固话及小灵通:区号:010,020,021,022,023,024,025,027,028,029号码:七位或八位*/
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])//d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])//d)//d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])//d{8}$";
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)//d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|//d{3})//d{7,8}$";/**验证固话的谓词.*/
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    BOOL isMatch1 = [regextestmobile evaluateWithObject:cellNum];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    BOOL isMatch2 = [regextestcm evaluateWithObject:cellNum];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    BOOL isMatch4 = [regextestcu evaluateWithObject:cellNum];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT]; //
    BOOL isMatch3 = [regextestct evaluateWithObject:cellNum];
    
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    BOOL isMatch5 = [regextestPHS evaluateWithObject:cellNum];
    
    if(isMatch1|| isMatch2 || isMatch3 || isMatch4){
        return YES;
    }else{
        return NO;
    }
}
+ (BOOL)isNumber:(NSString *)str {
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(str.length > 0) {
        return NO;
    }
    return YES;
}

+(BOOL)isInt:(id)str{
    NSScanner* scan = [NSScanner scannerWithString:str];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
+(BOOL)isFloat:(id)str{
    NSScanner* scan = [NSScanner scannerWithString:str];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,186,183
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSString * CS = @"^1((77|78|79|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestcs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CS];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestcs evaluateWithObject:mobileNum] == YES))
    {
        if([regextestcm evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else{
        return NO;
    }
}

+ (BOOL)isIdentityCardNumber: (NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


+ (BOOL)isValidateRegularExpression:(NSString *)strDestination byExpression:(NSString *)strExpression{
    NSPredicate  *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    return [predicate evaluateWithObject:strDestination];
}


+ (BOOL)isTelNumber:(NSString *)number{
    NSString *strRegex = @"[0-9]{1,20}";
    BOOL rt = [[self class] isValidateRegularExpression:number byExpression:strRegex];
    return rt;
}

+ (BOOL)isEmailAddress:(NSString *)email{
    NSString *strRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}";
    BOOL rt = [[self class] isValidateRegularExpression:email byExpression:strRegex];
    return rt;
}






#pragma mark - 样式
+(NSString *)moneyStyle:(NSString *)money{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *numTemp = [numberFormatter numberFromString:money];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle =NSNumberFormatterCurrencyStyle;
    formatter.locale= [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    return [formatter stringFromNumber:numTemp];
}
+(UIView *)lineViewWithFrame:(CGRect)rect color:(UIColor *)color{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    if (!color) {
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else{
        view.backgroundColor = color;
    }
    return view;
}
#pragma mark 获取当前的时间
+ (NSString *)currentDateString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark 按指定格式获取当前的时间
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr {
    // 获取系统当前时间
    NSDate *currentDate = [NSDate date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}
+(NSString *)formateTimeString:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterFullStyle];// 修改下面提到的北京时间的日期格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];//
    
    NSDate *date = [formatter dateFromString:timeStr];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// 此行代码与上面两行作用一样，故上面两行代码失效
    NSString *currentDateString = [formatter stringFromDate:date];
    return currentDateString;
}
+(NSString *)revertTimeString:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterFullStyle];// 修改下面提到的北京时间的日期格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//
    
    NSDate *date = [formatter dateFromString:timeStr];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];// 此行代码与上面两行作用一样，故上面两行代码失效
    NSString *currentDateString = [formatter stringFromDate:date];
    return currentDateString;
}

+(int)compareDateStr:(NSString*)date01 withDateStr:(NSString*)date02{
    int ci;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [dateFormater dateFromString:date01];
    date2 = [dateFormater dateFromString:date02];
    NSComparisonResult result = [date1 compare:date2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", date2, date1); break;
    }
    return ci;
}

+(NSMutableAttributedString *)attributedStr:(NSString *)str color:(UIColor *)color length:(NSInteger)strLength{
    NSMutableAttributedString *countString = [[NSMutableAttributedString alloc] initWithString:str];
    [countString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(strLength,str.length-strLength)];
    return countString;
}

#pragma mark - 工具
+(void)archiverWithSomeThing:(id)someThing someName:(NSString *)name{
    // 创建归档时所需的data 对象.
    NSMutableData *data = [NSMutableData data];
    // 归档类.
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 开始归档（@"model" 是key值，也就是通过这个标识来找到写入的对象）.
    [archiver encodeObject:someThing forKey:name];
    // 归档结束.
    [archiver finishEncoding];
    // 写入本地（@"weather" 是写入的文件名）.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name];
    [data writeToFile:file atomically:YES];
}
+(id)unarchiverWithName:(NSString *)name{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:[NSData dataWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]]];
    id someThing = [unarchiver decodeObjectForKey:name];
    [unarchiver finishDecoding];
    return someThing;
}
+(void)serveCategory{
    //    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetFirstListId] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        NSLog(@"LzyresponseObject---%@",responseObject);
    //        if ([responseObject[@"code"] intValue] == 200) {
    //            NSArray *arr = [ProductCategoryModel arrayOfModelsFromDictionaries:responseObject[@"object"] error:nil];
    //            [Helper archiverWithSomeThing:arr someName:kProductCategoryCache];
    //        }
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //    }];
}






#pragma mark - 提示
#pragma mark Toast
+(void)ToastActivityShow{
    [kKeyWindow makeToastActivity:CSToastPositionCenter];
}
+(void)ToastActivityHide{
    [kKeyWindow hideToastActivity];
}
+(void)ToastShowStr:(NSString *)str{
    if (str.length>40) {
        [Helper ToastShowStr:str during:2.0f];
    }else{
        [Helper ToastShowCustomeStr:str during:2.0f];
    }
}
+(void)ToastShowStr:(NSString *)str during:(CGFloat)during{
    [kKeyWindow makeToast:str
                 duration:during
                 position:CSToastPositionCenter
                    title:nil
                    image:nil
                    style:nil
               completion:nil];
}
+(void)ToastShowCustomeStr:(NSString *)str during:(CGFloat)during{
    // Show a custom view as toast
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 120)];
    customView.cornerRadius = 10;
    customView.layer.masksToBounds = YES;
    customView.opaque = YES;
    customView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    
    [customView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)]; // autoresizing masks are respected on custom views
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(customView.frame) + 20, CGRectGetMinY(customView.frame) + 20, CGRectGetWidth(customView.frame) - 20*2, CGRectGetHeight(customView.frame) - 20*2)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.numberOfLines = 0;
    label.text = str;
    [customView addSubview:label];
    
    [kKeyWindow showToast:customView
                 duration:during
                 position:CSToastPositionCenter
               completion:nil];
}
+(void)ToastHide{
    [kKeyWindow hideToast];
}
+(void)ToastHideAll{
    [kKeyWindow hideAllToasts];
}




#pragma mark MBProgressHUD
+ (void)HUDShowStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabelText = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
    }
}
+ (id)HUDActivityShowStr:(NSString *)titleStr{
    titleStr = titleStr.length > 0? titleStr: @"正在加载...";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.tag = kHUDQueryViewTag;
    hud.labelText = titleStr;
    hud.labelFont = [UIFont boldSystemFontOfSize:15.0];
    hud.margin = 10.f;
    return hud;
}
+ (NSUInteger)HUDActivityHide{
    __block NSUInteger count = 0;
    NSArray *huds = [MBProgressHUD allHUDsForView:kKeyWindow];
    [huds enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if (obj.tag == kHUDQueryViewTag) {
            [obj removeFromSuperview];
            count++;
        }
    }];
    return count;
}




#pragma mark Tip M

+ (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabelText = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
    }
}
+ (instancetype)showHUDQueryStr:(NSString *)titleStr{
    titleStr = titleStr.length > 0? titleStr: @"正在加载...";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.tag = kHUDQueryViewTag;
    hud.labelText = titleStr;
    hud.labelFont = [UIFont boldSystemFontOfSize:15.0];
    hud.margin = 10.f;
    return hud;
}
+ (NSUInteger)hideHUDQuery{
    __block NSUInteger count = 0;
    NSArray *huds = [MBProgressHUD allHUDsForView:kKeyWindow];
    [huds enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if (obj.tag == kHUDQueryViewTag) {
            [obj removeFromSuperview];
            count++;
        }
    }];
    return count;
}
+ (void)showStatusBarQueryStr:(NSString *)tipStr{
    //    [JDStatusBarNotification showWithStatus:tipStr styleName:JDStatusBarStyleSuccess];
    //    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleWhite];
}
+ (void)showStr:(NSString *)tipStr{
    
    //    FFToast *toast = [[FFToast alloc]initToastWithTitle:nil message:tipStr iconImage:nil];
    //    toast.toastType = FFToastTypeDefault;
    //    toast.toastPosition = FFToastPositionBottomWithFillet;
    //    [toast show];
    
    // Make toast with an image, title, and completion block
    [[UIApplication sharedApplication].keyWindow makeToast:tipStr
                                                  duration:2.0
                                                  position:CSToastPositionCenter
                                                     title:nil
                                                     image:nil
                                                     style:nil
                                                completion:^(BOOL didTap) {
                                                    if (didTap) {
                                                        NSLog(@"completion from tap");
                                                    } else {
                                                        NSLog(@"completion without tap");
                                                    }
                                                }];
    
    
    ;
    
    
    //    if ([JDStatusBarNotification isVisible]) {
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
    //            [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.5 styleName:JDStatusBarStyleSuccess];
    //        });
    //    }else{
    //        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
    //        [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.0 styleName:JDStatusBarStyleSuccess];
    //    }
}
+ (void)showStatusBarErrorStr:(NSString *)errorStr{
    //    FFToast *toast = [[FFToast alloc]initToastWithTitle:nil message:errorStr iconImage:nil];
    //    toast.toastType = FFToastTypeDefault;
    //    toast.toastPosition = FFToastPositionBottomWithFillet;
    //    [toast show];
    
    // Make toast with an image, title, and completion block
    [[UIApplication sharedApplication].keyWindow makeToast:errorStr
                                                  duration:2.0
                                                  position:CSToastPositionCenter
                                                     title:nil
                                                     image:nil
                                                     style:nil
                                                completion:^(BOOL didTap) {
                                                    if (didTap) {
                                                        NSLog(@"completion from tap");
                                                    } else {
                                                        NSLog(@"completion without tap");
                                                    }
                                                }];
    
    
    //    if ([JDStatusBarNotification isVisible]) {
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
    //            [JDStatusBarNotification showWithStatus:errorStr dismissAfter:1.5 styleName:JDStatusBarStyleError];
    //
    //        });
    //    }else{
    //        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
    //        [JDStatusBarNotification showWithStatus:errorStr dismissAfter:1.5 styleName:JDStatusBarStyleError];
    //    }
}

//+ (void)showStatusBarError:(NSError *)error{
//    NSString *errorStr = [NSObject tipFromError:error];
//    [NSObject showStatusBarErrorStr:errorStr];
//}



#pragma mark File M
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}
//创建缓存文件夹
+ (BOOL) createDirInCache:(NSString *)dirName
{
    NSString *dirPath = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}



// 图片缓存到本地
+ (BOOL) saveImage:(UIImage *)image imageName:(NSString *)imageName inFolder:(NSString *)folderName
{
    if (!image) {
        return NO;
    }
    if (!folderName) {
        folderName = kPath_ImageCache;
    }
    if ([self createDirInCache:folderName]) {
        NSString * directoryPath = [self pathInCacheDirectory:folderName];
        BOOL isDir = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL existed = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
        bool isSaved = false;
        if ( isDir == YES && existed == YES )
        {
            isSaved = [[image dataForCodingUpload] writeToFile:[directoryPath stringByAppendingPathComponent:imageName] options:NSAtomicWrite error:nil];
        }
        return isSaved;
    }else{
        return NO;
    }
}
// 获取缓存图片
+ (NSData*) loadImageDataWithName:( NSString *)imageName inFolder:(NSString *)folderName
{
    if (!folderName) {
        folderName = kPath_ImageCache;
    }
    NSString * directoryPath = [self pathInCacheDirectory:folderName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dirExisted = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( isDir == YES && dirExisted == YES )
    {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@", directoryPath, imageName];
        BOOL fileExisted = [fileManager fileExistsAtPath:abslutePath];
        if (!fileExisted) {
            return NULL;
        }
        NSData *imageData = [NSData dataWithContentsOfFile : abslutePath];
        return imageData;
    }
    else
    {
        return NULL;
    }
}

// 删除图片缓存
+ (BOOL) deleteImageCacheInFolder:(NSString *)folderName{
    if (!folderName) {
        folderName = kPath_ImageCache;
    }
    return [self deleteCacheWithPath:folderName];
}



+ (BOOL) deleteResponseCache{
    return [self deleteCacheWithPath:kPath_ResponseCache];
}

+ (NSUInteger)getResponseCacheSize {
    NSString *dirPath = [self pathInCacheDirectory:kPath_ResponseCache];
    NSUInteger size = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:dirPath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return size;
}


+ (BOOL) deleteCacheWithPath:(NSString *)cachePath{
    NSString *dirPath = [self pathInCacheDirectory:cachePath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:dirPath error:nil];
    }
    return isDeleted;
}

#pragma mark NetError
//-(id)handleResponse:(id)responseJSON{
//    return [self handleResponse:responseJSON autoShowError:YES];
//}

//网络请求
+ (BOOL)isSave:(BOOL)isSave responseData:(NSDictionary *)data toPath:(NSString *)requestPath{
    if (!isSave) {
        return NO;
    }else{
        requestPath = [NSString stringWithFormat:@"%@_%@", kUserID, requestPath];
    }
    if ([self createDirInCache:kPath_ResponseCache]) {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [requestPath md5Str]];
        return [data writeToFile:abslutePath atomically:YES];
    }else{
        return NO;
    }
}
+ (id)canLoad:(BOOL)canLoad loadResponseWithPath:(NSString *)requestPath{//返回一个NSDictionary类型的json数据
    if (!canLoad) {
        return nil;
    }else{
        requestPath = [NSString stringWithFormat:@"%@_%@", kUserID, requestPath];
    }
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [requestPath md5Str]];
    return [NSMutableDictionary dictionaryWithContentsOfFile:abslutePath];
}

+ (BOOL)haveFiel:(BOOL)haveFiel deleteResponseCacheForPath:(NSString *)requestPath{
    if (!haveFiel) {
        return NO;
    }else{
        requestPath = [NSString stringWithFormat:@"%@_%@", kUserID, requestPath];
    }
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [requestPath md5Str]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:abslutePath]) {
        return [fileManager removeItemAtPath:abslutePath error:nil];
    }else{
        return NO;
    }
}









+(void)startTime:(UIButton *)button{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:@"重发验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
                //button.backgroundColor = YYSRGBColor(44, 153, 46, 1);
                button.titleLabel.font = [UIFont systemFontOfSize:13];
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d秒重新发送", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
                //button.backgroundColor = YYSRGBColor(184, 184, 184, 1);
                button.titleLabel.font = [UIFont systemFontOfSize:11];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



//时间戳转换成字符串
+ (NSString *)formateTime:(NSString *)time{
    NSTimeInterval tempTime = [time intValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatterT = [[NSDateFormatter alloc] init];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:tempTime];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *confromTimespT = [NSDate dateWithTimeIntervalSince1970:tempTime];
    [formatterT setDateFormat:@"HH:mm"];
    NSDate *startDate = confromTimesp;
    NSDate *endDate = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents *endDateComponents = [cal components:unitFlags fromDate:endDate];
    NSDateComponents *startDateComponents = [cal components:unitFlags fromDate:startDate];

    NSInteger d_endDate = [endDateComponents day];
    int64_t d_startDate = [startDateComponents day];

    NSString *confromTimespStr =nil;
    if (d_endDate - d_startDate == 0)
        confromTimespStr =[NSString stringWithFormat:@"今天 %@",[formatterT stringFromDate:confromTimespT]] ;
    else if (d_endDate - d_startDate == 1)
        confromTimespStr =[NSString stringWithFormat:@"昨天 %@",[formatterT stringFromDate:confromTimespT]] ;
    else if (d_endDate - d_startDate == 2)
        confromTimespStr =[NSString stringWithFormat:@"前天 %@",[formatterT stringFromDate:confromTimespT]] ;
    else
        confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;

}
+ (NSString *)formateTimeYM:(NSString *)time{

    NSTimeInterval tempTime = [time intValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatterT = [[NSDateFormatter alloc] init];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:tempTime];
    [formatter setDateFormat:@"YYYY年MM月"];
    NSDate *confromTimespT = [NSDate dateWithTimeIntervalSince1970:tempTime];
    [formatterT setDateFormat:@"HH:mm"];
    NSDate *startDate = confromTimesp;
    NSDate *endDate = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents *endDateComponents = [cal components:unitFlags fromDate:endDate];
    NSDateComponents *startDateComponents = [cal components:unitFlags fromDate:startDate];

    NSInteger d_endDate = [endDateComponents day];
    int64_t d_startDate = [startDateComponents day];

    NSString *confromTimespStr =nil;
    if (d_endDate - d_startDate == 0)
        confromTimespStr =[NSString stringWithFormat:@"今天 %@",[formatterT stringFromDate:confromTimespT]] ;
    else if (d_endDate - d_startDate == 1)
        confromTimespStr =[NSString stringWithFormat:@"昨天 %@",[formatterT stringFromDate:confromTimespT]] ;
    else if (d_endDate - d_startDate == 2)
        confromTimespStr =[NSString stringWithFormat:@"前天 %@",[formatterT stringFromDate:confromTimespT]] ;
    else
        confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;

}





@end
