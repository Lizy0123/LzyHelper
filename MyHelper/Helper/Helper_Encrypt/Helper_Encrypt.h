//
//  Helper_Encrypt.h
//  DeviceHelp
//
//  Created by Lzy on 2017/10/23.
//  Copyright © 2017年 Lzy. All rights reserved.
/**
 *  StudyFrom:@github https://github.com/feiyangkl/EncryptUtil
 */
/*
 0.加密流程和解密流程
     a.加密的过程: 参数字典 --> json字符串 --> base64加密后的字符串 --> DES加密后base64再加密 --> 输出最终加密后的字符串;
     b.解密的过程: 后台服务器获取加密的字符串 -->base64解密 --> DES解密后base64解密 --> json字符串 --> 数据字典;(与加密的过程相反)

 1.DES的加密模式为 DES + CBC
     a.如果采用PKCS7Padding或者PKCS5Padding这种加密方式，末端添加的数据可能不固定，在解码后需要把末端多余的字符去掉，比较棘手。
     b.如果不管补齐多少位，末端都是'\0',去掉的话比较容易操作。 最主要的是能使得
     c.iOS/Android/PHP相互通信，也是加密过程中最难搞的地方，尤其需要开发者注意。

 2.用到了 google 的 base64 加解密库 GTMBase64，很多年没有更新， MRC 开发模式，需要手动配置：
     a.选择项目中的Targets，选中你所要操作的Target，
     b.选Build Phases，在其中Complie Sources中选择需要ARC的文件(GTMBase64.m)双击，并在输入框中输入 -fno-objc-arc
 3.注意
     a.{"userName":"admin","password":"0123456"}
     b.{
       "userName" : "admin",
       "password" : "0123456"
       }
    a和b 加密后结果是不一样的,一定要确定公司后台是怎么加密的,要不然有可能会错误
 */

#import <Foundation/Foundation.h>
@interface Helper_Encrypt : NSObject

/**
 加密方法

 @param plainText 需要加密的字符串
 @param key key
 @return 加密后得到的经过加密的字符串
 */
+(NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;


/**
 解密方法

 @param plainText 加密后的字符串
 @param key 加密的key
 @return 解密后得到的原字符串
 */
+(NSString *)decryptUseDES:(NSString *)plainText key:(NSString *)key;


/**
 将字典转换成字符串

 @param dic 输入的字典
 @return 输出的字符串
 */
+(NSString*)dictionaryToJson:(NSDictionary *)dic;


/**
 将json字符串转换成字典

 @param jsonString Json格式的字符串
 @return 字典
 */
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;



//最基础的MD5加密
+ (NSString *)md5:(NSString *)string;
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString;

//RSA加密
+ (NSString *)encryptByRSAString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSString *)encryptByRSAData:(NSData *)data publicKey:(NSString *)pubKey;























@end

