//
//  Helper_SensitiStr.h
//  LzyHelper
//
//  Created by Lzy on 2017/11/9.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper_SensitiStr : NSObject

+(instancetype)sharedInstance;


/**
 加载本地敏感词库
 @param path 敏感词库文件路径
 */
-(void)loadFileWithPath:(NSString *)path;

/**
 将含有的敏感进行替换
 @param str 文本字符串
 @return 过滤后的文本
 */
-(NSString *)configStr:(NSString *)str;

/**
 判断文本是否含有敏感字符
 @param str 文本字符
 @return 是否含有敏感字符
 */
-(BOOL)hasSensitiveStr:(NSString *)str;
@end
