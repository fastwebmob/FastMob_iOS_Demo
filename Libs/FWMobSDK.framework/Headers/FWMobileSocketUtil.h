//
//  FWSocketProxy.h
//  FWMAASocket
//
//  Created by fastweb on 5/26/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol socketDelegate
/*!
	@function -(void)getSocketStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream success:(BOOL)success;
	@discussion 如果TCP鉴权成功(Success==true)之后，调用此委托方法。拿到NSInputStream 以及 NSOutputStream 完成TCP后续数据传输。
	@param
            success：TCP鉴权成功表示符
            NSInputStream：NSInputStream
            NSOutputStream：NSOutputStream
	@result
 */
-(void)getSocketStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream success:(BOOL)success;
@end
@interface FWMobileSocketUtil : NSObject<NSStreamDelegate>
@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;
@property (nonatomic, weak) id<socketDelegate> delegate;
/*!
	@function -(void)creatSocketWithDelegate:(id)mself;
	@discussion 利用回调对象创建socket
	@param      mself：socketDelegate协议回调对象
	@result
 */
-(void)creatSocketWithDelegate:(id)mself;
@end
