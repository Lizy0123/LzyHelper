//
//  NSString+Common.h
//  LzyHelper
//
//  Created by Lzy on 2017/11/4.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
#pragma mark - 字符串处理
/**
 随机字符串

 @return 随机字符串
 */
+(instancetype)randomStr;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
/**
 适合的高度-通过宽度和字体

 @param font 字体
 @param width 宽度
 @return 适合的高度，默认 systemFontOfSize:font
 */
-(CGFloat)heightWithFont:(NSInteger)font width:(CGFloat)width;
/**
 适合的宽度- 通过高度和字体

 @param font 字体
 @param height 高度
 @return 适合的宽度 默认 systemFontOfSize:font
 */
-(CGFloat)widthWithFont:(NSInteger)font height:(CGFloat)height;
/**
 判断是否含有空格

 @return 是否含有空格
 */
-(BOOL)hasEmptyStr;
/**
 去空格

 @return 去掉空格的字符串
 */
-(NSString *)clearSpace;
/**
 去空格和末尾的换行符

 @return 去掉空格的字符串
 */
-(NSString *)clearBlankAndNewline;

/**
 清除非法字符串

 @return 清除非法字符串后的字符串
 */
-(NSString *)clearIllegalCharacter;

/**
 拼上字符串

 @param string 需要拼接的字符串
 @return 拼接后的字符串
 */
-(NSString *)addStr:(NSString *)string;

/**
 计算字符串长度 1中文2字符

 @return 计算字符串长度 1中文2字符
 */
-(int)textLength;

/**
 限制最大显示长度

 @param limit 限制最大显示长度
 @return 限制最大显示长度
 */
-(NSString *)limitMaxTextShow:(NSInteger)limit;
/**
 按字符串的(，分隔符)逗号分割为数组，判断了是否以分隔符为开头
 
 @param str 分隔符
 @return 分割后的数组
 */
-(NSArray *)combinArrWithSeparatedStr:(NSString *)str;

/**
 获取系统时间戳

 @return 时间戳
 */
+(NSString *)timeStampNow;




#pragma mark - 加密
/**
 转为 base64string后的Data

 @return NSData
 */
-(NSData *)base64Data;
/**
 转为 base64String

 @return NSString
 */
-(NSString *)base64Str;
/**
解 base64为Str 解不了就返回原始的数值

 @return NSString
 */
-(NSString *)decodeBase64;

/**
 md5加密字符串

 @return 返回md5加密后的字符串
 */
-(NSString *)md5Str;
/**
 sha1加密

 @return 加密后的字符串
 */
-(NSString *)sha1Str;


#pragma mark - 判断

/**
 判断是否为空或者null

 @return 是否为空
 */
-(BOOL)isNullOrEmpty;

/**
 是否包含对应字符

 @param subString 对应的字符
 @return BOOL
 */
- (BOOL)isContainStr:(NSString *)subString;

/**
 验证是含本方法定义的 “特殊字符”

 @return BOOL
 */
- (BOOL)isSpecialCharacter;

/**
 验证是否ASCII码

 @return BOOL
 */
- (BOOL)isASCII;

/**
 验证是否是数字

 @return BOOL
 */
- (BOOL)isNumber;


/**
 验证字符串里面是否都是数字

 @return BOOL
 */
- (BOOL)isPureNumber;


/**
 判断是否为整形

 @return 是否为整形
 */
-(BOOL)isPureInt;

/**
 判断是否为浮点型

 @return 是否为浮点型
 */
-(BOOL)ispureFloat;



/**
 邮箱格式是否正确

 @return BOOL
 */
- (BOOL)isEmail;

/**
 判断网址格式是否正确
 @return 网址格式是否正确
 */
- (BOOL)isUrl;
- (BOOL)isLegalUrlString;

//如果只输入www.baidu.com，该方法也会认为不合法。
//如果确认url的协议，则使用此方法。
- (BOOL)isLegalURL;
/**
 判断是否正确的手机格式

 @return 是否是正确的手机格式
 */
+ (BOOL)isPhone:(NSString *)phoneStr;


/**
 是否是身份证

 @return 是否是身份证
 */
-(BOOL)isIDCard;

/**
 判断是否是银行卡

 @return 是否是银行卡
 */
-(BOOL)isBankCard;


/**
 判断是否是中文汉字

 @return 是否是中文汉字
 */
-(BOOL)isChinese;

/**
 中文转拼音

 @param chinese 中文
 @return 拼音
 */
- (NSString *)pinYinWithString:(NSString *)chinese;

/**
 判断是否只含有数字或字母（用于密码的合法性判断长度大于8位）

 @return 是否只含有数字和密码
 */
-(BOOL)isNumberOrLetterOnly;

/**
 判断密码是否合法
 return 1;全部符合数字，表示沒有英文
 return 2;全部符合英文，表示沒有数字
 return 3;符合英文和符合数字条件的相加等于密码长度
 return 4;可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
 @return 是否合法密码
 */
-(BOOL)hasNumberAndLetter;

/**
 验证6-16位密码  至少包含数字.字母.符号中的2种

 @return 是否合法密码
 */
-(BOOL)isLegalPassWord;



/**
 判断是否是emoji表情

 @return Bool
 */
- (BOOL)isEmoji;

/**
 去掉 表情符号

 @return 去掉表情后的字符串
 */
- (NSString *)disableEmoji;

+ (NSString *)userAgentStr;
- (NSString *)URLEncoding;
- (NSString *)URLDecoding;

- (NSString *)md5Encrypt;

+ (id)stringWithDate:(NSDate*)date format:(NSString *)format;
+ (NSString *)handelRef:(NSString *)ref path:(NSString *)path;

-(BOOL)containsEmoji;
+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte;





- (NSString *)stringByRemoveSpecailCharacters;
- (NSString *)trimWhitespace;
- (BOOL)isEmpty;
- (BOOL)isEmptyOrListening;
//判断是否为整形

//判断是否为浮点形
- (BOOL)isPureFloat;
//判断是否是手机号码或者邮箱
- (BOOL)isPhoneNo;

- (BOOL)isGK;

- (NSRange)rangeByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSRange)rangeByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

//转换拼音
- (NSString *)transformToPinyin;

//是否包含语音解析的图标
- (BOOL)hasListenChar;



+ (BOOL)isValidateMobile:(NSString *)mobile;

+ (BOOL)isEmailAddress:(NSString *)email;

+ (NSString *)formatTimeBySecond:(NSInteger)second;

+(BOOL)isString:(id)str;
- (NSInteger)versionNumberValue;

- (NSString *)md5Encode;
- (NSString *)md516Encode;
+ (NSString*)stringWithDateIntervalFromBase:(unsigned long long)interval;
+ (NSString*)stringWithDateInterval:(unsigned long long)interval;
+ (NSString*)stringWithFileSize:(unsigned long long)size;

- (BOOL)containChineseWord;

- (BOOL)containCapitalWord;

- (BOOL)containNumeralWord;

- (BOOL)containBlankSpace;

- (BOOL)includeString:(NSString *)string;

//如果只输入www.baidu.com，该方法也会认为不合法。
//如果确认url的协议，则使用此方法。


// 从一片内存数据中得到一个十六进制字符串
+ (NSString*)hexStringFromBytes:(const void*)data withLength:(NSUInteger)length;
- (NSData*)hexStringToDataBytes;






- (NSString*) base64Encode;
- (NSString *) base64Decode;

// 这个才是base64的正确使用方式  同时在NSData的扩展里头有encode方法

- (NSData*)base64Decode2;


- (NSString *)encodeString;
- (NSString *)decodeString;

// 确保上报的字段合法（中文字符加%Encode，字段长度255截取）
- (NSString *)legalReportFieldString;

// 从字符串中计算出urlhash
- (int64_t)urlHashFromString;

// 获取系统时间戳
+ (NSString *)timeStampAtNow;

//去掉前后空格和换行符
- (NSString *)trim;






@end
