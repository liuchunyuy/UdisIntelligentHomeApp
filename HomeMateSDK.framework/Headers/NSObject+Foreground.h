//
//  NSObject+Foreground.h
//  Vihome
//
//  Created by Air on 15/5/19.
//  Copyright (c) 2015年 orvibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Foreground)

-(void)startNotifierForeground:(SEL)foreground;
-(void)startNotifierBackground:(SEL)background;
-(void)startNotifierForeground:(SEL)foreground background:(SEL)background;

-(void)stopForegroundNotifier;
-(void)stopBackgroundNotifier;
-(void)stopForegroundBackgroundNotifier;
@end
