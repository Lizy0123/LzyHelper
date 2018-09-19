//
//  Helper_Encrypt.m
//  DeviceHelp
//
//  Created by Lzy on 2017/10/23.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "Helper_Encrypt.h"
//DES加密加密解密
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
// MD5加密
#import <CommonCrypto/CommonDigest.h>
//RSA加密
#import <Security/Security.h>

#define EncryptKey @"96B2726D122398259B604A86FCFBB72B"

@implementation Helper_Encrypt

/// 加密方法
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key{
    //转换成data
    NSData* plainTextdata = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger plainTextdatLength = [plainTextdata length];

    //将data数据MD5加密
    unsigned char digest[16];
    CC_MD5([plainTextdata bytes],(CC_LONG) plainTextdatLength, digest);


    //总长度 MD5 + plainText
    NSUInteger plainTextBufferTotalSize  = 16 +plainTextdatLength;


    //将plainText 转换成bytes
    Byte *testByte = (Byte *)[plainTextdata bytes];

    //定义totalByte
    Byte totalByte[plainTextBufferTotalSize];
    for (int i = 0; i < plainTextBufferTotalSize; ++i) {
        if (i<16) {
            totalByte[i] =digest[i];
        }else{
            totalByte[i] =testByte[i - 16];
        }
    }

    //将key base64 编码
    NSData *baseKey = [GTMBase64 decodeString:key];
    Byte *buf = (Byte *)[baseKey bytes];

    Byte key1[8];
    Byte iv2[8];
    for (int i = 0; i < 8; i++) {
        key1[i] = buf[i];
    }
    //后8位为iv向量
    for (int i = 0; i < 8 ; i++) {
        iv2[i] = buf[i + 8];
    }

    NSString *ciphertext = nil;
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          key1,
                                          kCCKeySizeDES,
                                          iv2,
                                          totalByte,
                                          plainTextBufferTotalSize,
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //使用Base64加密后返回
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }else{
        NSLog(@"EncryptUtil:DES加密失败");
    }
    return ciphertext;
}

/// 解密方法
+ (NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key {
    //plainTextData转换 base64
    NSData *BasePlainTextData = [GTMBase64 decodeString:plainText];
    //将BasePlainTextDatabase64转换为byte数组
    Byte *BasePlainTextDataByte = (Byte *)[BasePlainTextData bytes];

    //将key base64解码
    NSData *baseKey = [GTMBase64 decodeString:key];
    //将key 转换成 byte数组
    Byte *buf = (Byte *)[baseKey bytes];

    //定义key iv byte数组
    Byte keyByte[8];
    Byte ivByte[8];
    for (int i = 0; i < 8; i++) {
        keyByte[i] = buf[i];
    }
    //后8位为iv向量
    for (int i = 0; i < 8 ; i++) {
        ivByte[i] = buf[i + 8];
    }

    //返回值长度
    size_t bufferSize = BasePlainTextData.length;

    //字符串长度比较长 返回值给大点
    unsigned char buffer[1024];
    memset(buffer,0,sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          keyByte,
                                          kCCKeySizeDES,
                                          ivByte,
                                          BasePlainTextDataByte,
                                          bufferSize,
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);


    NSData *resultdata;
    if (cryptStatus == kCCSuccess) {

        resultdata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
    }


    Byte *resultByte = (Byte *)[resultdata bytes];


    // 返回数组长度 减去MD5加密的16
    size_t returnLength = resultdata.length - 16;
    /// 定义
    Byte decryptionByte[returnLength];

    for (int i = 0; i < returnLength; ++i) {
        decryptionByte[i] = resultByte[i+16];
    }

    /// md5 校验
    //    unsigned char digest[16];
    //    CC_MD5(decryptionByte,returnLength, digest);
    //    NSData *md5data = [NSData dataWithBytes:digest length:16];

    // 进行解密校检
    //    Byte *md5bte= (Byte *)[md5data bytes];

    //    for (int i = 0; i < 40; i++) {
    //
    //
    //        if (md5bte[i] !=decryptionByte[i] ) {
    //            // System.out.println(md5Hash[i] + "MD5校验错误。" + temp[i]);
    //            //            throw new Exception("MD5校验错误。");
    //
    //            NSLog(@"c1111uowu");
    //        }else{
    //            NSLog(@"cuowu");
    //        }
    //    }

    NSData *namedata = [[NSData alloc] initWithBytes:decryptionByte length:returnLength];

    NSString *str = [[NSString alloc] initWithData:namedata encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    return str;
}


#pragma mark 最基础的MD5加密
+ (NSString *)md5:(NSString *)string{
    // 转MD5
    const char *cStr = [string UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);

    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

#pragma mark - RSA加密解密
static NSString *base64_encode_data(NSData *data){
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

static NSData *base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

+ (NSData *)stripPublicKeyHeader:(NSData *)d_key{
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);

    unsigned long len = [d_key length];
    if (!len) return(nil);

    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx    = 0;

    if (c_key[idx++] != 0x30) return(nil);

    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;

    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);

    idx += 15;

    if (c_key[idx++] != 0x03) return(nil);

    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;

    if (c_key[idx++] != '\0') return(nil);

    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

+ (SecKeyRef)addPublicKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];

    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [self stripPublicKeyHeader:data];
    if(!data){
        return nil;
    }

    NSString *tag = @"what_the_fuck_is_this";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];

    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);

    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];

    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }

    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];

    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

//RSA加密
+ (NSString *)encryptByRSAString:(NSString *)str publicKey:(NSString *)pubKey{
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [self encryptByRSAData:data publicKey:pubKey];
}

+ (NSString *)encryptByRSAData:(NSData *)data publicKey:(NSString *)pubKey{
    if(!data || !pubKey){
        return nil;
    }
    SecKeyRef keyRef = [self addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }

    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;

    size_t outlen = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    if(srclen > outlen - 11){
        CFRelease(keyRef);
        return nil;
    }
    void *outbuf = malloc(outlen);

    OSStatus status = noErr;
    status = SecKeyEncrypt(keyRef,
                           kSecPaddingPKCS1,
                           srcbuf,
                           srclen,
                           outbuf,
                           &outlen
                           );
    NSString *ret = nil;
    if (status != 0) {
        //NSLog(@"SecKeyEncrypt fail. Error Code: %ld", status);
    }else{
        NSData *data = [NSData dataWithBytes:outbuf length:outlen];
        ret = base64_encode_data(data);
    }
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}


//
+ (NSString*)dictionaryToJson:(NSMutableDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }

    return dic;
}
+(NSString *)getDataStringWithLength:(int)length with :(unsigned char*)digest{
    NSMutableString *output = [NSMutableString stringWithCapacity:length * 2];
    unsigned char byte[length];
    for(int i = 0; i < length; i++){
        byte[i] =(char)digest[i];
        [ output appendFormat:@"%d",(char)byte[i]];
    }
    return output.copy;
}


@end
