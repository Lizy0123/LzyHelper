//
//  Helper_Device.h
//  DeviceHelp
//
//  Created by Lzy on 2017/10/23.
//  Copyright © 2017年 Lzy. All rights reserved.
//
/**
 *  StudyFrom:WebSearch
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"

#define kSessionId @"sessionId"
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

#define kiOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)



@interface Helper_Device : NSObject

/**
 能否打电话，1不能？
 */
@property (nonatomic, assign, readonly) BOOL canMakePhoneCall NS_EXTENSION_UNAVAILABLE_IOS("");

/**
 单例实例化一个当前对象
 
 @return 返回当前的对象
 */
+(instancetype)sharedInstance;
#pragma mark - System 系统
/**
 当前系统名称
 
 @return iOS
 */
-(NSString *)systemName;

/**
 当前系统版本
 
 @return 系统版本 @"4.0"
 */
-(NSString *)systemVersion;

/**
 设备重启时间
 
 @return 设备重启时间
 */
-(NSDate *)systemUptime;
/**
 是否支出多任务
 
 @return YES支持，NO不支持
 */
-(BOOL)isMultitaskSupported;

/**
 XNU内核版本号
 
 @return XNU内核版本号
 */
-(NSString *)kernelVersion;

/**
 内核描述信息
 
 @return 内核描述信息
 */
-(NSString *)kernelBuildDescription;

/**
 硬件类行
 
 @return 硬件类行 例：iPhone8.1
 */
-(NSString *)hardwareType;

/**
 当前操作系统名称
 
 @return 内核操作系统名称
 */
-(NSString *)OSName;

/**
 网络节点名称
 
 @return 网络节点名称
 */
-(NSString *)netNodeName;




#pragma mark - Device 设备
/**
 获取苹果的model 例：iPhone5,2
 
 @return Model
 */
-(NSString *)deviceModel;

/**
 手机类型 例：iPhone6
 
 @return 手机类型名称
 */
-(NSString *)deviceType;


/**
 手机类型 例：@"iPhone", @"iPod touch"
 
 @return @"iPhone", @"iPod touch"
 */
-(NSString *)deviceTypeShort;

/**
 手机名字
 
 @return 手机名称
 */
-(NSString *)deviceName;

/**
 UUID 例：B91AEE90-4B1E-468E-8999-E9B4A66B5EA1
 
 @return UUID
 */
-(NSString *)deviceUUID;
/**
 广告位标识符：在同一个设备上的所有App都会取到相同的值，是苹果专门给各广告提供商用来追踪用户而设的，用户可以在 设置|隐私|广告追踪里重置此id的值，或限制此id的使用，故此id有可能会取不到值，但好在Apple默认是允许追踪的，而且一般用户都不知道有这么个设置，所以基本上用来监测推广效果，是戳戳有余了
 
 @return IDFA
 */
-(NSString *)deviceIDFA;
-(NSString *)deviceIDFV;
-(NSString *)deviceLocalizeModel;
+(NSString *)deviceID;
/**
 设备核数
 
 @return 核数
 */
-(NSInteger)nuclearCount;

/**
 当前设备活跃核数
 
 @return 核数
 */
-(NSInteger)nuclearActiveCount;




#pragma mark - Location位置信息
typedef void(^ChangeLocationBlock) (CLPlacemark *location,NSString *desc);
/**
 *  block回调
 */
@property (nonatomic,copy)ChangeLocationBlock blockLocation;

/**
 得到设备当前的位置,block回调里面已经包含了CLPlacemark里面包含了你需要的信息，需要自取
 *  详细可以参考CLPlacemark类属性
 
 @param block CLLocation
 */
- (void)location:(ChangeLocationBlock)block;




#pragma mark - mark Project工程
/**
 项目版本
 
 @return 当前版本
 */
-(NSString *)appVersion;

/**
 项目构建版本
 
 @return 项目构建版本
 */
-(NSString *)appBuildVersion;

/**
 项目名称
 
 @return 项目名称
 */
-(NSString *)appName;



#pragma mark - MemoryStorage内存
typedef NS_ENUM(NSInteger, kStorageSizeType){
    StorageSizeTypeOrinin = 2,//原始内存数据
    StorageSizeTypeNormalized //规格化后的内存数据
};

/**
 当前磁盘总大小
 
 @param type StorageSizeTypeOrinin 原始大小，单位为B; StorageSizeTypeNormalized 规格化后大小，
 @return 磁盘大小，不是特别准确，还行
 */
-(NSString *)storageDiskTotalSize:(kStorageSizeType)type;

/**
 当前物理内存总大小，通过物理内存获得总大小
 
 @param type StorageSizeTypeOrinin 原始大小，单位为B; StorageSizeTypeNormalized 规格化后大小，
 @return 物理内存总大小
 */
-(NSString *)memoryTotalSiz:(kStorageSizeType)type;




/**
 当前磁盘已使用大小
 
 @param type StorageSizeTypeOrinin 原始大小，单位为B; StorageSizeTypeNormalized 规格化后大小，
 @return 磁盘已使用大小
 */
-(NSString *)storageDiskUsedSize:(kStorageSizeType)type;

/**
 当前物理内存已使用大小
 
 @param type StorageSizeTypeOrinin 原始大小，单位为B; StorageSizeTypeNormalized 规格化后大小，
 @return 物理内存已使用大小
 */
//-(NSString *)memoryUsedSize:(kStorageSizeType)type;



/**
 当前磁盘空闲大小
 
 @param type StorageSizeTypeOrinin 原始大小，单位为B; StorageSizeTypeNormalized 规格化后大小，
 @return 磁盘空闲大小，不是特别准确，还行
 */
-(NSString *)storageDiskFreeSize:(kStorageSizeType)type;

/**
 当前物理内存空闲大小
 
 
 @param type StorageSizeTypeOrinin 原始大小，单位为B; StorageSizeTypeNormalized 规格化后大小，
 @return 物理内存已空闲大小
 */
//-(NSString *)memoryFreeSize:(kStorageSizeType)type;

/**
 获取本 App 所占磁盘空间
 */
- (NSString *)appSize;

/**
 获取磁盘总空间
 */
- (int64_t)totalDiskSpace;

/**
 获取未使用的磁盘空间
 */
- (int64_t)freeDiskSpace;

/**
 获取已使用的磁盘空间
 */
- (int64_t)usedDiskSpace;

/**
 获取总内存空间
 */
- (int64_t)totalMemory;

/**
 获取活跃的内存空间
 */
- (int64_t)activeMemory;

/**
 获取不活跃的内存空间
 */
- (int64_t)inActiveMemory;

/**
 获取空闲的内存空间
 */
- (int64_t)freeMemory;

/**
 获取正在使用的内存空间
 */
- (int64_t)usedMemory;

/**
 获取存放内核的内存空间
 */
- (int64_t)wiredMemory;

/**
 获取可释放的内存空间
 */
- (int64_t)purgableMemory;


#pragma mark - CPU
- (NSUInteger)CPUFrequency;

/**
 获取总线程频率
 */
- (NSUInteger)BusFrequency;

/**
 获取当前设备主存
 */
- (NSUInteger)RamSize;

/**
 获取CPU数量
 */
- (NSUInteger)CPUCount;

/**
 获取CPU总的使用百分比
 */
- (float)CPUUsage;

/**
 获取单个CPU使用百分比
 */
- (NSArray *)perCPUUsage;



#pragma mark - Battery电池
typedef NS_ENUM(NSInteger, kBatteryState){
    kBatteryStateUnknow,
    kBatteryStateUnplugged, //未充电
    kBatteryStateCharging,  //正在充电
    kBatteryStateFull       //充满电
};

/**
 是否允许监控电池
 
 @return YES：允许 NO：不允许
 */
-(BOOL)isAllowMonitorBattery;


/**
 当前电池电量
 
 @return 0-1
 */
-(CGFloat)batteryCurrentLevel;

/**
 电池状态
 
 @return 未充电、正在充电、充满电
 */
-(kBatteryState)batteryState;





#pragma mark - mark Screen屏幕
/**
 获取屏幕宽度
 
 @return 屏幕宽度
 */
-(CGFloat)screenWidth;
/**
 获取屏幕高度
 
 @return 屏幕高度
 */
-(CGFloat)screenHeight;
/**
 获取屏幕亮度
 
 @return 0-1
 */
-(CGFloat)screenBrightness;
/**
 获取屏幕dpi
 
 @return dpi
 */
-(CGFloat)screenDPI;
/**
 获取屏幕分辨率
 
 @return 屏幕分辨率
 */
-(NSString *)screenResolution;






#pragma mark - NetWork网络
typedef NS_ENUM(NSInteger, kNetWorkReachState){
    kNetWorkReachStatusUndefine,    //未定义
    kNetWorkReachStatusNoConnect,   //未连接
    kNetWorkReachStatusWifi,        //Wifi
    kNetWorkReachStatusCellular     //蜂窝移动网络
};
/**
 当前设备是否联网
 
 @return YES：联网 NO：未联网
 */
-(BOOL)isConnectNetWork;

/**
 当前网络状态-返回kNetWorkReachState
 
 @return kNetWorkStatus
 */
-(kNetWorkReachState)netWorkStatus;
/**
 当前网络状态-返回NSString
 
 @return NSString
 */
-(NSString *)netWorkType;
/**
 当前Wifi列表（只能得到当前链接信息）
 
 @return 只能得到当前链接信息
 */
-(NSMutableArray *)wifiListArray;
/**
 WiFi名称
 
 @return  WiFi名称
 */
+ (NSString *)wifiName;
/**
 获取IP地址（获取的既不是公网也不是Wifi，不知道为什么，用别的方法吧）
 
 @return 返回IP地址
 */
-(NSString *)IPAddress;

/**
 获取Wifi的IP地址
 
 @return WifiIP
 */
-(NSString *)IPAddressWifi;

/**
 获取蜂窝IP
 
 @return 蜂窝IP
 */
-(NSString *)IPAddressCellular;
/**
 获取WifiIP简便方法
 
 @return WifiIP
 */
-(NSString *)IPAddressWifiShort;

/**
 获取公网IP
 
 @return 公网IP
 */
-(NSString *)IPAddressOpenNet;

/**
 获取公网IP另外一个方法
 
 @return 公网IP
 */
-(NSString *)IPAddressOpenNetAnother;

/**
 是否链接了代理
 
 @return YES：连接了代理 NO：没有链接代理
 */
+(BOOL)isConnectDelegate;

/**
 当前代理配置
 
 @return 如果没有代理链接，返回nil
 */
+(NSDictionary *)currentNetWorkDelegateInfo;
/**
 得到当前手机所属运营商名称，如果没有则为nil
 
 @return 返回运营商名称
 */
+ (NSString *)phoneOperatorName;


/**
 得到当前手机号的国家代码,如果没有则为nil
 
 @return 返回国家代码
 */
+ (NSString *)phoneISOCountryCode;

/**
 得到移动国家码
 
 @return 返回移动国家码
 */
+ (NSString *)phoneCountryCode;



#pragma mark - VPNInfo 代理信息
/**
 device link vpn status
 
 - DeviceLinkVPNStatusInvalid: The VPN is not configured.
 - DeviceLinkVPNStatusDisconnected: The VPN is disconnected.
 - DeviceLinkVPNStatusConnecting: The VPN is connecting.
 - DeviceLinkVPNStatusConnected: The VPN is connected.
 - DeviceLinkVPNStatusReasserting: The VPN is reconnecting following loss of underlying network connectivity.
 - DeviceLinkVPNStatusDisconnecting: The VPN is disconnecting.
 */
typedef NS_ENUM(NSInteger, kDeviceLinkVPNStatus) {
    kDeviceLinkVPNStatusInvalid = 201,
    kDeviceLinkVPNStatusDisconnected,
    kDeviceLinkVPNStatusConnecting,
    kDeviceLinkVPNStatusConnected,
    kDeviceLinkVPNStatusReasserting,
    kDeviceLinkVPNStatusDisconnecting,
    kDeviceLinkVPNStatusUnKnow
};
/**
 get current link vpn status
 
 @return devicelinkvpnstatus
 */
+ (kDeviceLinkVPNStatus)currentDeviceLinkVpnSataus;

/**
 judge device connected vpn or not
 
 @return YES:Connected,NO:not connected
 */
+ (BOOL)isVPNConnected;






#pragma mark - JailBreak是否越狱
+(BOOL)isJailBreak;

































#pragma mark - Other

/**
 设备的版本号
 */
+(NSString *)deviceVersion;

/**
 iPhone名字
 */
+(NSString *)iPhoneName;
/**
 电池电量
 */
+(CGFloat)batteryLevel;
/**
 电池精准电量
 */
+(CGFloat)batteryCurrentLevel;
/**
 电池状态（共4中状态UnKnow、Unplugged、Charging、Full）
 */
+(NSString *)batteryState;
/**
 内存总大小
 */
+(long long)memoryTotalSize;
/**
 内存当前可用大小
 */
+(long long)memoryAvailabelSize;
/**
 系统名称
 */
+(NSString *)systemName;
/**
 系统版本号
 */
+(NSString *)systemVersion;
/**
 系统当前语言
 */
+(NSString *)systemLanguage;
/**
 通用唯一识别码
 */
+(NSString *)UUID;
/**
 App的名字
 */
+(NSString *)appName;
/**
 App外部版本号
 */
+(NSString *)appBundleVersionShort;
/**
 App内部版本号
 */
+(NSString *)appBundleVersion;
/**
 获取sessionID（没有返回@""）
 */
+(NSString *)sessionID;
/**
 UserAgent
 */
+(NSString *)userAgent;
/**
 MyUserAgent
 */
+(NSString *)myUserAgent;


+ (NSString *)freeDiskSpaceInBytes;//手机剩余空间（磁盘）
+ (NSString *)totalDiskSpaceInBytes;//手机总空间（磁盘）
+ (NSString *)folderSizeAtPath:(NSString*) folderPath;//某个文件夹占用空间的大小
+ (BOOL)isSIMInstalled;//是否有sim卡
- (float)getCpuUsage;//CPU使用率

///**
// DNS
//
// @return DNS
// */
//+ (NSString *)domainNameSystemIp;

@end


