//
//  Helper_Device.m
//  DeviceHelp
//
//  Created by Lzy on 2017/10/23.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "Helper_Device.h"
#import <sys/mount.h>

//Device
#import "sys/utsname.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <objc/runtime.h>
#import <mach/mach.h>
#import <AdSupport/AdSupport.h>


//Storage
#import <sys/mount.h>
#import <sys/sysctl.h>
#import <mach/mach.h>


//Battery
#import <UIkit/UIDevice.h>
#import <CoreGraphics/CGBase.h>

//Screen
#import <UIkit/UIScreen.h>
#import <CoreGraphics/CGBase.h>

//NetWork
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

//JailBreak
#import <UIkit/UIApplication.h>
#include <stdlib.h>

//VPNInfo
#import <NetworkExtension/NetworkExtension.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

//IP
#include <ifaddrs.h>
#include <sys/socket.h> // Per msqr
#import <sys/ioctl.h>
#include <net/if.h>
#import <arpa/inet.h>

#include <resolv.h>

static NSString * const kMachine = @"machine";
static NSString * const kNodeName = @"nodename";
static NSString * const kRelease = @"release";
static NSString * const kSysName = @"sysname";
static NSString * const kVersion = @"version";

@interface Helper_Device()<CLLocationManagerDelegate>
@property(strong, nonatomic)UIDevice *device;
@property (nonatomic,strong)NSDictionary *utsNameDic;
@property (nonatomic,strong)NSProcessInfo *processInfo;
@property (nonatomic,strong)Reachability *reachAb;
@property (nonatomic,strong)CLLocationManager *locationManager;


@end


@implementation Helper_Device
+(instancetype)sharedInstance{
    static Helper_Device *Helper_Device = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Helper_Device = [[self alloc] init];
    });
    return Helper_Device;
}
#pragma mark Lazy Load
- (UIDevice *)device {
    if (!_device) {
        _device = [UIDevice currentDevice];
    }
    return _device;
}
- (NSDictionary *)utsNameDic {
    if (!_utsNameDic) {
        struct utsname systemInfo;
        uname(&systemInfo);
        _utsNameDic = @{kSysName:[NSString stringWithCString:systemInfo.sysname encoding:NSUTF8StringEncoding],kNodeName:[NSString stringWithCString:systemInfo.nodename encoding:NSUTF8StringEncoding],kRelease:[NSString stringWithCString:systemInfo.release encoding:NSUTF8StringEncoding],kVersion:[NSString stringWithCString:systemInfo.version encoding:NSUTF8StringEncoding],kMachine:[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]};
    }
    return _utsNameDic;
}
- (NSProcessInfo *)processInfo {
    if (!_processInfo) {
        _processInfo = [NSProcessInfo processInfo];
    }
    return _processInfo;
}
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
- (BOOL)canMakePhoneCall {
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return can;
}
#endif
#pragma mark - System系统
-(NSString *)systemName{
    return self.device.systemName;
}
-(NSString *)systemVersion{
    return self.device.systemVersion;
}
-(NSDate *)systemUptime{
    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    return [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
}
-(BOOL)isMultitaskSupported{
    return self.device.multitaskingSupported;
}
-(NSString *)kernelVersion{
    return self.utsNameDic[kRelease];
}
-(NSString *)kernelBuildDescription{
    return self.utsNameDic[kVersion];
}
-(NSString *)hardwareType{
    return self.utsNameDic[kMachine];
}
-(NSString *)OSName{
    return self.utsNameDic[kSysName];
}
-(NSString *)netNodeName{
    return self.utsNameDic[kNodeName];
}



#pragma mark - Device设备


-(NSString *)deviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceModel;
}
-(NSString *)deviceType{
    //引入头文件#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"]) return @"American iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"]) return @"American iPhone 7 Plus";
    //    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"Chinese iPhone 8";
    //    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"Global iPhone 8";
    //    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"Chinese iPhone X";
    //    if ([deviceString isEqualToString:@"iPhone10,4"]) return @"Global iPhone 8";
    //    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"Global iPhone 8 Plus";
    //    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"Global iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    
    if ([deviceString isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"]) return @"iPod Touch (5 Gen)";
    if ([deviceString isEqualToString:@"iPod7,1"])   return @"iPod Touch 6G"; //
    
    if ([deviceString isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"]) return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"]) return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"]) return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"]) return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"]) return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"]) return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"]) return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"]) return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,4"]) return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"]) return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"]) return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"]) return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"]) return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"]
        ||[deviceString isEqualToString:@"iPad6,12"])      return @"iPad 5";
    
    if ([deviceString isEqualToString:@"iPad7,1"]
        ||[deviceString isEqualToString:@"iPad7,2"])      return @"iPad pro (12.9-inch,2)";
    if ([deviceString isEqualToString:@"iPad7,3"]
        ||[deviceString isEqualToString:@"iPad7,4"])      return @"iPad pro (10.5-inch)";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}


-(NSString *)deviceTypeShort{
    return self.device.model;
}

-(NSString *)deviceName{
    return self.device.name;
}

-(NSString *)deviceUUID{
    return [self.device.identifierForVendor UUIDString];
}

-(NSString *)deviceIDFA{
    //引入头文件#import <AdSupport/AdSupport.h>
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}
-(NSString *)deviceIDFV{
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}
-(NSString *)deviceLocalizeModel{
    return [UIDevice currentDevice].localizedModel;
}
+(NSString *)deviceID{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[self Tool_Keychianload:@"com.AMSDK.sdk.allinone"];
    if([usernamepasswordKVPair objectForKey:@"com.AMSDK.sdk.showmethemoney"])
    {
        return [usernamepasswordKVPair objectForKey:@"com.AMSDK.sdk.showmethemoney"];
    } else
    {
        CFUUIDRef uuidObj = CFUUIDCreate(nil);
        NSString *xString = (__bridge_transfer NSString *)CFUUIDCreateString(nil,uuidObj);
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [usernamepasswordKVPairs setObject:xString forKey:@"com.AMSDK.sdk.showmethemoney"];
        [self Tool_Keychainsave:@"com.AMSDK.sdk.allinone" data:usernamepasswordKVPairs];
        return xString;
    }
}
/*
 * keychain 查询
 */
+ (NSMutableDictionary *)Tool_KeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}
/*
 * keychain 保存
 */
+ (void)Tool_Keychainsave:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self Tool_KeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}
/*
 * keychain 读取
 */
+ (id)Tool_Keychianload:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self Tool_KeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"%@",e);
        } @finally {
        }
    }
    return ret;
}
-(NSInteger)nuclearCount{
    return self.processInfo.processorCount;
}

-(NSInteger)nuclearActiveCount{
    return self.processInfo.activeProcessorCount;
}




#pragma mark - Location位置信息
- (void)location:(ChangeLocationBlock)block {
    self.blockLocation = block;
    if (![CLLocationManager locationServicesEnabled]) {
        if (self.blockLocation) {
            self.blockLocation(nil,@"请先开启定位功能");
        }
        return;
    }
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
        self.locationManager.delegate = self;
        CLLocationDistance distance  = 1.0;
        self.locationManager.distanceFilter = distance;  //最小的告诉位置更新的距离,单位是m
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [self.locationManager startUpdatingLocation];
        
    }else{
        self.locationManager.delegate = self;
        CLLocationDistance distance  = 500.0;
        self.locationManager.distanceFilter = distance;  //最小的告诉位置更新的距离,单位是m
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [self.locationManager startUpdatingLocation];
    }
    
}
#pragma mark lazy load
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];  //创建一个位置管理器
    }
    return _locationManager;
}
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [CLGeocoder new];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count>0) {
            CLPlacemark *placeMark = placemarks[0];
            NSDictionary *dic = placeMark.addressDictionary;
            NSString *formattedAddressStr = [dic[@"FormattedAddressLines"] objectAtIndex:0];
            NSString *countryStr = dic[@"Country"];
            NSString *cityStr = dic[@"City"];
            NSString *subLocalityStr = dic[@"SubLocality"];
            NSString *provinceStr = dic[@"State"];
            
            if (formattedAddressStr.length > countryStr.length && [[formattedAddressStr substringToIndex:countryStr.length] isEqualToString:countryStr]) {
                formattedAddressStr = [formattedAddressStr substringFromIndex:countryStr.length];
            }
            if (formattedAddressStr.length > provinceStr.length && [[formattedAddressStr substringToIndex:provinceStr.length] isEqualToString:provinceStr]) {
                formattedAddressStr = [formattedAddressStr substringFromIndex:provinceStr.length];
            }
            if (formattedAddressStr.length > cityStr.length && [[formattedAddressStr substringToIndex:cityStr.length] isEqualToString:cityStr]) {
                formattedAddressStr = [formattedAddressStr substringFromIndex:cityStr.length];
            }
            if (formattedAddressStr.length > subLocalityStr.length && [[formattedAddressStr substringToIndex:subLocalityStr.length] isEqualToString:subLocalityStr]) {
                formattedAddressStr = [formattedAddressStr substringFromIndex:subLocalityStr.length];
            }
            //            NSString *resultStr = [NSString stringWithFormat:@"%@\3%@\3%@\3%@\3%@\3%@\3%@\2",countryStr,provinceStr,cityStr,@"",subLocalityStr,@"",formattedAddressStr];
            if (self.blockLocation) {
                self.blockLocation(placeMark,@"定位成功");
            }
        }
    }];
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (self.blockLocation) {
        self.blockLocation(nil,@"方向改变");
    }
}


#pragma mark - Project工程
-(NSString *)appVersion{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}
-(NSString *)appBuildVersion{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}
-(NSString *)appName{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
}





#pragma mark - MemoryStorage内存
#pragma mark Private Method
- (NSUInteger)_getSystemInfo:(uint)typeSpecifier {
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

- (NSString *)_getDocumentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

- (NSString *)_getLibraryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

- (NSString *)_getCachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

-(unsigned long long)_getSizeOfFolder:(NSString *)folderPath {
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    return folderSize;
}
//总磁盘大小
- (long long)getDiskTotalSize {
    struct statfs buf;//引入头文件#import <sys/mount.h>
    unsigned long long totalSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        totalSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return totalSpace;
}
//已使用磁盘大小
- (long long)p_getDiskUsedSize {
    struct statfs buf;
    unsigned long long totalSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        totalSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return totalSpace;
}
//空闲磁盘大小
- (long long)getDiskFreeSize {
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}
//规格化磁盘大小变成String
- (NSString *)getSizeToString:(long long)size {
    if (size>1024*1024*1024) {
        return [NSString stringWithFormat:@"%.1fGB",size/1024.f/1024.f/1024.f];   //大于1G转化成G单位字符串
    }
    if (size<1024*1024*1024 && size>1024*1024) {
        return [NSString stringWithFormat:@"%.1fMB",size/1024.f/1024.f];   //转成M单位
    }
    if (size>1024 && size<1024*1024) {
        return [NSString stringWithFormat:@"%.1fkB",size/1024.f]; //转成K单位
    }else {
        return [NSString stringWithFormat:@"%.1lldB",size];   //转成B单位
    }
}

//内存总大小
-(NSString *)storageDiskTotalSize:(kStorageSizeType)type{
    if (type == StorageSizeTypeOrinin) {
        return [NSString stringWithFormat:@"%lld",[self getDiskTotalSize]];
    }else{
        return [self getSizeToString:self.processInfo.physicalMemory];
    }
}
//物理磁盘总大小
-(NSString *)memoryTotalSiz:(kStorageSizeType)type{
    if (type == StorageSizeTypeOrinin) {
        return [NSString stringWithFormat:@"%llu",self.processInfo.physicalMemory];
    }else {
        return [self getSizeToString:self.processInfo.physicalMemory];
    }
}
//已使用内存大小
-(NSString *)storageDiskUsedSize:(kStorageSizeType)type{
    if (type == StorageSizeTypeOrinin) {
        return [NSString stringWithFormat:@"%lld",[self getDiskTotalSize]-[self getDiskFreeSize]];
    }else {
        return [self getSizeToString:([self getDiskTotalSize]-[self getDiskFreeSize])];
    }
}
//空闲内存大小
-(NSString *)storageDiskFreeSize:(kStorageSizeType)type{
    if (type == StorageSizeTypeOrinin) {
        return [NSString stringWithFormat:@"%lld",[self getDiskFreeSize]];
    }else {
        return [self getSizeToString:[self getDiskFreeSize]];
    }
    return nil;
}
- (NSString *)appSize {
    unsigned long long documentSize   =  [self _getSizeOfFolder:[self _getDocumentPath]];
    unsigned long long librarySize   =  [self _getSizeOfFolder:[self _getLibraryPath]];
    unsigned long long cacheSize =  [self _getSizeOfFolder:[self _getCachePath]];
    
    unsigned long long total = documentSize + librarySize + cacheSize;
    
    NSString *applicationSize = [NSByteCountFormatter stringFromByteCount:total countStyle:NSByteCountFormatterCountStyleFile];
    return applicationSize;
}

- (int64_t)totalDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)freeDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)usedDiskSpace {
    int64_t totalDisk = [self totalDiskSpace];
    int64_t freeDisk = [self freeDiskSpace];
    if (totalDisk < 0 || freeDisk < 0) return -1;
    int64_t usedDisk = totalDisk - freeDisk;
    if (usedDisk < 0) usedDisk = -1;
    return usedDisk;
}
- (int64_t)totalMemory {
    int64_t totalMemory = [[NSProcessInfo processInfo] physicalMemory];
    if (totalMemory < -1) totalMemory = -1;
    return totalMemory;
}

- (int64_t)activeMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.active_count * page_size;
}

- (int64_t)inActiveMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.inactive_count * page_size;
}

- (int64_t)freeMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.free_count * page_size;
}

- (int64_t)usedMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return page_size * (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count);
}

- (int64_t)wiredMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.wire_count * page_size;
}

- (int64_t)purgableMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.purgeable_count * page_size;
}




#pragma mark - CPU
- (NSUInteger)CPUFrequency {
    return [self _getSystemInfo:HW_CPU_FREQ];
}
- (NSUInteger)BusFrequency {
    return [self _getSystemInfo:HW_BUS_FREQ];
}
- (NSUInteger)RamSize {
    return [self _getSystemInfo:HW_MEMSIZE];
}
- (NSUInteger)CPUCount {
    return [NSProcessInfo processInfo].activeProcessorCount;
}
- (float)CPUUsage {
    float cpu = 0;
    NSArray *cpus = [self perCPUUsage];
    if (cpus.count == 0) return -1;
    for (NSNumber *n in cpus) {
        cpu += n.floatValue;
    }
    return cpu;
}
- (NSArray *)perCPUUsage {
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status)
        _numCPUs = 1;
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return nil;
    }
}





#pragma mark - Battery电池
-(BOOL)isAllowMonitorBattery{
    return self.device.isBatteryMonitoringEnabled;
}
//-(CGFloat)batteryCurrentLevel{
//    return self.device.batteryLevel;
//}
-(CGFloat)batteryCurrentLevel{
    self.device.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState state = self.device.batteryState;
    if (state == UIDeviceBatteryStateUnknown) {
        return -1;
    } else{
        return self.device.batteryLevel;
    }
}

-(kBatteryState)batteryState{
    switch (self.device.batteryState) {
        case UIDeviceBatteryStateFull:
            return kBatteryStateFull;
            break;
        case UIDeviceBatteryStateUnknown:
            return kBatteryStateUnknow;
            break;
        case UIDeviceBatteryStateCharging:
            return kBatteryStateCharging;
            break;
        case UIDeviceBatteryStateUnplugged:
            return kBatteryStateUnplugged;
            break;
        default:
            return kBatteryStateUnknow;
            break;
    }
}



#pragma mark - Screen屏幕
-(CGFloat)screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}
-(CGFloat)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}
-(CGFloat)screenBrightness{
    return [UIScreen mainScreen].brightness;
}
-(CGFloat)screenDPI{
    float scale = 1;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        scale = [[UIScreen mainScreen] scale];
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 132*scale;
    }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 163*scale;
    }else {
        return 160*scale;
    }
}
-(NSString *)screenResolution{
    return [NSString stringWithFormat:@"%.0f_%.0f",[UIScreen mainScreen].scale*[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].scale*[UIScreen mainScreen].bounds.size.width];
}



#pragma mark - NetWork网络
#pragma mark  Lazy load
- (Reachability *)reachAb {
    if (!_reachAb) {
        _reachAb = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    }
    return _reachAb;
}
-(BOOL)isConnectNetWork{
    BOOL isConnect = NO;
    switch ([self.reachAb currentReachabilityStatus]) {
        case NotReachable:
            isConnect = NO;
            break;
        case ReachableViaWiFi:   //使用的wifi
            isConnect = YES;
            break;
        case ReachableViaWWAN:  //使用的移动网络
            isConnect = YES;
            break;
        default:
            break;
    }
    return isConnect;
}
-(kNetWorkReachState)netWorkStatus{
    switch ([self.reachAb currentReachabilityStatus]) {
        case NotReachable:
            return kNetWorkReachStatusNoConnect;
            break;
        case ReachableViaWiFi:   //使用的wifi
            return kNetWorkReachStatusWifi;
            break;
        case ReachableViaWWAN:  //使用的移动网络
            return kNetWorkReachStatusCellular;
            break;
        default:
            return kNetWorkReachStatusUndefine;
            break;
    }
}
-(NSString *)netWorkType{
    NSString *netWorkType = @"";
    switch ([self.reachAb currentReachabilityStatus]) {
        case NotReachable:
            return @"no network";
            break;
        case ReachableViaWiFi:   //使用的wifi
            return @"Wifi";
            break;
        case ReachableViaWWAN:  //使用的移动网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentStatus = info.currentRadioAccessTechnology;
            
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                
                netWorkType = @"GPRS";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                
                netWorkType = @"2.75G EDGE";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                
                netWorkType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                
                netWorkType = @"3.5G HSDPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                
                netWorkType = @"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                
                netWorkType = @"2G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                
                netWorkType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                
                netWorkType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                
                netWorkType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
                
                netWorkType = @"HRPD";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                netWorkType = @"4G";
            }
        }
            break;
        default:
            return netWorkType;
            break;
    }
    return netWorkType;
}
-(NSMutableArray *)wifiListArray{
    NSMutableArray *wifiListArr = [[NSMutableArray alloc] initWithCapacity:5];
    //获取可用wifi列表
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    //CoreFoundation对象转换
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    [interfaces enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)obj);
        NSDictionary *netWorkInfo = (__bridge NSDictionary *)dictRef;
        [wifiListArr addObject:netWorkInfo];
        CFRelease(dictRef);
    }];
    CFRelease(wifiInterfaces);
    return wifiListArr;
}
+ (NSString *)wifiName{
    NSString *wifiName = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            wifiName = [dict valueForKey:@"SSID"];
        }
    }
    return wifiName;
}
-(NSString *)IPAddress{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    NSString *deviceIP = @"";
    for (int i=0; i < ips.count; i++) {
        if (ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}
- (NSString *)ipAddressWithIfaName:(NSString *)name {
    if (name.length == 0) return nil;
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr) {
            if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:name]) {
                sa_family_t family = addr->ifa_addr->sa_family;
                switch (family) {
                    case AF_INET: { // IPv4
                        char str[INET_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in *)addr->ifa_addr)->sin_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    } break;
                        
                    case AF_INET6: { // IPv6
                        char str[INET6_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in6 *)addr->ifa_addr)->sin6_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    }
                        
                    default: break;
                }
                if (address) break;
            }
            addr = addr->ifa_next;
        }
    }
    freeifaddrs(addrs);
    return address ? address : @"该设备不存在该ip地址";
}
-(NSString *)IPAddressWifi{
    return [self ipAddressWithIfaName:@"en0"];
}
-(NSString *)IPAddressCellular{
    return [self ipAddressWithIfaName:@"pdp_ip0"];
}
-(NSString *)IPAddressWifiShort{
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    //引入头文件#import <ifaddrs.h>
    success = getifaddrs(&interfaces);
    if (success == 0) { // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            //引入头文件#import <arpa/inet.h>
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}
-(NSString *)IPAddressOpenNet{
    //添加判断，否则断网会崩溃
    if (!([self netWorkStatus] == 0||[self netWorkStatus] == 1)) {
        NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];
        NSDictionary *IPDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:ipURL] options:NSJSONReadingMutableContainers error:nil];
        NSString *IPStr = nil;
        if (IPDic && [IPDic[@"code"] integerValue] == 0) { //获取成功
            IPStr = IPDic[@"data"][@"ip"];
        }
        return (IPStr ? IPStr : @"");
    }else{
        return nil;
    }
}
-(NSString *)IPAddressOpenNetAnother{
    NSError *error;
    NSMutableString *ipJsonStr = [NSMutableString stringWithContentsOfURL:[NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"] encoding:NSUTF8StringEncoding error:&error];
    //判断返回字符串是否为所需数据
    if ([ipJsonStr hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，然后进行json解析
        //删除字符串多余字符串
        [ipJsonStr deleteCharactersInRange:NSMakeRange(0, 19)];
        //将字符串转换成二进制进行Json解析
        NSData * data = [[ipJsonStr substringToIndex:ipJsonStr.length-1] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return dict[@"cip"] ? dict[@"cip"] : @"";
    }
    return @"";
}
+(BOOL)isConnectDelegate{
    CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
    NSDictionary *dictProxy = (__bridge_transfer id)proxySettings;
    NSLog(@"%@",dictProxy);
    
    //是否开启了http代理
    if ([[dictProxy objectForKey:@"HTTPEnable"] boolValue]) {
        return YES;
    }
    return  NO;
}
+(NSDictionary *)currentNetWorkDelegateInfo{
    CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
    NSDictionary *dictProxy = (__bridge_transfer id)proxySettings;
    //是否开启了http代理
    if ([[dictProxy objectForKey:@"HTTPEnable"] boolValue]) {
        CFBridgingRelease(proxySettings);
        return dictProxy;
    }
    return nil;
}
+ (NSString *)phoneOperatorName {
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    if (!carrier.isoCountryCode) {
        return nil;
    }
    return [carrier carrierName];
}
+ (NSString *)phoneISOCountryCode {
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    if (!carrier.isoCountryCode) {
        return nil;
    }
    return [carrier isoCountryCode];
    
}
+ (NSString *)phoneCountryCode {
    CTTelephonyNetworkInfo *info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    if (!carrier.isoCountryCode) {
        return nil;
    }
    return [carrier mobileCountryCode];
    
}






#pragma mark - VPNInfo 代理信息
+ (kDeviceLinkVPNStatus)currentDeviceLinkVpnSataus {
    NEVPNManager *vpnManage = [NEVPNManager sharedManager];
    [vpnManage loadFromPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    NEVPNConnection *connection = vpnManage.connection;
    
    kDeviceLinkVPNStatus status;
    switch (connection.status) {
        case NEVPNStatusInvalid:
            status = kDeviceLinkVPNStatusInvalid;
            break;
        case NEVPNStatusConnected:
            status = kDeviceLinkVPNStatusConnected;
            break;
        case NEVPNStatusConnecting:
            status = kDeviceLinkVPNStatusConnecting;
            break;
        case NEVPNStatusReasserting:
            status = kDeviceLinkVPNStatusReasserting;
            break;
        case NEVPNStatusDisconnected:
            status = kDeviceLinkVPNStatusDisconnected;
            break;
        case NEVPNStatusDisconnecting:
            status = kDeviceLinkVPNStatusDisconnecting;
            break;
        default:
            status = kDeviceLinkVPNStatusUnKnow;
            break;
    }
    return status;
}
+ (BOOL)isVPNConnected {
    NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSArray *keys = [dict[@"__SCOPED__"]allKeys];
    for (NSString *key in keys) {
        if ([key rangeOfString:@"tap"].location != NSNotFound ||
            [key rangeOfString:@"tun"].location != NSNotFound ||
            [key rangeOfString:@"ppp"].location != NSNotFound){
            return YES;
        }
    }
    return NO;
}








#pragma mark - JailBreak
//这里用多个判断方式判断，确保判断更加准确
+ (BOOL)isJailBreak {
    return [self p_judgeByOpenAppFolder] || [self p_judgeByOpenUrl] || [self p_judgeByFolderExists] || [self p_judgeByReadDYLD_INSERT_LIBRARIES];
}
//PrivateMethod
+ (BOOL)p_judgeByReadDYLD_INSERT_LIBRARIES {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    if (env) {
        return YES;
    }
    return NO;
}
//通过能否打开软件安装文件夹判断
+ (BOOL)p_judgeByOpenAppFolder {
    NSError *error;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSRange rang = [path rangeOfString:@"Application/"];
    NSString *appPath = [path substringToIndex:rang.location+ rang.length];
    if ([[NSFileManager defaultManager] fileExistsAtPath:appPath]) {
        NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:appPath error:&error];
        if (arr && [arr count]!=0) {
            return YES;
        }else {
            return NO;
        }
        
        return YES;
    }
    return NO;
}
//通过能否打开cydia：//来判断，YES说明可以打开，就是越狱的，NO表示不可以打开
+ (BOOL)p_judgeByOpenUrl {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return YES;
    }
    return NO;
}


//通过文件夹判断，如果boo为YES说明有以下的一些文件夹，则说明已经越狱
+ (BOOL)p_judgeByFolderExists {
    __block BOOL boo = NO;
    NSArray *arr = @[@"/Applications/Cydia.app",@"/Library/MobileSubstrate/MobileSubstrate.dylib",@"/bin/bash",@"/usr/sbin/sshd",@"/etc/apt"];
    [arr enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL *  stop) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:obj]) {
            boo = YES;
            *stop = YES;
        }
    }];
    return boo;
}




















#pragma mark - Other
+(NSString *)deviceVersion{
    //引入头文件#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

+(NSString *)iPhoneName{
    return [UIDevice currentDevice].name;
}
+(CGFloat)batteryLevel{
    return [UIDevice currentDevice].batteryLevel;
}
+(CGFloat)batteryCurrentLevel{
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
        //引入头文件#include <objc/runtime.h>
        Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
        id status  = object_getIvar(app, ivar);
        for (id aview in [status subviews]) {
            int batteryLevel = 0;
            for (id bview in [aview subviews]) {
                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0) {
                    
                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
                    if(ivar) {
                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
                        if (batteryLevel > 0 && batteryLevel <= 100) {
                            return batteryLevel;
                            
                        } else {
                            return 0;
                        }
                    }
                }
            }
        }
    }
    
    return 0;
}
+(NSString *)batteryState{
    UIDevice *device = [UIDevice currentDevice];
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return @"UnKnow";
    } else if (device.batteryState == UIDeviceBatteryStateUnplugged){
        return @"Unplugged";
    } else if (device.batteryState == UIDeviceBatteryStateCharging){
        return @"Charging";
    } else if (device.batteryState == UIDeviceBatteryStateFull){
        return @"Full";
    }
    return nil;
}
+(long long)memoryTotalSize{
    return [NSProcessInfo processInfo].physicalMemory;
}
+(long long)memoryAvailabelSize{
    //引入头文件#import <mach/mach.h>
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}
+(NSString *)systemName{
    return [UIDevice currentDevice].systemName;
}
+(NSString *)systemVersion{
    return [UIDevice currentDevice].systemVersion;
}
+(NSString *)systemLanguage{
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray objectAtIndex:0];
}
+(NSString *)UUID{
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}
+(NSString *)appName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}
+(NSString *)appBundleVersionShort{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+(NSString *)appBundleVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
+(NSString *)sessionID{
    NSString * akey = [[NSUserDefaults standardUserDefaults] stringForKey:kSessionId];
    [NSUserDefaults resetStandardUserDefaults];
    if (akey.length==0) {
        NSLog(@"DeviceHelp没有找到SessionID");
        //        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kSessionId];
        //        [NSUserDefaults resetStandardUserDefaults];
        return @"";
    }else{
        NSLog(@"DeviceHelp找到SessionID");
        [NSUserDefaults resetStandardUserDefaults];
        //        NSLog(@"the is -->%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]);
        return [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    }
}
+(NSString *)userAgent{
    NSMutableString *userAgent = [NSMutableString stringWithString:[[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
    return userAgent;
}
+(NSString *)myUserAgent{
    //User-Agent（用户代理）字符串是Web浏览器用于声明自身型号版本并随HTTP请求发送给Web服务器的字符串，在Web服务器上可以获取到该字符串。
    NSMutableString *userAgent = [NSMutableString stringWithString:[[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
    //根据网络类型设置不同的NetType标识
    /*
     iOS中判断网络状态一般用AFNetWorking中的方法：
     1.在appDelegate的application didFinishLaunchingWithOptions方法中启动网络状态监听：
     [[AFNetworkReachabilityManager sharedManager] startMonitoring];
     [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
     2.然后在基类BaseViewController中监听网络更新通知
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkReachabilityStatusDidChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
     - (void)networkReachabilityStatusDidChange:(NSNotification *)notify{
     NSLog(@"网络变化通知：%@",notify.userInfo[AFNetworkingReachabilityNotificationStatusItem]);
     AFNetworkReachabilityStatus status = [notify.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
     NSString *net = nil;
     switch (status) {
     case AFNetworkReachabilityStatusNotReachable:
     net = @"无网络";
     break;
     case AFNetworkReachabilityStatusReachableViaWiFi:
     net = @"WIFI";
     [self changeUserAgentWithType:@"WIFI"];
     break;
     case AFNetworkReachabilityStatusReachableViaWWAN:
     net = @"2G/3G/4G";
     [self changeUserAgentWithType:@"3G"];
     break;
     default:
     net = @"xxx";
     break;
     }
     [Error showError:[NSString stringWithFormat:@"当前网络状态%@",net]];
     }
     3.注意先判断userAgent中是否存在NetType
     //更新NetType
     - (void)changeUserAgentWithType:(NSString *)type{
     NSMutableString *userAgent = [NSMutableString stringWithString:[[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
     NSString *newUagent = nil;
     NSString *temp = nil;
     if ([userAgent containsString:@"NetType"]) {
     if ([userAgent containsString:@"WIFI"]) {
     temp = @"WIFI";
     }else if([userAgent containsString:@"3G"]){
     temp = @"3G";
     }
     newUagent = [userAgent stringByReplacingOccurrencesOfString:temp withString:type];
     }else{
     newUagent = [NSString stringWithFormat:@"%@ NetType/%@", userAgent, type];
     }
     NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newUagent, @"UserAgent", nil];
     
     NSLog(@"new useragent:%@",newUagent);
     [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
     }
     
     
     */
    
    NSString *newUAgent = [NSString stringWithFormat:@"%@ AppVersion/%@", userAgent, [Helper_Device appBundleVersionShort]];
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newUAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    return newUAgent;
}


- (float)getCpuUsage {
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    if (thread_count > 0)
        stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return 0;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    //    NSLog(@"CPU Usage: %f \n", tot_cpu);
    return tot_cpu;
}

+ (BOOL)isSIMInstalled {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    
    if (!carrier.isoCountryCode) {
        NSLog(@"No sim present Or No cellular coverage or phone is on airplane mode.");
        return NO;
    }
    return YES;
}


// 获取当前设备可用内存(单位：MB）
- (double)availableMem {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count + vm_page_size * vmStats.inactive_count) / 1024.0) / 1024.0 ;
}

// 获取当前任务所占用的内存（单位：MB）
- (double)usedMem {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

//获取总内存
-(long long)getTotalMemorySize {
    return [NSProcessInfo processInfo].physicalMemory / 1024.0 / 1024.0;
}

+ (NSString *) freeDiskSpaceInBytes{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return [self humanReadableStringFromBytes:freespace];
    
}
//手机总空间
+ (NSString *) totalDiskSpaceInBytes {
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    //    return freeSpace;
    return [self humanReadableStringFromBytes:freeSpace];
}

//遍历文件夹获得文件夹大小
+ (NSString *) folderSizeAtPath:(NSString*) folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return [self humanReadableStringFromBytes:folderSize];
}

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//计算文件大小
+ (NSString *)humanReadableStringFromBytes:(unsigned long long)byteCount {
    float numberOfBytes = byteCount;
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB",@"EB",@"ZB",@"YB",nil];
    
    while (numberOfBytes > 1024) {
        numberOfBytes /= 1024;
        multiplyFactor++;
    }
    return [NSString stringWithFormat:@"%4.2f %@",numberOfBytes, [tokens objectAtIndex:multiplyFactor]];
}

- (NSString *)batteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    float batteryLevel = [UIDevice currentDevice].batteryLevel;
    NSInteger ba = batteryLevel * 100;
    return [NSString stringWithFormat:@"%ld%@",(long)ba,@"%"];
    
}



- (NSString *)mobileOperator {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    return [carrier carrierName];
}

////获取本地的DNS IP
//+ (NSString *)domainNameSystemIp{
//    //#include <resolv.h>
//    res_state res = (res_state)malloc(sizeof(struct __res_state));
//    __uint32_t dwDNSIP = 0;
//    int result = res_ninit(res);
//    if (result == 0) {
//        dwDNSIP = res->nsaddr_list[0].sin_addr.s_addr;
//    }
//    free(res);
//    NSString *dns = [NSString stringWithUTF8String:inet_ntoa(res->nsaddr_list[0].sin_addr)];
//    //    NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys: dns, @"LocalDNS", nil];
//    return dns;
//}









@end


