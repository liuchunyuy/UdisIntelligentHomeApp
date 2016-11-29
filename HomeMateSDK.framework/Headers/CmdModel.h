/*HM CMD*/

#import "HMDatabaseManager.h"

// 局域网广播

#import "QueryGatewayCmd.h"             // UDP 查找网关


// 客户端到server/主机

#import "LoginCmd.h"                    // 登录
#import "QueryStatisticsCmd.h"          // 查询统计信息
#import "QueryDataCmd.h"                // 查询表数据
#import "HeartbeatCmd.h"                // 心跳包

// (对于zigbee设备可以在局域网直接发给zigbee主机或者发到server由server转发给zigbee主机，对于AP配置的WIFI设备则只能发送到server)

#import "ControlDeviceCmd.h"            // 设备控制（zigbee设备和WIFI设备通用）
#import "AddTimerCmd.h"                 // 添加定时任务
#import "ModifyTimerCmd.h"              // 修改定时任务
#import "ActiveTimerCmd.h"              // 激活定时任务
#import "DeleteTimerCmd.h"              // 删除定时任务

#import "AddCountdownCmd.h"             // 创建倒计时
#import "ModifyCountdownCmd.h"          // 修改倒计时
#import "DeleteCountdownCmd.h"          // 删除倒计时
#import "ActivateCountdownCmd.h"        // 激活/暂停倒计时
#import "ReturnCmd.h"                   // 客户端确认接收到指令命令
// 客户端到zigbee主机（局域网）

#import "gatewayBindCmd.h"              // 绑定主机（局域网绑定zigbee主机）
#import "DeviceSearchCmd.h"             // 设备搜索（zigbee主机搜索zigbee设备）
#import "AddFloorCmd.h"                 // 添加楼层
#import "ModifyFloorCmd.h"              // 修改楼层
#import "DeleteFloorCmd.h"              // 删除楼层
#import "AddRoomCmd.h"                  // 添加房间
#import "ModifyRoomCmd.h"               // 修改房间
#import "DeleteRoomCmd.h"               // 删除房间
#import "AddFloorRoomCmd.h"             // 同时添加楼层房间接口

#import "ModifyDeviceCmd.h"             // 修改设备信息（zigbee设备）
#import "DeleteDeviceCmd.h"             // 删除设备
#import "AddSceneCmd.h"                 // 添加情景
#import "ModifySceneCmd.h"              // 修改情景
#import "DeleteSceneCmd.h"              // 删除情景
#import "AddSceneBindCmd.h"             // 添加情景绑定
#import "ModifySceneBindCmd.h"          // 修改情景绑定
#import "DeleteSceneBindCmd.h"          // 删除情景绑定
#import "AddDeviceCmd.h"                // 创建设备

// 客户端到server

#import "LogoffCmd.h"                   // 退出登录

#import "DeviceBindCmd.h"               // 绑定设备（AP配置的WIFI设备）
#import "DeviceUnbindCmd.h"             // 解绑设备（AP配置的WIFI设备和zigbee主机）
#import "ServerModifyDeviceCmd.h"       // 修改设备信息（AP配置的WIFI设备）
#import "TokenReportCmd.h"              // 向服务器上报Token
#import "ModifyHomeNameCmd.h"           // 修改家庭名称
#import "SecurityCmd.h"                 // 布撤防命令
#import "ReadedMsgNumCmd.h"             // 已读信息条数上报
#import "SensorPushCmd.h"               // 传感器推送设置

// 客户端到server - 注册-登录-密码修改模块

#import "GetSmsCmd.h"                   // 获取手机验证码
#import "CheckSmsCmd.h"                 // 校验短信验证码
#import "RegisterCmd.h"                 // 用户注册
#import "ResetPasswordCmd.h"            // 重置密码（无旧密码，即忘记密码后重置密码）
#import "ServerModifyPasswordCmd.h"     // 修改登录密码（有旧密码，修改为新密码）
#import "SetNicknameCmd.h"              // 设置用户昵称
#import "GetEmailCodeCmd.h"             // 获取邮箱验证码
#import "CheckEmailCodeCmd.h"           // 校验邮箱验证码
#import "UserBindCmd.h"                 // 绑定手机号或邮箱

/**
 *  数据库表
 */

#import "HMAccount.h"                   // 账号表
#import "HMAuthority.h"                 // 权限表
#import "HMUserGatewayBind.h"           // 绑定关系表
#import "HMDevice.h"                    // 设备信息表
#import "HMDeviceJoinIn.h"              // 设备入网信息表
#import "HMDeviceStatus.h"              // 设备状态表
#import "HMRoom.h"                      // 房间表
#import "HMFloor.h"                     // 楼层表
#import "HMGateway.h"                   // 网关表
#import "HMScene.h"                     // 情景表
#import "HMSceneBind.h"                 // 情景绑定表
#import "HMTiming.h"                    // 定时表
#import "HMCountdownModel.h"            // 倒计时表
#import "HMPushInfoModel.h"             // 推送消息表
#import "HMLocalAccount.h"              // 本地账号表
#import "HMDevicesBind.h"               // 远程登录时返回的绑定列表
#import "HMLinkage.h"                   // 联动表
#import "HMLinkageOutput.h"             // 联动输出表
#import "HMLinkageCondition.h"          // 联动条件表
#import "HMRemoteBind.h"                // 遥控器绑定表
#import "HMDeviceIr.h"                  // 设备红外码表
#import "HMVersionModel.h"              // 数据库版本号表
#import "HMCameraInfo.h"                // 摄像头信息表
#import "HMFrequentlyModeModel.h"       // 设备常用模式表
#import "HMMessagePush.h"               // 推送开关表
#import "HMCommonDeviceModel.h"         // 常用设备表
#import "HMSecurity.h"                  // 安防模式表