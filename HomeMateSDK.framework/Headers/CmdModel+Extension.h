//
//  CmdModel+Extension.h
//  HomeMateSDK
//
//  Created by Air on 16/3/4.
//  Copyright © 2016年 Orvibo. All rights reserved.
//

#ifndef CmdModel_Extension_h
#define CmdModel_Extension_h

#import "CmdModel.h"


/**
 *  命令
 */
#import "RequestKeyCmd.h"               // 申请通信密钥
#import "ClockSyncCmd.h"                // 时钟同步
#import "AddCameraCmd.h"                // 创建摄像头
#import "ModifyCameraCmd.h"             // 修改摄像头


#import "StartLearningCmd.h"            // 开始学习红外码
#import "StopLearningCmd.h"             // 停止学习红外码
#import "DeleteIRCmd.h"                 // 删除红外码
#import "AddRemoteBindCmd.h"            // 添加遥控器绑定
#import "ModifyRemoteBindCmd.h"         // 修改遥控器绑定
#import "DeleteRemoteBindCmd.h"         // 删除遥控器绑定
#import "ResetCmd.h"                    // 恢复出厂设置
#import "CreateUserCmd.h"               // 创建子账户
#import "DeleteUserCmd.h"               // 删除子账户
#import "ModifyPasswordCmd.h"           // 修改用户密码
#import "RootTransferCmd.h"             // 超级权限转移


#import "AddInfraredKeyCmd.h"           // 创建自定义红外按键
#import "ModifyInfraredKeyCmd.h"        // 修改自定义红外按键
#import "DelInfraredKeyCmd.h"           // 删除自定义红外按键


#import "AddLinkageCmd.h"               // 添加联动任务
#import "SetLinkageCmd.h"               // 设置联动任务
#import "DeleteLinkageCmd.h"            // 删除联任务
#import "ActivateLinkageCmd.h"          // 激活联动任务
#import "DeleteVisitorRecordCmd.h"      // 删除开锁记录信息


// 到服务器
#import "InviteFamilyMemberCmd.h"       // 邀请家庭成员
#import "DeleteFamilyMemberCmd.h"       // 删除家庭成员
#import "FamilyMemberResponseCmd.h"     // 家庭成员邀请请求处理
#import "AuthorizedUnlockCmd.h"         // 授权开锁
#import "ResendAuthorizedSmsCmd.h"      // 重发授权短信
#import "AuthorizedCancelCmd.h"         // 取消授权
#import "SetDoorlockUserNameCmd.h"      // 设置门锁用户名称接口
#import "SetFrequentlyModeCmd.h"        // 设置设备常用模式


/**
 *  数据库表
 */


#import "HMPeopleLocation.h"            // 人员位置表
#import "HMStandardIr.h"                // 标准红外码表
#import "HMStandardIRDevice.h"          // 设备标准红外码表



#import "HMAlarmMessage.h"              // 报警记录表
#import "HMCameraInfo.h"                // 摄像头信息表

#import "HMClotheshorseCutdown.h"       // 晾衣架倒计时表
#import "HMClotheshorseStatus.h"        // 晾衣架状态表
//#import "HMGreetingsModel.h"            // 本地问候语表
//#import "HMTipsModel.h"                 // 安防提示语

#import "HMAuthorizedUnlockModel.h"     // 授权开锁表
#import "HMDoorUserModel.h"             // 门锁权限表
#import "HMDoorLockRecordModel.h"       // 开关门记录表

#import "HMDeviceDesc.h"                // 设备描述表
#import "HMDeviceLanguage.h"            // 设备语言包
#import "HMQrCodeModel.h"               // 二维码对照表

#import "HMAccreditPersonModel.h"       // 最近联系人 - 本地使用
#import "HMEnergySaveDeviceModel.h"     // 节能提醒设备表

#import "HMrStatusModel.h"              // 温湿度传感器实时状态表
#import "HMdStatusModel.h"              // 温湿度传感器天状态表
#import "HMmStatusModel.h"              // 温湿度传感器月状态表




#endif /* CmdModel_Extension_h */
