//
//  VhAPSocket.h
//  HomeMateSDK
//
//  Created by Orvibo on 15/8/6.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol VhApSocketDelegate <NSObject>
- (void)onDeliverData:(NSData *)data;
- (void)didConnected;
- (void)onConnectTimeout;
- (void)onDisconnectWithError:(NSError *)err;
@end

@interface HMAPSocket : NSObject

- (instancetype)initWithDelegate:(id <VhApSocketDelegate>)delegate;
- (void)connectToHost;
- (void)sendData:(NSData *)binaryData;
- (void)disconnectSocket;
- (BOOL)isConnectedToCOCO;
@end
