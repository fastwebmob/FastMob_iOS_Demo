//
//  FWMobileSocketUtil.h
//  FWMob
//
//  Created by Chris on 5/26/15.
//  Copyright (c) 2015 Fastweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FWMobInputStreamOutputStreamSocketDelegate
/*!
	@function -(void)getSocketStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream success:(BOOL)success;
	@discussion 如果TCP鉴权成功(Success==true)之后，调用此委托方法。拿到NSInputStream 以及 NSOutputStream 完成TCP后续数据传输。
	@param
            NSInputStream：NSInputStream
            NSOutputStream：NSOutputStream
	@result
 */
- (void)didGetFWMobSocketInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream;

/**
 * callback when get error ehen create socket connection
 * @param error: create socket connection error
 */
- (void)didGetFWMobSocketError:(NSError *)error;
@end

@interface FWMobileSocketUtil : NSObject

/**
 * for ObjC native NSInputStream, NSOutputStream
 */
+ (void)createConnectedInputStreamOutputStreamSocketWithDelegate:(id<FWMobInputStreamOutputStreamSocketDelegate>)delegate;

/**
 * for ObjC native NSInputStream, NSOutputStream
 */
+ (void)createConnectedSocketWithDelegate:(id<FWMobInputStreamOutputStreamSocketDelegate>)delegate connectToHost:(NSString*)hostname onPort:(UInt16)port;

#pragma mark -- for GCDAsyncSocket
/**
 * for 3rd lib GCDAsyncSocket, to get GCDAsyncSocket instance
 * @param delegate: GCDAsyncSocketDelegate
 * @return GCDAsyncSocket
 */
+ (id)createConnectedGCDAsyncSocketWithDelegate:(id)delegate;

/**
 * for 3rd lib GCDAsyncSocket, action of connect server
 * @param gcdAsyncSocket: GCDAsyncSocket
 * @param delegate: GCDAsyncSocketDelegate
 * @param host: socket host
 * @param port: socket port
 * @param errPtr: connect socket error
 * @return This method will return NO if an error is detected, and set the error pointer (if one was given).
 * Possible errors would be a nil host, invalid interface, or socket is already connected.
 */
+ (BOOL)gcdAsyncSocket:(NSObject *)gcdAsyncSocket delegate:(NSObject *)delegate connectToHost:(NSString *)host onPort:(uint16_t)port error:(NSError **)errPtr;

/**
 * for 3rd lib GCDAsyncSocket, action of connect server
 * @param gcdAsyncSocket: GCDAsyncSocket
 * @param delegate: GCDAsyncSocketDelegate
 * @param host: socket host
 * @param port: socket port
 * @param timeout: socket timeout
 * @param errPtr: connect socket error
 * @return This method will return NO if an error is detected, and set the error pointer (if one was given).
 * Possible errors would be a nil host, invalid interface, or socket is already connected.
 */
+ (BOOL)gcdAsyncSocket:(NSObject *)gcdAsyncSocket delegate:(NSObject *)delegate connectToHost:(NSString *)host onPort:(uint16_t)port withTimeout:(NSTimeInterval)timeout error:(NSError **)errPtr;


#pragma mark -- for AsyncSocket
/**
 * for 3rd lib AsyncSocket, to get AsyncSocket instance
 * @param delegate: AsyncSocketDelegate
 * @return AsyncSocket
 */
+ (id)createConnectedAsyncSocketDelegate:(id)delegate;

/**
 * for 3rd lib AsyncSocket, action of connect server
 * @param asyncSocket: AsyncSocket
 * @param delegate: AsyncSocketDelegate
 * @param host: socket host
 * @param port: socket port
 * @param errPtr: connect socket error
 * @return This method will return NO if an error is detected, and set the error pointer (if one was given).
 * Possible errors would be a nil host, invalid interface, or socket is already connected.
 */
+ (BOOL)asyncSocket:(NSObject *)asyncSocket delegate:(NSObject *)delegate connectToHost:(NSString*)hostname onPort:(UInt16)port error:(NSError **)errPtr;

/**
 * for 3rd lib AsyncSocket, action of connect server
 * @param asyncSocket: AsyncSocket
 * @param delegate: AsyncSocketDelegate
 * @param host: socket host
 * @param port: socket port
 * @param timeout: socket timeout
 * @param errPtr: connect socket error
 * @return This method will return NO if an error is detected, and set the error pointer (if one was given).
 * Possible errors would be a nil host, invalid interface, or socket is already connected.
 */
+ (BOOL)asyncSocket:(NSObject *)asyncSocket delegate:(NSObject *)delegate connectToHost:(NSString*)hostname onPort:(UInt16)port withTimeout:(NSTimeInterval)timeout error:(NSError **)errPtr;

@end
