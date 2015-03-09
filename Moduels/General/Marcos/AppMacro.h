//
//  AppMacro.h
//  SnapWine
//
//  Created by ZYW on 14/7/4.
//  Copyright (c) 2014年 zyw. All rights reserved.
//

#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#undef  RE_SINGLETON
#define RE_SINGLETON(__class) [__class sharedInstance]

#define RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 \
green:(g) / 255.0 \
blue:(b) / 255.0 \
alpha:(a)]

#define RGB(r, g, b) RGBA((r), (g), (b), 255)

#define RGBA0X(rgba) RGBA((rgb & 0xff000000) >> 24, \
(rgb & 0x00ff0000) >> 16, \
(rgb & 0x0000ff00) >> 8, \
(rgb & 0x000000ff) >> 0)

#define RGB0X(rgb) RGBA0X((rgb << 8) + 0xff)

//http://www.snapwine.net
#define SERVEURL  @"http://www.snapwine.net" // @"http://121.42.40.196"  //@"http://www.pai9.com.cn" //@"http://192.168.199.237:8000"   // @"http://124.205.208.198" /*@"http://www.pai9.com.cn"*/

#define REMINDREA_TTIME 120

#define REMINDUPD_TIME 15

#define JPUSHKEY @"2f97dedc870abd983debbb2d"
#define JPUSHSCRECT @"72189952119aacc882828e41"

#define SERVERBASEURL @"http://127.0.0.1:8080/"
#define SERVERURL(method) [NSString stringWithFormat:@"%@%@",SERVERBASEURL,method]

#define EASEMOB_KEY     @"YXA6SeRDcJP-EeSlXyVdlH8h2g"
#define EASEMOB_SCRECT  @"YXA6D3vDuCBFeoTjSWgYNU4onvT9Srs"





















