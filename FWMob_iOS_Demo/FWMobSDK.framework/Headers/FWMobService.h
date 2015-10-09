//
//  FWMobService.h
//  FastMobile
//
//  Created by Robin on 8/20/14.
//  Copyright (c) 2014年 Fastweb. All rights reserved.
//

#import <Foundation/Foundation.h>


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
            FWCompressionHigh：高
            FWCompressionMiddle：中
            FWCompressionLow：低
            FWCompressionOriginal：不压缩
            FWCompressionDefault：默认
	@result
 */
typedef NS_ENUM(NSInteger,FWCompressionLevel){
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
                    FWHttpCompressionOriginal：不压缩
                    FWHttpCompressionStrict：严格模式压缩
                    FWHttpCompressionNoStrict：非严格模式压缩
	@result
 */
typedef NS_ENUM(NSInteger,FWHttpCompressionMode){
    FWHttpCompressionOriginal,
    FWHttpCompressionStrict,
    FWHttpCompressionNoStrict,
};

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
+ (int) proxyPort;

/*!
	@function proxyHost
	@discussion 获取本地代理服务Host
	@param
	@result
 */

+ (NSString *) proxyHost;

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
	@function isRunning
	@discussion FastMob服务是否开启
	@param
	@result
 */

+ (BOOL)isRunning;

/*!
	@function setCompressionLevel
	@discussion 设置FastMob压缩级别
	@param 
            level:
                   H:高 M:中 L:低 O:不进行有损压缩 D:默认
	@result
 */
+ (void)setCompressionLevel:(FWCompressionLevel)level;

/*!
	@function setHttpHeadCompressionModel
	@discussion 设置Http头压缩模式
	@param
            level:
                  0:不压缩 1:严格压缩 2:非严格压缩
	@result
 */
+ (void)setHttpHeadCompressionModel:(FWHttpCompressionMode)mode;


@end