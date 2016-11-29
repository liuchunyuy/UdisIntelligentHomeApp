//
//  Notifications.h
//  Vihome
//
//  Created by Ned on 1/20/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#ifndef Vihome_Notifications_h
#define Vihome_Notifications_h

/**
 *  网络状态变化通知
 */
#define NOTIFICATION_NETWORKSTATUS_CHANGE           @"notificationNetworkStatusChange"

#define APNOTIFICATION_NETWORKSTATUS_CHANGE         @"apnotificationNetworkStatusChange"
/**
 *                                                    网络状态变化时用于通知界面网络故障的通知
 *
 */
#define NOTIFICATION_NETWORKSTATUS_CHANGE_FOR_BANNER @"notificationNetworkStatusChangeForBanner"

#define kNOTIFICATION_AUTO_DISAPPEAR_LOADING @"auto_disappear_loading" // loading view 自动消失
#define kNOTIFICATION_SEARCH_MDNS_RESULT @"search_mdns_result"         // 搜索mdns后发出通知

/**
 *  登录成功后，或者绑定成功后，显示带有tabbar的主界面
 */

/**
 *  新设备上报接口的通知
 */
#define kNOTIFICATION_NEW_DEVICE_REPORT @"new_device_report"

/**
 *  设备属性报告接口
 */
#define kNOTIFICATION_DEVICE_STATUS_REPORT @"device_status_report"

/**
 *  设备修改房间后刷新主界面设备列表
 */
#define KNOTIFICATION_DEVICE_LIST_NEED_FRESH @"device_list_need_fresh"

/**
 *  晾衣架状态上报刷新二级界面
 */
#define KNOTIFICATION_CLOTHESHORSE_STATUS_REPORT @"clotherHorse_status_report"

/**
 *  晾衣架倒计时设置上报刷新二级界面
 */
#define KNOTIFICATION_CLOTHESHORSE_COUNTDOWN_REPORT @"clothes_status_report"
/**
 *  账号切换后刷新数据
 */
#define KNOTIFICATION_ACCOUNT_SWITCH @"account_switch"


#define KNOTIFICATION_FLOOR_AND_ROOM_ADD_EDIT_DELETE_NOTIFICATION @"floor_and_room_add_edit_delete_notification"


/**
 *  红外学习上报接口
 */
#define KNOTIFICATION_DEVICE_IR_LEARN_RESULT @"device_IR_learn_result"



#define kNOTIFICATION_LOGIN_SUCCESS         @"login_Succeed"        // 登录成功
#define kNOTIFICATION_LOGIN_FAILED          @"login_Failed"         // 登录失败
#define kNOTIFICATION_LOGIN_FINISH          @"login_finish"         // 登录完成（可能失败也可能成功，会携带状态值）

#define kNOTIFICATION_LOG_OFF               @"log_off"              // 退出登录到登录页
#define kNOTIFICATION_QUIT_ADMIN            @"quit_admin"           // 发送退出管理员登录的命令
#define kNOTIFICATION_SCENE_BIND_RESULT     @"scene_bind_result"    // 情景绑定的处理结果
#define kNOTIFICATION_REMOTE_CONTROL_RESULT @"remote_control_result"// 遥控器绑定的处理结果
#define kNOTIFICATION_CANCEL_SOCKET_TASK    @"cancel_socket_task"   // 取消socket任务，会断开链接，比如登录时进入后台
#define kNOTIFICATION_STOP_TASK             @"stop_task"            // 只取消 block 中剩余网络任务的执行，不断开链接，比如绑定主机的时候手动取消


/**
 
 从后台进入前台之后同步状态表，读完之后发送消息更新设备状态
 管理员登录之后同步所有数据，读完之后发送消息更新数据
 */
#define kNOTIFICATION_UPDATE_DEVICE_STATUS @"update_device_status"

/**
    其他管理员登录，自己退出管理员视图
 */
#define kNOTIFICATION_QUIT_ADMIN_VIEW @"quit_admin_view"

/**
    网关被重置
 */
#define kNOTIFICATION_GATEWAY_RESET @"gateway_reset"

/**
 *  接收到收到推送消息时刷新小红点
 */
#define kNOTIFICATION_REFRESH_UNREAD_MESSAGE @"refresh_unread_message"

/**
 *  接收到收到倒计时激活、或暂停提醒
 */
#define kNOTIFICATION_ACTIVE_OR_STOP_COUNTDOWN @"active_or_stop_countdown"

/**
 *  接收到收到定时或传感器设置开关推送刷新开关状态
 */
#define kNOTIFICATION_REFRESH_SWUTCH_STATUS @"refresh_switch_status"

/**
 *  接收到定时执行结果的推送信息
 *
 */
#define KNOTIFICATION_TIME_PUSH_INFO @"time_push_info"

/**
 *  接收到倒计时执行结果的推送信息
 *
 */

#define KNOTIFICATION_COUNTDOWN_PUSH_INFO @"countdown_push_info"

/**
 *  接收到家庭成员邀请后的推送信息
 *
 */
#define KNOTIFICATION_INVITEFAMILYMEMBERRESULT  @"inviteFamilyMemberResult"


#define KNOTIFICATION_SEARCHCOCORESULT @"SeacrhCOCOResult"

/**
 *  首页普通设备cell刷新UI
 */
#define KHomePageRefreshCellNotification  @"HomePageRefreshCellNotification"

/**
 *  传感器列表二级页面设备cell刷新UI
 */
#define KHomePageSenseListViewNotification  @"KHomePageSenseListViewNotification"

/**
 *  首页传感器cell刷新
 */
#define KHomePageSenseNotification      @"KHomePageSenseNotification"
/**
 *  首页常用设备cell刷新
 */
#define KHomePageCommonUseDevicesNotification @"KHomePageCommonUseDevicesNotification"



/**
 *  数据同步完成后发出此通知
 */

#define KNOTIFICATION_SYNC_TABLE_DATA_FINISH @"SyncTableDataFinish"

/**
 *  获得城市后发出通知进行定位
 */
#define KNOTIFICATION_LOCATION_CITY @"LocationCity"

/**
 *  接收到门锁打开的通知之后发送的通知
 */
#define KNOTIFICATION_DOOR_OPNE @"door_open"

/**
 *   获取萤石摄像头token
 */

#define KGETYSTOKENSUCCESS @"getYSTokenSuccess"


/**
 *   获取萤石摄像头token
 */

#define KGETYSTOKENFAIL @"getYSTokenFail"

/**
 *  发送搜索局域网COCO的通知
 */
#define KNOTIFICATION_SEARCH_COCO  @"KNOTIFICATION_Search_Coco"

/**
 *  设备被删除的通知
 */
#define KNOTIFICATION_DEVICEHASBEENREMOVED   @"KNOTIFICATION_DeviceHasBeenRemoved"

/**
 *  修改窗帘类型通知
 */
#define KNOTIFICATION_MODIFYCURTAINTYPE   @"modifyCurtainType"

/**
 *  天气请求成功或失败的通知
 */
#define KNOTIFICATION_WEATHERRESULT @"getWeatherSuccess"

#endif
