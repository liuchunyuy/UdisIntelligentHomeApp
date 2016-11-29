//
//  Header.h
//  Vihome
//
//  Created by Ned on 1/19/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#ifndef Vihome_Header_h
#define Vihome_Header_h

typedef enum : NSUInteger {
    KEncryptedTypePK,
    KEncryptedTypeDK,
    KEncryptedTypeUnknow
} KEncryptedType;


typedef enum : int {
    
    /** 处理成功 */
    KReturnValueSuccess                 = 0,
    
    /** 处理失败 */
    KReturnValueFail                    = 1,
    
    /** 未登录，请重新登录该主机 */
    KReturnValueUnlogin                 = 2,
    
    /** 网关存储空间已满，不能创建更多设备 */
    KReturnValueMemFull                 = 3,
    
    /** 下载红外码库失败，存储空间不足 */
    KReturnValueIRLibDownFainMemFull    = 4,
    
    /** 主机已经被其他账号绑定过，需要解除原来的绑定信息才能绑定新账号 */
    KReturnValuebeBinded             = 5,
    
    /** 主机未绑定用户信息或者绑定信息已经被重置 */
    KReturnValueMainframeRest              = 6,
    
    /** 网络错误，主机连接不上服务器 */
    KReturnValueMainframeDisconnect        = 7,
    
    /** 设备掉线 */
    KReturnValueMainframeOffline           = 8,
    
    /** 该用户名未绑定到本主机 */
    KReturnValueNotBindMainframe           = 9,
    
    /** 定时任务已满 */
    KReturnValueDataFull           = 10,
    
    /** 注册失败，验证码与手机号不一致 */
    KReturnValueCodeNotFitWithPhoneNum         = 11,
    
    /** 用户名或者密码错误 */
    KReturnValueAccountOrPWDERR         = 12,
    
    /** 注册时用户名已存在 */
    KRegisterUserExist                  = 13,
    
    /** 验证码已过期 */
    KReturnValueCodeOutOfDate                  = 14,
    
    /** 验证码错误 */
    KReturnValueCodeERR                  = 15,
    
    /** 该用户不存在，请注册新用户 */
    KReturnValueUserNotExist             = 16,
    
    /** session已过期，请重新申请通信密钥 */
    KReturnValueSessionInvalid          = 17,
    
    /** 绑定失败，该手机号已经注册过 */
    KReturnValuePhoneNumExist       = 18,
    
    /** 绑定失败，该Email已经注册过 */
    KReturnValueEmailExist            = 19,
    
    /** 注册失败，验证码与邮箱不一致 */
    KReturnValueCodeCodeNotFitWithmailbox = 20,
    
    /** 修改失败,没有通过短信或者邮箱验证 */
    KReturnValueNoVerificationViaSMSOrEmail = 21,
    
    /** 修改失败，旧密码错误 */
    KReturnValueOldPasswordError = 22,
    
    /** 远程登录管理员 */
    KReturnValueRemoteLoginAdmin       = 24,
    /** 已经有用户登录管理员页面 */
    KReturnValueAdminLogined          = 25,
    
    /** 网关上的数据已不存在，这里的数据指所有数据，设备、情景、定时等 */
    KReturnValueDataNotExist           = 26,
    
    /** 解绑COCO失败 */
    KReturnValueServerUnbindFail      = 27,
    
    /** 流水号一分钟内重复 */
    KReturnValueServerReplyInOneMinute           = 28,
    
    /** 遥控器或情景面板超时无回应 */
    KReturnValueRcWithoutResponse           = 29,
    
    /** 绑定关系失效，当前设备跟当前userId已经没有绑定关系 */
    KReturnValueBindInvalid           = 30,
    
    /** 不能邀请，该用户尚未注册 */
    KReturnValueCanNotInvite          = 31,
    
    /** 不能分享设备给自己 */
    KReturnValueCanNotInviteYourself  = 32,
    
    /** 该用户已是家庭成员 */
    KReturnValueUserHasAFamilyMember  = 33,
    
    /** 该用户已经绑定了其他主机，暂时不能分享 */
    KReturnValueDoesnotSupport        = 34,
    
    /** 对不起，您不是这个请求的被邀请者，无权处理 */
    KReturnValueNoAuthority        = 35,
    
    /** 该请求已经被处理过 */
    KReturnValueProcessed        = 36,
    
    /** 邀请失败，请先添加设备 */
    KReturnValueInviteFailedWithNoDevice        = 37,
    
    /** 已存在一个相同的，激活状态的定时 */
    KReturnValueTimingExist        = 38,
    /**
     *  格式错误，只支持汉字，字母，数字，@，+，-和下划线
     39错误码用于以下接口
     创建楼层、创建楼层和子房间、修改楼层、创建房间、修改房间、修改设备信息、修改摄像头信息、创建设备、创建情景、修改情景、添加联动任务、设置联动任务、创建自定义红外按键、修改自定义红外按键
     */
    KReturnValueFormatError        = 39,
    
    /** 设置失败，需要等待晾衣架工作完成之后才能设置 */
    KReturnValueSetCLHFailed        = 40,
    
    /** 主机数据已修改，请重新同步最新数据 */
    KReturnValueNeedSyncData        = 41,
    
    /** 主机繁忙，请等待30秒之后再重试 */
    KReturnValueGatewayBusy        = 42,
    
    /** 无可用问候语 */
    KReturnValueNoNewGreetings        = 43,
    
    /** 主机已经处于组网状态，请稍后再试（搜索设备的时候如果已经有另外一个账号在组网则返回这个错误码） */
    KReturnValueGatewayNetworkIsOpened       = 44,
    
    /** 设置失败，该房间已经被删除 */
    KReturnValueRoomBeDeleted        = 45,
    
    /** 智能门锁，处理失败，查不到有效的授权信息 */
    KReturnValueNoValidAuthorization        = 46,
    
    /** 倒计时处理失败，设备离线，infoType 11 返回的错误码 */
    KReturnValueCountDownErrorDeviceOffline        = 47,
    /**
     *  控制失败，找不到绑定关系，请检查该设备的外网连接是否正常（返回这个错误码的时候，可能是因为支持本地控制的设备没有外网连接，所以绑定关系没有上传上来，客户端远程控制的时候接受到这个错误码，不需要把设备删除。如果因为绑定关系被删除了没法控制的话返回的错误码是30，这个时候app需要把这个设备从本地删除）
     */
    KReturnValueCannotFindBindInfo        = 48,
    
    /** 添加失败，单个设备的定时任务最多只能添加20条哦 */
    KReturnValueTimingErrorAlreadyFull        = 49,
    
    /** 添加失败，单个设备的倒计时最多只能添加20条哦 */
    KReturnValueCountDownErrorAlreadyFull        = 50,
    
    /** 设备描述信息无更新 */
    KReturnValueDeviceDescNotUpdate        = 51,
    
    /** 您尚未登录，请先登录再修改 */
    KReturnValueNotLogin        = 52,
    
    /** 修改失败。（正常登录的用户名和sessionId不匹配） */
    KReturnValueSessionNotMatching        = 53,
    
    /** 上传的文件格式错误 */
    KReturnValueFileFormatError        = 54,
    
    /** md5校验失败 */
    KReturnValueMD5CheckFailed        = 55,
    
    /** 未设置头像。（此时不需要提示查询失败，只需要显示默认的头像就可以）*/
    KReturnValueNotSetHeadPortrait        = 56,
    
    /** 无可用tips */
    KReturnValueNoUserfulTips        = 57,
    
    /** 该授权id尚未注册 */
    KReturnValueNotRegister        = 58,
    
    /** 59：该设备已经处于学习状态，请等待15秒之后再学习 */
    KReturnValueDeviceIsInLearningState = 59,
    
    /** 您不具备管理员权限增加新的错误码，对于所有增删改的操作接口只允许管理员权限的用户操作 */
    KReturnValueNoAdminAuthority   = 60,
    
    /** 设备资源不足，处理失败（指的是灯，开关设备，比如灯最多支持添加32个情景，超过之后会返回这个错误码） */
    KReturnValueResourceInsufficient    = 137,
    
    /**  本地错误码,数据请求超时*/
    KReturnValueTimeout                 = 10001,
    /** 本地错误码,客户端连接服务器失败 */
    KReturnValueConnectError            = 10002,
    
    /** 本地错误码,数据同步完成 */
    KReturnValueSyncDataFinsih          = 10003,
    
} KReturnValue;

/**
 设备类型 0：调光灯、 1：普通灯光、 2：插座、 3：幕布、 4：百叶窗、5：空调、 6：电视； 7：音箱； 8：对开窗帘 9：点触型继电器； 10：开关型继电器；11：红外转发器； 12：无线； 13：情景模式； 14：摄像头； 15：情景面板；16：遥控器；17：中继器；18：亮度传感器; 19：RGB灯；20:可视对讲模块;21:门锁;22:温度传感器；23：湿度传感器;24:空气质量传感器;25:;26:红外人体传感器;27:烟雾传感器;28:报警设备；29：S20；30：Allone；31：kepler；32：机顶盒；33：自定义红外；34：对开窗帘（支持按照百分比控制）；35：卷帘（支持按照百分比控制）；36：百叶窗；37：推窗器；38：色温灯；39：卷闸门；40：花洒；41：推窗器；42：卷帘（无百分比）；43：单控排插；44：vicenter300主机；45：miniHub；46：门磁；47：窗磁；48：抽屉磁；49：其他类型的门窗磁；50：情景面板（5键）；51：情景面板（7键）
 */
typedef enum : int {
    /**
     * 调光灯
     */
    KDeviceTypeDimmerLight                  = 0,
    
    /**
     * 普通一路，二路，三路开关
     */
    KDeviceTypeOrdinaryLight                = 1,
    
    /**
     * 插座
     */
    KDeviceTypeSocket                       = 2,
    
    /**
     * 幕布
     */
    KDeviceTypeScreen                       = 3,
    
    /**
     * 百叶窗 ，类型废弃
     */
    KDeviceTypeBlinds                       = 4,
    
    /**
     *  空调
     */
    KDeviceTypeAirconditioner               = 5,
    
    /**
     *  电视
     */
    KDeviceTypeTV                           = 6,
    
    /**
     *  音箱
     */
    KDeviceTypeSound                        = 7,
    
    /**
     *  对开窗帘
     */
    KDeviceTypeCurtain                      = 8,
    
    /**
     *  点触型继电器
     */
    KDeviceTypeTouchElectricRelay           = 9,
    
    /**
     *  开关型继电器
     */
    KDeviceTypeSwitchedElectricRelay        = 10,
    
    /**
     *  红外转发器
     */
    KDeviceTypeInfraredRelay                = 11,
    
    /**
     *  无线
     */
    KDeviceTypeWireless                     = 12,
    
    /**
     *  情景模式
     */
    KDeviceTypeScene                        = 13,
    
    /**
     *  摄像头
     */
    KDeviceTypeCamera                       = 14,
    
    /**
     *  情景面板 3键
     */
    KDeviceTypeSceneBorad                   = 15,
    
    /**
     *  Zigbee 智能遥控器 ,四键情景面板
     */
    KDeviceTypeRemote                       = 16,
    
    /**
     *  中继器
     */
    KDeviceTypeRelay                        = 17,
    
    /**
     *  亮度传感器
     */
    KDeviceTypeLuminanceSensor              = 18,
    
    /**
     *  RGB灯
     */
    KDeviceTypeRGBLight                     = 19,
    
    /**
     *  可视对讲模块
     */
    KDeviceTypeVisualTalkSpeaking           = 20,
    
    /**
     *  门锁
     */
    KDeviceTypeLock                         = 21,
    
    /**
     *  温度传感器
     */
    KDeviceTypeTemperatureSensor            = 22,
    
    /**
     *  湿度传感器
     */
    KDeviceTypeHumiditySensor               = 23,
    
    /**
     *  空气质量传感器
     */
    KDeviceTypeAirQualitySensor             = 24,
    
    /**
     *  可燃气体传感器
     */
    KDeviceTypeMagnet                       = 25,
    
    /**
     *  红外人体传感器
     */
    KDeviceTypeInfraredSensor               = 26,
    
    /**
     *  烟雾报警传感器
     */
    KDeviceTypeSmokeTransducer              = 27,
    
    /**
     *  报警设备
     */
    KDeviceTypeAlarmEquipment               = 28,
    
    /**
     *  S20
     */
    KDeviceTypeS20                          = 29,
    
    /**
     *  Allone
     */
    KDeviceTypeAllone                       = 30,
    
    /**
     *  kepler
     */
    KDeviceTypeKepler                       = 31,
    
    /**
     *  机顶盒
     */
    KDeviceTypeSTB                          = 32,
    
    /**
     *  自定义红外
     */
    KDeviceTypeCustomerInfrared             = 33,
    /**
     *  对开窗帘（支持按照百分比控制）
     */
    KDeviceTypeCasement                     = 34,
    
    /**
     *  卷帘卷帘（支持按照百分比控制）
     */
    KDeviceTypeRoller                       = 35,
    /**
     *  空调面板(旧定义的百叶窗已不使用)
     */
    KDeviceTypeRollerBind                   = 36,
    
    /**
     *  推窗器，外开窗帘
     */
    KDeviceTypeAwningWindow                 = 37,
    
    /**
     *  色温灯
     */
    KDeviceTypeColorTemperatureBubls        = 38,
    
    /**
     *  卷匣门
     */
    KDeviceTypeRollupDoor                      =39,
    
    // 花洒
    KDeviceTypeSprinkler                      =40,
    
    // 推窗器，类型废弃
    KDeviceTypeAwning                      =  41,
    
    // 卷帘（无百分比）
    KDeviceTypeRoller2                     = 42,
    
    /**
     *  COCO插线板
     */
    kDeviceTypeCoco                        = 43,
    
    /**
     *  Vi-Center300 大主机
     */
    kDeviceTypeViHCenter300              = 44,
    
    /**
     *  Vi-Center300 小主机
     */
    kDeviceTypeMiniHub                   = 45,
    
    /**
     *  门磁
     */
    KDeviceTypeMagneticDoor               = 46,
    
    /**
     *  窗磁
     */
    KDeviceTypeMagneticWindow            = 47,
    
    /**
     *  抽屉磁
     */
    KDeviceTypeMagneticDrawer            = 48,
    
    /**
     *  其他类型的门窗磁
     */
    KDeviceTypeMagneticOther             = 49,
    
    /**
     *  5键情景面板
     */
    kDeviceType5KeySceneBorad            = 50,
    
    /**
     *  7键情景面板
     */
    kDeviceType7KeySceneBorad            = 51,
    
    /**
     *  晾衣架
     */
    kDeviceTypeClothesHorse            = 52,
    
    /**
     *  华顶夜灯插座
     */
    kDeviceTypeHuaDingNightLightSocket  = 53,
    
    /**
     *  水浸探测器
     */
    kDeviceTypeWaterDetector          = 54,
    
    /**
     *  一氧化碳报警器
     */
    KDeviceTypeCarbonMonoxideAlarm    =55,
    
    /**
     *  紧急按钮
     */
    KDeviceTypeEmergencyButton     = 56,
    
} KDeviceType;

/**
 注意：
 上面KDeviceType要校验下面的数组
 */
#define KDeviceTypeString(enum) [@[@"KDeviceTypeDimmerLight",@"KDeviceTypeOrdinaryLight",@"KDeviceTypeSocket",@"KDeviceTypeScreen",@"KDeviceTypeBlinds",@"KDeviceTypeAirconditioner",@"KDeviceTypeTV",@"KDeviceTypeSound",@"KDeviceTypeCurtain",@"KDeviceTypeTouchElectricRelay",@"KDeviceTypeSwitchedElectricRelay",@"KDeviceTypeInfraredRelay",@"KDeviceTypeWireless",@"KDeviceTypeScene",@"KDeviceTypeCamera",@"KDeviceTypeSceneBorad",@"KDeviceTypeRemote",@"KDeviceTypeRelay",@"KDeviceTypeLuminanceSensor",@"KDeviceTypeRGBLight",@"KDeviceTypeVisualTalkSpeaking",@"KDeviceTypeLock",@"KDeviceTypeTemperatureSensor",@"KDeviceTypeHumiditySensor",@"KDeviceTypeAirQualitySensor",@"KDeviceTypeMagnet",@"KDeviceTypeInfraredSensor",@"KDeviceTypeSmokeTransducer",@"KDeviceTypeAlarmEquipment",@"KDeviceTypeS20",@"KDeviceTypeAllone",@"KDeviceTypeKepler",@"KDeviceTypeSTB",@"KDeviceTypeCustomerInfrared",@"KDeviceTypeCasement",@"KDeviceTypeRoller",@"KDeviceTypeRollerBind",@"KDeviceTypeAwningWindow",@"KDeviceTypeColorTemperatureBubls",@"KDeviceTypeRollupDoor",@"KDeviceTypeSprinkler",@"KDeviceTypeAwning",@"KDeviceTypeRoller2",@"kDeviceTypeCoco",@"kDeviceTypeViHCenter300",@"kDeviceTypeMiniHub",@"KDeviceTypeMagneticDoor",@"KDeviceTypeMagneticWindow",@"KDeviceTypeMagneticDrawer",@"KDeviceTypeMagneticOther",@"kDeviceType5KeySceneBorad",@"kDeviceType7KeySceneBorad",@"kDeviceTypeClothesHorse",@"kDeviceTypeHuaDingNightLightSocket",@"kDeviceTypeWaterDetector",@"KDeviceTypeCarbonMonoxideAlarm"] objectAtIndex:enum]



typedef enum : int {
    
    /**
     *  0x0000 普通开关
     */
    KDeviceIDSwitch = 0x0000,
    
    /**
     *  0x0001 调光开关
     */
    KDeviceIDDimmerSwitch = 0x0001,
    
    /**
     *  0x0002 插座
     */
    KDeviceIDSocket = 0x0002,
    
    /**
     *  情景面板
     */
    KDeviceIDSceneboard = 0x0004,
    
    /**
     *  0x0006 遥控器
     */
    
    KDeviceIDHandset = 0x0006,
    
    /**
     *  网关
     */
    KDeviceIDGateway = 0x0007,
    
    /**
     *  0x0008 路由中继器
     */
    KDeviceIDRouteRelay = 0x0008,
    
    /**
     *  0x000a 红外转发器
     */
    KDeviceIDInfrared = 0x000a,
    
    /**
     *  0x000b 继电器控制盒
     */
    KDeviceIDRelayControlBox = 0x000b,
    
    /**
     *  0x000c 按键面板
     */
    KDeviceIDKeyPanel = 0x000c,
    
    /**
     *  0x000d 可视对讲模块
     */
    KDeviceIDVisualTalkSpeaking = 0x000d,
    
    /**
     *  0x000e窗帘控制盒 设备类型 3，4，8任意切换
     */
    KdeviceCurtainControlBox = 0x000e,
    
    /**
     *  0x00FE 门锁
     */
    KDeviceIDDoorLock = 0x00FE,
    
    
    
    /**
     *  仅有开关作用的灯
     */
    KDeviceIDOrdinaryLight = 0x0100,
    
    /**
     *  0x0101 可调光的灯
     */
    KDeviceIDDimmerLight = 0x0101,
    
    /**
     *  0x0103 自带开关功能的灯
     */
    KDeviceIDRGBDimmerLight = 0x102,
    
    /**
     *  0x0103 自带开关功能的灯
     */
    KDeviceIDSwithSelfOwned = 0x103,
    
    
    /**
     *  0x0105 RGB控制器
     */
    KDeviceIDRGBController = 0x0105,
    
    /**
     *  0x0106 亮度传感器
     */
    KDeviceIDLightSensor = 0x0106,
    
    /**
     *  0x0203 多功能控制盒 可设置百分比的窗帘电机
     */
    KDeviceIDControlBox = 0x0203,
    
    
    /**
     *  0x0302 温度传感器
     */
    KDeviceIDTemperatureSensor = 0x0302,
    
    /**
     *  0x0305 压力传感器
     */
    KDeviceIDPressureSensor = 0x305,
    
    /**
     *  0x0306 流量传感器
     */
    KDeviceIDOutflowSensor = 0x0306,
    
    /**
     *  0x03FD 湿度传感器
     */
    KDeviceIDHumiditySensor = 0x03FD,
    
    /**
     *  0x0402 安防传感器
     */
    KDeviceIDSecurity = 0x0402,
    
    
    /**
     *  摄像头、电视空调电视机顶盒等
     */
    KDeviceIDVirtualDevice = 0xFFFF,
    
    
} KDeviceID;





typedef enum
{
    INSERT_OPERATION = 0,
    UPDATE_OPERATION  = 1,
    DELETE_OPERATION = 2,
    DELETE_ALL = 3,
    
}TABLE_MANAGEMENT;

typedef enum
{
    LOCAL_LOGIN  = 101,
    REMOTE_LOGIN = 102,
    
}LOGIN_TYPE;


@protocol OrderProtocol

@required

@property (nonatomic, strong)NSString *         bindOrder;

@property (nonatomic, assign)int                value1;

@property (nonatomic, assign)int                value2;

@property (nonatomic, assign)int                value3;

@property (nonatomic, assign)int                value4;

@end

typedef enum {
    
    VIHOME_CMD_RK,//request key 0
    VIHOME_CMD_GB,//gateway binding 1
    VIHOME_CMD_CL,//client login 2
    VIHOME_CMD_QS,//query statistics 3
    VIHOME_CMD_QD,//query data 4
    VIHOME_CMD_DC,//device search 5
    VIHOME_CMD_DL,//device login 6
    VIHOME_CMD_AF,//add floor 7
    VIHOME_CMD_AR,//add room 8
    VIHOME_CMD_MF,//modify floor 9
    VIHOME_CMD_MR,//modify room 10
    VIHOME_CMD_MN,//modify home name 11
    VIHOME_CMD_DF,//delete floor 12
    VIHOME_CMD_DR,//delete room 13
    VIHOME_CMD_MD,//modify device 14
    VIHOME_CMD_CD,//control device 15
    VIHOME_CMD_MC,//modify camera 16
    VIHOME_CMD_AD,//add device 17
    VIHOME_CMD_DD,//delete device 18
    VIHOME_CMD_AS,//add scene 19
    VIHOME_CMD_MS,//modify scene 20
    VIHOME_CMD_DS,//delete scene 21
    VIHOME_CMD_AB,//add scene bind 22
    VIHOME_CMD_MB,//modify scene bind 23
    VIHOME_CMD_DB,//delete scene bind 24
    VIHOME_CMD_SL,//start learning 25
    VIHOME_CMD_SO,//stop learning 26
    VIHOME_CMD_DI,//delete ir 27
    VIHOME_CMD_AM,//add remote bind 28
    VIHOME_CMD_MM,//modify remote bind 29
    VIHOME_CMD_DM,//delete remote bind 30
    VIHOME_CMD_RS,//reset zigbee 31
    VIHOME_CMD_HB,//heartbeat 32
    VIHOME_CMD_RT,//root transfer 33
    VIHOME_CMD_CU,//create user 34
    VIHOME_CMD_DU,//delete user 35
    VIHOME_CMD_MP,//modify password 36
    VIHOME_CMD_ND,//new device 37 // 新设备上报
    VIHOME_CMD_ID,//ir downloaded 38
    VIHOME_CMD_SA,//add scene bind result 39
    VIHOME_CMD_SM,//modify scene bind result 40
    VIHOME_CMD_SD,//delete scene bind result 41
    VIHOME_CMD_PR,//property report 42
    VIHOME_CMD_LR,//start learning result 43
    VIHOME_CMD_RA,//add remote bind result 44
    VIHOME_CMD_RM,//modify remote bind result 45
    VIHOME_CMD_RD,//delete remote bind result 46
    VIHOME_CMD_CS,//clock synchronization 47
    
    VIHOME_CMD_DBD,//device bind 48
    VIHOME_CMD_GSC,//get sms code 49
    VIHOME_CMD_CSC,//check sms code 50
    VIHOME_CMD_RST,//register 51
    VIHOME_CMD_AFR,//add floor and room 52
    VIHOME_CMD_OO, //online_offline report 53
    VIHOME_CMD_AC, //add camera 54
    VIHOME_CMD_AT, //add timer 55
    VIHOME_CMD_LO, //login out 56
    VIHOME_CMD_DT, //delete timer 57
    VIHOME_CMD_ACT, //activate timer 58
    VIHOME_CMD_MT, //modify timer 59
    
    VIHOME_CMD_AL, //add linkage 60
    VIHOME_CMD_SLK, //set linkage 61
    VIHOME_CMD_DLK, //delete linkage 62
    /**
     * 创建自定义红外按键
     */
    VIHOME_CMD_AIK = 63,
    
    /**
     * 修改自定义红外按键
     */
    VIHOME_CMD_MIK = 64,
    
    /**
     * 删除自定义红外按键
     */
    VIHOME_CMD_DIK = 65,
    /**
     *  客户端查询局域网内未绑定的设备列表,unbind devices
     */
    VIHOME_CMD_UBD = 66,
    
    /**
     *  已注册用户绑定手机号或者邮箱,user bind
     */
    VIHOME_CMD_UB = 67,
    /**
     *  获取邮箱验证码接口 get email code
     */
    VIHOME_CMD_GETEMAILCODE = 68,
    
    /**
     *  校验邮箱验证码接口 check email code
     */
    VIHOME_CMD_CHECKEMAILCODE = 69,
    
    /**
     *  设置用户昵称接口  set nickname
     */
    VIHOME_CMD_SETNICKNAME = 70,
    
    /**
     *  客户端——>服务器，修改用户密码接口 modify password
     */
    VIHOME_CMD_MODIFYPASSWORD = 71,
    
    /**
     *  用户删除绑定的设备接口 device unbind
     */
    VIHOME_CMD_DEVICEUNBIND = 72,
    
    /**
     * 	客户端——>服务器, 修改WiFi设备信息接口 modify device
     */
    VIHOME_CMD_MODIFYDEVICE = 73,
    
    /**
     *  重置用户密码接口  reset password
     */
    VIHOME_CMD_RESETPASSWORD = 74,
    
    VIHOME_CMD_UUB = 75,    //75 upload userbind
    VIHOME_CMD_FU  = 76,    //76 firmware update
    VIHOME_CMD_DUP = 77,    //77 data update
    VIHOME_CMD_QDS = 78,    //78 query data server
    VIHOME_CMD_QAI = 79,    //79 query ap info
    VIHOME_CMD_QWR = 80,    //80 query wifi router
    VIHOME_CMD_SSP = 81,    //81 set ssid and password
    VIHOME_CMD_INP = 82,    //82 info push
    VIHOME_CMD_TR  = 83,    //83 token report
    VIHOME_CMD_RMN = 84,    //84 readed message num
    
    VIHOME_CMD_ACL = 85,    //85 activate linkage
    VIHOME_CMD_UDP = 86,    //86 query gateway
    VIHOME_CMD_TP  = 87,    //87 timer push
    VIHOME_CMD_TS  = 88,    //88 timezone set
    VIHOME_CMD_ZC  = 89,    //89 zero calibration
    
    VIHOME_CMD_DLO = 90,    //90 device logout
    VIHOME_CMD_GT  = 91,	//91 get time
    VIHOME_CMD_TSO = 92,	//92 Threshold
    VIHOME_CMD_IFM = 93,    //93 invite family member
    VIHOME_CMD_DFM = 94,    //94 delete family member
    VIHOME_CMD_FMR = 95,    //95 family member response
    VIHOME_CMD_DRS = 96,    //96 device reset   设备恢复出厂接口
    VIHOME_CMD_SP  = 97,    //97 sensor push
    
    CLOTHESHORSE_CMD_CONTROL = 98,              //98  晾衣架控制接口
    CLOTHESHORSE_CMD_STATUS_REPORT = 99,        //99  晾衣架状态反馈接口
    CLOTHESHORSE_CMD_STATUS_QUERY = 100,        //100 查询晾衣架实时状态接口
    CLOTHESHORSE_CMD_COUNTDOWN_SETTING = 101,   //101 晾衣架倒计时设置接口
    CLOTHESHORSE_CMD_COUNTDOWN_REPORT = 102,    //102 晾衣架倒计时时间报告接口
    VIHOME_CMD_QW = 103,                        //103 查询天气 query weather
    
    VIHOME_CMD_SFM = 104,   //104 set frequently mode
    VIHOME_CMD_AUU = 105,   //105 授权开锁 authorized unlock
    VIHOME_CMD_AUC = 106,   //106 取消授权开锁 authorized cancel
    VIHOME_CMD_SDUN = 107,  //107 设置门锁用户名称 set doorlock user name
    
    VIHOME_CMD_RSAS = 108,  //108 重发授权短信resend authorized sms
    VIHOME_CMD_ADCD = 109,  //109 创建倒计时add countdown
    VIHOME_CMD_MDCD = 110,  //110 修改倒计时modify countdown
    VIHOME_CMD_DLCD = 111,  //111 删除倒计时delete countdown
    VIHOME_CMD_ACCD = 112,  //112 激活/暂停倒计时activate countdown
    VIHOME_CMD_DUN = 113,   //113 数据更新上报 data updated
    VIHOME_CMD_DDR = 114,   //114 delete doorlock record
    VIHOME_CMD_WIFIADDDEVICE = 115, //客户端到服务器，创建设备
    VIHOME_CMD_IR_UPLOAD = 116,//WiFi设备红外码上报
    VIHOME_CMD_SCR = 117,   //117 security 布撤防接口命令
    VIHOME_CMD_LD = 118,    //118 level delayTime
    VIHOME_CMD_OD = 119,    //119 off delayTime
    VIHOME_CMD_KEYS_REPORT = 120,   //120 keys report
    VIHOME_CMD_THIRD_REG =  121,     //121 third account register
    VIHOME_CMD_THIRD_BIND = 122,    //122 third account bind
    VIHOME_CMD_THIRD_VERIFY = 123,  //123 third account verify
    
} VIHOME_CMD;

typedef enum : NSUInteger {
    /**
     *  未发送
     */
    CodeSendStatusUnsend,
    /**
     *  正在发送验证码
     */
    CodeSendStatusSending,
    /**
     *  可以从新发送验证码
     */
    CodeSendStatusResend,
    
} CodeSendStatus;

typedef enum : NSUInteger {
    /**
     *  第一次设置房间
     */
    KFloorListTypeRoomFirstSet,
    /**
     *  个人中心进入设置房间
     */
    KFloorListTypeRoomSet,
} KFloorListType;

typedef enum : NSUInteger {
    
    SceneBindNone,
    SceneBindAdd = 1,
    SceneBindDelete = 2,
    SceneBindModify = 3,
    
} SceneBindType;

typedef enum : NSUInteger {
    
    KDataTypeNone,
    KDataTypeAdd,
    KDataTypeDelete,
    KDataTypeEdit,
    
} KDataType;

/**
 红外遥控按键 "--/-" 键实现数字组合换台
 */
typedef enum : NSUInteger {
    /**
     *  按下 "--/-" 键
     */
    KNumberComponentStatusBegin,
    
    /**
     *  按下 第一个数字键
     */
    KNumberComponentStatusFirstKeyDown,
    
    /**
     *  结束组合流程
     */
    KNumberComponentStatusEnd,
} KNumberComponentStatus;


typedef enum : NSUInteger {
    
    KAlertButtonConfirm,
    KAlertButtonCancel,
    KAlertButtonBGTap
    
} KAlertButtonType;



/**
 *  timer period
 */
typedef enum : NSUInteger {
    
    KTimerPeriodMon     = (0x00000001) << 0 | (0x00000001 << 7),
    KTimerPeriodTues    = (0x00000001) << 1 | (0x00000001 << 7),
    KTimerPeriodWed     = (0x00000001) << 2 | (0x00000001 << 7),
    KTimerPeriodThur    = (0x00000001) << 3 | (0x00000001 << 7),
    KTimerPeriodFri     = (0x00000001) << 4 | (0x00000001 << 7),
    KTimerPeriodSat     = (0x00000001) << 5 | (0x00000001 << 7),
    KTimerPeriodSun     = (0x00000001) << 6 | (0x00000001 << 7),
    KTimerPeriodSingle  = (0x00000000 << 7),
    
} KTimerPeriod;

typedef BOOL(^commonFinishBlock)(KReturnValue value);
typedef void(^commonBlock)(KReturnValue value);
typedef void(^CommonSelectBlock)(id selectValue);
typedef void(^commonBlockWithObject)(KReturnValue value, id object);


typedef void (^AlertBlock)(void);
typedef void (^SocketCompletionBlock)(KReturnValue returnValue , NSDictionary *returnDic);
typedef void (^VoidBlock)();
typedef void (^SuccessBlock)(BOOL success);
typedef void (^FinishBlock)( BOOL * finish);
typedef void (^SearhMdnsBlock)(BOOL success,NSArray *gateways);

typedef void(^PAlertViewBlock)(KAlertButtonType butonType);

//新增
typedef enum _AllDeviceTypes{
    TS20 = 1,
    
}AllDeviceTypes;

typedef enum _socketStatus{
    KSocketOpen = 0,
    KSocketClose = 1,
}socketStatus;

/**
 *  添加设备入口的标记
 */
typedef enum :NSUInteger{
    
    /**
     *  智能主机
     */
    KEntryFlagSmartHost = 1,
    /**
     *  智能插座
     */
    KEntryFlagSmartSocket,
    /**
     *  智能开关
     */
    KEntryFlagSmartSwitch,
    /**
     *  智能照明
     */
    KEntryFlagSmartLight,
    /**
     *  智能门锁
     */
    KEntryFlagSmartLock,
    /**
     *  门窗传感器
     */
    KEntryFlagDoorWindowSensor,
    /**
     *  人体传感器
     */
    KEntryFlagHumanSenor,
    /**
     *  烟雾报警器
     */
    KEntryFlagSmokeAlarm,
    /**
     *  一氧化碳报警器
     */
    KEntryFlagCarbonMonoxideAlarm,
    /**
     *  可燃气体报警器
     */
    KEntryFlagCombustibleGasAlarm,
    /**
     *  水浸探测器
     */
    KEntryFlagWaterDetector,
    /**
     *  温湿度探测器
     */
    KEntryFlagTemperatureAndHumidityDetector,
    /**
     *  紧急按钮
     */
    KEntryFlagEmergencyButton,
    /**
     *  萤石摄像机
     */
    KEntryFlagYingShiCamera,
    /**
     *  P2P摄像机
     */
    KEntryFlagP2PCamera,
    /**
     *  窗帘电机
     */
    KEntryFlagCurtainMotor,
    /**
     *  紫程晾衣机
     */
    KEntryFlagZiChengClothesHorse,
    /**
     *  奥科晾衣机
     */
    KEntryFlagAokeClothesHorse,
    /**
     *  智能遥控器
     */
    KEntryFlagSmartRemoteController,
    /**
     *  多功能控制盒
     */
    KEntryFlagMultiFunctionControlBox,
    /**
     *  ZigBee红外伴侣
     */
    KEntryFlagZigBeeInfraredPartner,
    
    
}KEntryFlag;

#endif
