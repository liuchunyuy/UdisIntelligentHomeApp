//
//  PushInfoModel.h
//  HomeMate
//
//  Created by Air on 15/8/20.
//  Copyright (c) 2015年 Orvibo. All rights reserved.
//

#import "HMBaseModel.h"
#import "HMDevice.h"

@interface HMPushInfoModel : HMBaseModel

@property (nonatomic,assign) int            pushInfoId;
@property (nonatomic,strong) NSString *     messageId;
/**
 *  针对指定用户的推送信息
 */
@property (nonatomic,strong) NSString *     userId;

@property (nonatomic,assign) long long     serial;
@property (nonatomic,assign) int            infoType; //0：定时提醒 1：属性报告
@property (nonatomic,strong) NSString *     text;
@property (nonatomic,assign) int            action;
@property (nonatomic,assign) int            pageId;
@property (nonatomic,strong) NSString *     url;


/**
 *  定时类型 infoType为0
 */
@property (nonatomic,strong) NSString *     timingId;
@property (nonatomic,assign) int            status;
@property (nonatomic,strong) NSString *     deviceId;
@property (nonatomic,assign) int            time;
@property (nonatomic,strong) NSString *     bindOrder;
@property (nonatomic,assign) int            value1;
@property (nonatomic,assign) int            value2;
@property (nonatomic,assign) int            value3;
@property (nonatomic,assign) int            value4;

/**
 *  状态报告类型 infoType为1
 */

//@property (nonatomic,strong) NSString *     deviceId;
//@property (nonatomic,assign) int            value1;
//@property (nonatomic,assign) int            value2;
//@property (nonatomic,assign) int            value3;
//@property (nonatomic,assign) int            value4;
@property (nonatomic,assign) int            online;
@property (nonatomic,assign) int            alarmType;
@property (nonatomic,assign) int           deviceType;

/**
 *  某个定时任务处理结果
    当infoType为3时：
    status 0：表示暂停
    status 1：表示生效
 */

//@property (nonatomic,strong) NSString *     timingId;
//@property (nonatomic,assign) int            status;

/**
 *  打开/关闭某个（所有）设备的推送
    当infoType为4时：
    status 0：需要推送
    status 1：不需要推送
    如果此时deviceId为空值的话表示对所有设备都有效
 */

//@property (nonatomic,strong) NSString *     deviceId;
//@property (nonatomic,assign) int            status;

/**
 *  infoType为6
 *  邀请请求的id
 */
@property (nonatomic,strong) NSString *     inviteId;

/**
 *  infoType为7
 *  0：接受邀请
    1：拒绝邀请
 */
@property (nonatomic,assign) int            dealType;
/**
 *  非协议字段，标记此条数据是否已经读取
 */
@property (nonatomic,assign) int            isRead;

/**
 *  获取未读信息条数
 *
 *  @return int
 */
+ (int)  getUnreadMsgNum;
+ (int)  getAllMsgNum;
+ (BOOL) isHasSameDataWithSerial:(long long)serial;
+ (int)  dealTypeWithInviteId:(NSString *)inviteId;

/**
 *  删除相应设备的消息， 解绑设备时用，要传旧userId
 *
 *  @param decice
 *
 *
 */
+ (BOOL)deleteWifiMsgWithDevice:(HMDevice *)device;

/**
 *  删除相应设备的消息, app上删除设备时用，传当前userId
 *
 *  @param decice
 *
 *
 */
+ (BOOL)deleteMsgWithDeviceId:(NSString *)deciceId;

/**
 *  将所有消息都设置为已/未读
 *
 *  @param flag 0：未读 1：已读
 *
 */
+ (void)setMsgIsRead:(int)flag;

@end
