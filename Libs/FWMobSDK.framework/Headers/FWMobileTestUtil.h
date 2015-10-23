//
//  FWMobileTestUtil.h
//  FastMobile
//
//  Created by fastweb on 8/12/15.
//  Copyright (c) 2015 Fastweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWMobileTestUtil : NSObject
/*!
	@function testSimulatorNetwork
	@discussion 模拟当前网络环境
	@param netWorkMode：2G 3G 4G
	@result
 */
+(void)testSimulatorNetwork:(int)netWorkMode;
/*!
	@function getCurrentUrlLoadData
	@discussion 获取当前页面加载总数据量
	@param
	@result  返回当前页面加载总数据量（单位：B）
 */
+(float)getCurrentUrlLoadData;
/*!
	@function getCurrentUrlLoadTime
	@discussion 获取当前页面加载总时间
	@param
	@result  返回当前页面加载总时间（单位s 数据类型浮点型）
 */
+(float)getCurrentUrlLoadTime;
/*!
	@function clearDataAndTime
	@discussion 清楚当前页面的 数据加载时间 数据加载大小
	@param
	@result
 */
+(void)clearDataAndTime;
/*!
	@function setSimulateNetwork
	@discussion 设置当前手机模拟制式
	@param
            network：WCDMA
	@result
 */
+(void)setSimulateNetwork:(NSString*)network;
/*!
	@function getCurrentNetWorkType
	@discussion 获取当前手机网络状态
	@param
	@result
            such as：电信3G
            return： WCDMA
 */
+(NSString*)getCurrentNetWorkType;
/*!
	@function setHttpHeadOpt
	@discussion http head 压缩是否开启开关
	@param 
            flag：
                true: 开启压缩 false：关闭压缩
	@result
 */
+(void)setHttpHeadOpt:(BOOL)flag;
/*!
	@function deviceString
	@discussion 获取设备类型
	@param
	@result
        such as：iPhone 6 Plus
        return：iPhone 6 Plus
 */
+(NSString*)deviceString;
/*!
	@function deviceResolution
	@discussion 获取设备分辨率
	@param
	@result 
            such as：5s 
            return：320*568
 */
+(NSString*)deviceResolution;
/*!
	@function httpAcclerateSwitch
	@discussion 加速功能是否开启
	@param
        flag:
            true:开始加速功能 false:关闭加速功能
	@result
 */
+(void)httpAcclerateSwitch:(BOOL)flag;
@end
