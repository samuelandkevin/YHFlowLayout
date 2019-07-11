//自定义竖排流水标签 头文件

//
//  LKPosterTagView3.h
//  LaiKeBaoNew
//
//  Created by 黄坤鹏 on 2019/5/22.
//  Copyright © 2019 lgh. All rights reserved.
//  海报标签3

#import <UIKit/UIKit.h>
#import "YHFlowLayoutHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface LKPosterTagView3 : UIView


@property (nonatomic, assign)CGFloat   tagHorizontalSpace;//标签与标签之间的水平间距
@property (nonatomic, assign)CGFloat   tagVerticalSpace;//标签与标签之间的垂直间距
@property (nonatomic, assign)CGFloat   additionHeight;//额外的高度，比如获取的字符串“在售”的高度为12，additionWidth为字符串“在售”的上下高度总和
@property (nonatomic, assign)CGFloat   tagWidth;//单个标签总宽度
@property (nonatomic, strong)UIFont    *font;

@property (assign, nonatomic,readonly)  CGFloat totalWidth;//标签容器的宽度
/**
 设置标签
 
 @param dicTags dicTags, totalWidth 标签容器的宽度回调
 
 */
- (void)setTagsWithDict:(NSMutableDictionary *)dicTags totalWidth:(void(^)(CGFloat))totalWidth;

@end

NS_ASSUME_NONNULL_END
