//
//  HMMacro.h
//  HomeMateSDK
//
//  Created by Air on 16/3/4.
//  Copyright © 2016年 Orvibo. All rights reserved.
//

#ifndef HMMacro_h
#define HMMacro_h

#define LogFuncName() DLog(@"%@",NSStringFromSelector(_cmd)) // 打印函数名
#define UserDefaults  [NSUserDefaults standardUserDefaults]

#define PUBLICAEC128KEY                     @"khggd54865SNJHGF"
#define DEFAULTSESSION                      @"00000000000000000000000000000000"

#define kNEWDBDIR [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents"]]
#define kDBDIR [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches"]]


#define IOS7 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
#define IOS9 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 9.0)

#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#define  VProportion ScreenHeight / 568.0f //垂直方向的屏幕比例
#define  HProportion ScreenWidth / 320.0f  //水平方向的屏幕比例

#define VProportionImg  ScreenHeight/667//UI设计以6的屏幕为参考
#define HProportionImg  ScreenWidth/375

#define MINCOLORTEMP 2700

#define MAXCOLORTEMP 6500

#define MINCONTROLCOLORTEMP 154.0

#define MAXCONTROLCOLORTEMP 370.0

#define RGB(r, g, b)                        [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]
#define RGBCOLORV(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:1.0]


#define CommonGreenColor                        RGB(49, 195, 124)

#define kViHomeModel                        @"VIH" // vicenter - 300 大主机
#define kHubModel                           @"Hub" // vicenter - 300 小主机
#define kNormalViHomeModel                  @"VIH004" // 中性 vicenter - 300 大主机
// wifi 类设备
#define kS20Model                           @"SOC0" // 一栋model SOC002
#define kCocoModel                          @"E10" // COCO 不带USB版本
#define kYSCameraModel                      @"CMR" // 萤石摄像头
#define kS20cModel                          @"S20" // S20c 的model
#define kCLHModel                           @"CLH" // 晾衣架
#define kHudingStripModel                   @"CoCo" //华顶排插，飞雕

// S20c
#define kS20cModelId                        @"56d124ba95474fc98aafdb830e933789"

// 海外版S20c 即S25
#define kS20cFriModelId                     @"f8b11bed724647e98bd07a66dca6d5b6"

#define kCLHModelId                         @"5e9ccae98b1b47f6935072d8c6e36be3"
#define kYDModelId                          @"9cddfe4851ee47348e6e2df06fb9e945"
#define kYSCameraModelId                    @"d3bf4822f3ed41d7a8b7e154ddc46ffa"
#define kYTYSCameraModelId                  @"46a2523b3a0d472ba73bad0e868f6531"

#define kDoorModelID                        @"9fbf0f1fc370403aae30886c2fcc6cf1"

// 汉枫COCO 32位model
#define kHanFengCocoModelId                @"2a9131f335684966a86c54ca784520d7"
// 飞雕插排
#define kFeiDiaoModelId                     @"22a70be5d60944f7b50d26b78eeebf01"

// 华顶插座
#define kHuaDingSocket                      @"0f85bfab9f1f4f50a7254639880dacbc"
// 华顶排插
#define kHuaDingStrip                       @"5fadd264c93544f8bd5556f11709e7aa"

// 紫程晾衣架
#define kZiChengCLHModel                    @"5e9ccae98b1b47f6935072d8c6e36be3"

//奥科晾衣架
#define kAoKeCLHModel                       @"68bb3f1a74284e2189227bc0259d3363"

// 四键随意贴的model
#define k4KeySceneBoardModelID              @"3c4e4fc81ed442efaf69353effcdfc5f"

// 中性主机的model
#define kNormalGatewayModelID               @"e019ff119e5f4567a0c3f5868b566253"

// 慧眼摄像头model
#define kP2PCameraModelID                   @"bcec7653260b4e98b0e653e0a79d83db"

// allone2 model
#define kAllone2ModelID                     @"ffd65d82eae248a8a8bc08a2cb688a2b"

// 创维空调面板/WIFI空调 model
#define kSkyworthModelID                    @"81dc0561b6dc496781b6cf69971a96c8"

// 空调面板/orvibo model
#define kWifiAirconditionerModelID          @"9eca5b60791f40549e7059ae6771c2f4"

// 创维rgb灯
#define kChuangWeiRgbModel                 @"e1b7b3a1a82b4beda41481a3943d941d"

// Skyworth智能灯
#define kChuangWeiOrdinaryLightModel       @"cdf36cb86b964b47855f0c188d79dbdf"

// Skyworth智能调光灯
#define kChuangWeiDimmerLightModel         @"1f7c51362dee4578bca9bd53d64a06fd"

// Skyworth调光调色灯
#define kChuangWeiColorTempLightModel      @"a9259fc37aad447ea6633a23f07bec7b"


/** 每张表读取失败后的最大尝试次数 */
#define kReadTableMaxTryTimes 3
#define kReadTableTimeOut 5 // 发出读表指令后 5秒内没有表数据返回就重发一次
#define kMaxSyncDataTime (30 * 60)  // 在后台时间超过30分钟，再进去前台就同步数据
#define kSearchMdnsTime 1.2         // 查找mds服务的时间
#define kHeartBeatTime (3 * 60)     // 心跳包发送的时间间隔

#define KWeChatAlertViewTag                 8881 //微信分享弹出框的tag，显示是否接受邀请
#define KPushNotificationsAlertViewTag      8882 //远程推送开关没有打开弹框的tag
#define KAlarmDeviceAlertViewTag            8883 //远程推送开关没有打开弹框的tag


#define KDataTypeM              @"KDataTypeM"
#define KDataObject             @"KDataObject"
#define kDbVersion              @"v29"
#define TEST_HOST_NAME          @"www.baidu.com"

//MDNS

#define MNDS_SERVICE_TYPE       @"_smarthome._tcp"
#define MNDS_DOMAINNAME         @"local"
#define MNDS_PORT               8088


#define HM_DOMAIN_NAME @"homemate.orvibo.com"
#define HM_SERVER_PORT 10001

#define HM_UDP_PORT 10000 // udp 发现端口
#define HM_UDP_BROADCAST_ADDR  @"255.255.255.255"

#define kGet_ServerIP_URL      @"http://homemate.orvibo.com/getHost?source=%@&idc=%d&country=%@&state=%@&city=%@&userName=%@"


#define HM_DeviceToken_Key     @"HMDeviceTokenKey"
/**
 *  未设定值
 */
#define UNSETVALUE            -1

#define kFilterDeviceType @"11,15,16,27,43,44,45,50,51"       // 设备列表里面不显示出来的安防设备
#define kFilterSceneDeviceType @"11,14,15,16,21,25,26,27,43,44,45,46,47,48,49,50,51"    // 情景添加设备时屏蔽掉的设备类型，门锁21 和安防都不能添加到情景

// 常用设备里不显示的类型
#define kFilterCommonDeviceType @"11,15,16,21,25,26,27,44,45,46,47,48,59,50,51"

// 需要节能提醒的类型
#define kEnergyDeviceType @"0,1,19,38"

// 是否需要节能提醒的key值
#define kIsNeedEnergySaveKey    @"allLight_is_need_energySaveTip"

// 需要显示消息的消息类型
#define kNeedDisplayInfoType  @"0,1,11,12"

#endif /* HMMacro_h */
