//自定义横排流水标签 头文件

//
//  LKPosterTagView1.h
//  LaiKeBaoNew
//
//  Created by 黄坤鹏 on 2019/5/22.
//  Copyright © 2019 lgh. All rights reserved.
//  海报标签1

#import <UIKit/UIKit.h>
#import "YHFlowLayoutHeader.h"
typedef NS_ENUM(NSInteger, PosterType) {
    PosterType1, //海报风格1
    PosterType2  //海报风格2
};
NS_ASSUME_NONNULL_BEGIN

@interface LKPosterTagView1 : UIView


@property (nonatomic, assign)CGFloat   tagHorizontalSpace;//标签与标签之间的水平间距
@property (nonatomic, assign)CGFloat   tagVerticalSpace;  //标签与标签之间的垂直间距
@property (nonatomic, assign)CGFloat   additionWidth;//额外的宽度，比如获取的字符串“在售”的宽度为12，additionWidth为字符串“在售”的左右宽度总和
@property (nonatomic, assign)CGFloat   tagHeight;        //单个标签的高度
@property (nonatomic, strong)UIFont    *font;
@property (nonatomic, assign)CGFloat   borderWidth;      //标签的border宽度
@property (nonatomic, strong)UIColor   *borderColor;     //标签的border颜色
@property (nonatomic, assign,readonly)CGFloat maxWidthInRow; //总宽度最大的一行的宽度。
@property (nonatomic, assign,readonly)CGFloat totalHeight; //容器的总高度
@property (nonatomic, assign,readonly)NSInteger numberOfRows;//标签实际的行数。
@property (nonatomic, assign)NSInteger numberOfRowsToShow;      //行数限制显示，（默认为0，有多少行就显示多少行）

- (instancetype)initWithTagConWidth:(CGFloat)tagConWidth;

/**
 获取标签的高度
 
 @param dicTags dicTags
 @param posterType 海报风格类型
 @return 高度
 */
- (CGFloat)getHeightWithDictTags:(NSMutableDictionary *)dicTags posterType:(PosterType)posterType;


/**
 获取第row行标签的总宽度
 注意row是从1开始！
 @param row 行
 @return 宽度
 */
- (CGFloat)getWidthInRow:(NSInteger)row;
@end

NS_ASSUME_NONNULL_END


