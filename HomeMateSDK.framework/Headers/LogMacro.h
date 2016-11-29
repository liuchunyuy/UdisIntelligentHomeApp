//
//  LogMacro.h
//  Unity-iPhone
//
//  Created by abc on 13-6-24.
//
//

#define __SHOW__HM__LOG__

#ifdef __SHOW__HM__LOG__

typedef enum {
    
    LEVEL_ALL,
    LEVEL_1,
    LEVEL_2,
    LEVEL_3,
    LEVEL_4,
    LEVEL_5,
    
}LOG_LEVEL;

extern void myLevelLog(int line,char *functname,char *file,LOG_LEVEL level, id formatstring,...);
#define DLog(format,...) myLevelLog(__LINE__,(char *)__FUNCTION__,(char *)__FILE__,LEVEL_ALL,format, ##__VA_ARGS__)

#else

#define DLog(...)

#endif
