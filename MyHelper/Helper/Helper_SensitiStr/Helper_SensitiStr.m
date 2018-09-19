//
//  Helper_SensitiStr.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/9.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "Helper_SensitiStr.h"
#define isExit @"isExits"

@interface Helper_SensitiStr()
@property(strong, nonatomic) NSMutableDictionary *rootDic;
@property(strong, nonatomic) NSMutableArray *rootArr;
@property(assign, nonatomic) BOOL isToolClose;
@end

@implementation Helper_SensitiStr

static Helper_SensitiStr *instance;

- (NSMutableArray *)rootArr{
    if (!_rootArr) {
        _rootArr = [NSMutableArray array];
    }
    return _rootArr;
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

//复写init方法
- (instancetype)init{

    if (self) {
        self = [super init];
        //加载本地文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"minganci" ofType:@"txt"];
        [self loadFileWithPath:filePath];
    }
    return self;
}

#pragma mark - 加载本地敏感词库
-(void)loadFileWithPath:(NSString *)path{
    self.rootDic = [NSMutableDictionary dictionary];
    NSString *fileString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.rootArr removeAllObjects];
    [self.rootArr addObjectsFromArray:[fileString componentsSeparatedByString:@"|"]];

    for (NSString *str in self.rootArr) {
        //插入字符，构造节点
        [self insertWords:str];
    }
}

-(void)insertWords:(NSString *)words{
    NSMutableDictionary *node = self.rootDic;
    for (int i = 0; i < words.length; i ++) {
        NSString *word = [words substringWithRange:NSMakeRange(i, 1)];
        if (node[word] == nil) {
            node[word] = [NSMutableDictionary dictionary];
        }
        node = node[word];
    }
    //敏感词最后一个字符标识
    node[isExit] = [NSNumber numberWithInt:1];
}

#pragma mark - 将文本中含有的敏感词进行替换
-(NSString *)configStr:(NSString *)str{
    if (self.isToolClose || !self.rootDic) {
        return str;
    }
    NSMutableString *result = result = [str mutableCopy];
    for (int i = 0; i < str.length; i ++) {
        NSString *subString = [str substringFromIndex:i];
        NSMutableDictionary *node = [self.rootDic mutableCopy] ;
        int num = 0;

        for (int j = 0; j < subString.length; j ++) {
            NSString *word = [subString substringWithRange:NSMakeRange(j, 1)];

            if (node[word] == nil) {
                break;
            }else{
                num ++;
                node = node[word];
            }
            //敏感词匹配成功
            if ([node[isExit]integerValue] == 1) {
                NSMutableString *symbolStr = [NSMutableString string];
                for (int k = 0; k < num; k ++) {
                    [symbolStr appendString:@"*"];
                }
                [result replaceCharactersInRange:NSMakeRange(i, num) withString:symbolStr];
                i += j;
                break;
            }
        }
    }
    return result;
}

- (void)freeFilter{
    self.rootDic = nil;
}

- (void)stopFilter:(BOOL)b{
    self.isToolClose = b;
}

#pragma mark - 判断文本中是否含有敏感词
-(BOOL)hasSensitiveStr:(NSString *)str{
    if (self.isToolClose || !self.rootDic) {
        return NO;
    }
    NSMutableString *result = result = [str mutableCopy];
    for (int i = 0; i < str.length; i ++) {
        NSString *subString = [str substringFromIndex:i];
        NSMutableDictionary *node = [self.rootDic mutableCopy] ;
        int num = 0;
        for (int j = 0; j < subString.length; j ++) {
            NSString *word = [subString substringWithRange:NSMakeRange(j, 1)];

            if (node[word] == nil) {
                break;
            }else{
                num ++;
                node = node[word];
            }
            //敏感词匹配成功
            if ([node[isExit]integerValue] == 1) {
                return YES;
            }
        }
    }
    return NO;
}
@end
