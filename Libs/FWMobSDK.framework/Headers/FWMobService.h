//
//  FWMobService.h
//  FastMobile
//
//  Created by Robin on 8/20/14.
//  Copyright (c) 2014年 Fastweb. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
	@discussion FastMob http tcp服务状态
	@param
        FWMobServiceStatus：
        FWMobServiceStatusInit：初始化
        FWMobServiceStatusSuccessful：成功
        FWMobServiceStatusStopped：停止
        FWMobServiceStatusFailed：失败
 */
typedef NS_ENUM(NSInteger, FWMobServiceStatus) {
    FWMobServiceStatusInit = 0,
    FWMobServiceStatusSuccessful = 1,
    FWMobServiceStatusStopped = 2,
    FWMobServiceStatusFailed = -1,
};


@protocol FWMobServiceStatusDelegate <NSObject>
@optional
/*!
	@discussion http service状态改变回调
 */
- (void)didGetHttpServiceStatus:(FWMobServiceStatus)status;
/*!
	@discussion tcp service状态改变回调
 */
- (void)didGetTcpServiceStatus:(FWMobServiceStatus)status;
@end

/*!
	@discussion FastMob内容层压缩等级
	@param
    FWLoglevel：
        FWLogDisable：不显示log
        FWLogError：错误及以上
        FWLogWarn：警告及以上
        FWLogInfo：信息及以上
        FWLogDebug：调试及以上
        FWLogVerbose：冗余及以上
	@result
 */
typedef NS_ENUM(NSInteger, FWLoglevel) {
    FWLogVerbose,
    FWLogDebug,
    FWLogInfo,
    FWLogWarn,
    FWLogError,
    FWLogDisable = INT_MAX
};

/*!
	@discussion FastMob内容层压缩等级
	@param
            FWCompressionLevel：
            FWCompressionWebp：Webp压缩
            FWCompressionHigh：高
            FWCompressionMiddle：中
            FWCompressionLow：低
            FWCompressionOriginal：不压缩
            FWCompressionDefault：默认
	@result
 */
typedef NS_ENUM(NSInteger,FWCompressionLevel){
    FWCompressionWebp,
    FWCompressionHigh,
    FWCompressionMiddle,
    FWCompressionLow,
    FWCompressionOriginal,
    FWCompressionDefault,
};

/*!
	@discussion Http header 压缩模式
	@param
            FWHttpCompressionLevel：
                    FWHttpHeaderCompressionOriginal：不压缩
                    FWHttpHeaderCompressionStrict：严格模式压缩
                    FWHttpHeaderCompressionNoStrict：非严格模式压缩
	@result
 */
typedef NS_ENUM(NSInteger,FWHttpHeaderCompressionMode){
    FWHttpHeaderCompressionOriginal,
    FWHttpHeaderCompressionStrict,
    FWHttpHeaderCompressionNoStrict,
};

#define FW_FM_NETWORK_CHANGE_NOTIFICATION           @"FastMobileNetworkChangeNotification"
#define FW_FM_DATASIZE_NOTIFICATION                 @"FastMobileDataSizeNotification"
#define FW_FM_DATASIZE_NOTI_KEY                     @"FastMobileDataSizeNotiKey"

@interface FWMobService : NSObject
/*!
	@function start
	@discussion 开启FastMob服务
	@param 
            key: APP应用加速服务key
	@result
 */
+ (void)start:(NSString *)key;

/*!
	@function stop
	@discussion 关闭FastMob服务
	@param
	@result
 */
+ (void)stop;

/*!
	@function delayStopWithTime
	@discussion 延时关闭FastMob服务
	@param time:NSTimeInterval
	@result
 */
+ (void)delayStopWithTime:(NSTimeInterval)time;

/*!
	@function proxyPort
	@discussion 获取本地代理服务Port
	@param
	@result
 */
+ (int)proxyPort;

/*!
	@function proxyHost
	@discussion 获取本地代理服务Host
	@param
	@result
 */

+ (NSString *)proxyHost;

/*!
	@function debugOn
	@discussion debug模式是否开启
	@param
            on: 
                YES: 开启debug NO: 关闭debug
	@result
 */
+ (void)debugOn:(BOOL)on;

/*!
	@function setDebugLogLevel
	@discussion 设置debug信息级别
	@param
        FWLoglevel:
            logLevel, default is FWLogDisable
	@result
 */
+ (void)setDebugLogLevel:(FWLoglevel)logLevel;

/*!
	@result FastMob HTTP服务状态
 */
+ (FWMobServiceStatus)httpServiceStatus;

/*!
	@result FastMob TCP服务状态
 */
+ (FWMobServiceStatus)tcpServiceStatus;

/*!
	set status delegate (http and tcp)
	@param delegate: FWMobServiceStatusDelegate
 */
+ (void)setServiceDelegate:(id<FWMobServiceStatusDelegate>)delegate;

/*!
	@function isHttpServiceRunning
	@discussion FastMob HTTP服务是否开启
	@result
 */
+ (BOOL)isHttpServiceRunning;

/*!
	@function isTcpServiceRunning
	@discussion FastMob TCP服务是否开启
	@result
 */
+ (BOOL)isTcpServiceRunning;

/*!
	@function setHttpHeadCompressionModel
	@discussion 设置Http头压缩模式
	@param
            level:
                  0:不压缩 1:严格压缩 2:非严格压缩
	@result
 */
+ (void)setHttpHeaderCompressionMode:(FWHttpHeaderCompressionMode)mode;

/*!
	@function enableAccelerate
	@discussion 加速功能是否开启
	@param
 flag:
 true:开始加速功能 false:关闭加速功能
	@result
 */
+(void)enableAccelerate:(BOOL)flag;

@end
