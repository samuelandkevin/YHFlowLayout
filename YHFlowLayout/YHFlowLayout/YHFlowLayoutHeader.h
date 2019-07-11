//
//  YHFlowLayoutHeader.h
//  YHFlowlayout
//
//  Created by kunpeng on 2019/7/11.
//  Copyright © 2019 samuelandkevin. All rights reserved.
//

#ifndef YHFlowLayoutHeader_h
#define YHFlowLayoutHeader_h

// 十六进制颜色
#define LO_COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#ifndef LOWeakify
#if __has_feature(objc_arc)
#define LOWeakify(object)  __weak __typeof__(object) weak##_##object = object;
#else
#define LOWeakify(object)  __block __typeof__(object) block##_##object = object;
#endif
#endif

#ifndef LOStrongify
#if __has_feature(objc_arc)
#define LOStrongify(object)  __typeof__(object) object = weak##_##object;
#else
#define LOStrongify(object)  __typeof__(object) object = block##_##object;
#endif
#endif

#endif /* YHFlowLayoutHeader_h */
