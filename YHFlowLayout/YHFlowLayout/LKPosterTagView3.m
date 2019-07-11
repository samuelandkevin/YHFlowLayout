//自定义竖排流水标签 实现文件

//
//  LKPosterTagView3.m
//  LaiKeBaoNew
//
//  Created by 黄坤鹏 on 2019/5/22.
//  Copyright © 2019 lgh. All rights reserved.
//

#import "LKPosterTagView3.h"

@interface LKPosterTagView3()

@property(nonatomic,strong) NSMutableDictionary *dicTags;
@property(nonatomic,copy) NSArray *dataArray;//原来的标签字符串数组
@property(nonatomic,strong)NSMutableArray *dataFormatArray;//存放格式化后标签的字符串数组，比如“在售”，转成“在/n售”
@property(nonatomic,strong)NSMutableArray *heightArray;
@property(nonatomic,copy) NSArray *colorsArray; //tag背景颜色
@property(nonatomic,copy) NSArray *textColorsArray;//tag文本颜色
@property(nonatomic,copy) void (^totalWidthBlock)(CGFloat);
@end


@implementation LKPosterTagView3

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI{
    if (!self.font) {
        self.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
    }
    if(!_additionHeight){
        _additionHeight = 26;
    }
    
    if (!self.tagWidth) {
        self.tagWidth = 24;
    }
    if (!_tagVerticalSpace){
        _tagVerticalSpace = 10;
    }
    if (!_tagHorizontalSpace) {
        _tagHorizontalSpace = 10;
    }
    
}

-(NSMutableArray *)heightArray{
    if (!_heightArray) {
        _heightArray = [NSMutableArray new];
    }
    return _heightArray;
}

-(NSMutableArray *)dataFormatArray{
    if (!_dataFormatArray) {
        _dataFormatArray = [NSMutableArray new];
    }
    return _dataFormatArray;
}

- (void)setTagsWithDict:(NSMutableDictionary *)dicTags totalWidth:(void(^)(CGFloat))totalWidth{
    
    _dicTags = dicTags;
    _totalWidthBlock = totalWidth;
    
    NSMutableArray *totalArr = [NSMutableArray new];
    NSMutableArray *totalColorArr = [NSMutableArray new];
    NSMutableArray *totalTextColorArr = [NSMutableArray new];
    
    NSArray *arr1 = _dicTags[@"key1"];
    
    UIColor *color1 = LO_COLOR_WITH_HEX(0x1C82FF);
    UIColor *color2 = LO_COLOR_WITH_HEX(0xFF6F21);
    UIColor *otherCol = LO_COLOR_WITH_HEX(0xF6F6F6);
    
    UIColor *textCol = LO_COLOR_WITH_HEX(0xFFFFFF);
    UIColor *otherTextCol = LO_COLOR_WITH_HEX(0x333333);
    
    if (arr1.count) {
        [totalArr addObjectsFromArray:arr1];
        [totalColorArr addObject:color1];
        [totalTextColorArr addObject:textCol];
    }
    
    NSArray *arr2 = _dicTags[@"key2"];
    
    if (arr2.count) {
        [totalArr addObjectsFromArray:arr2];
        [totalColorArr addObject:color2];
        [totalTextColorArr addObject:textCol];
    }
    
    
    NSArray *arr3 = _dicTags[@"key3"];
    if (arr3.count) {
        [totalArr addObjectsFromArray:arr3];
        for (int i=0; i<arr3.count; i++) {
            [totalColorArr addObject:otherCol];
            [totalTextColorArr addObject:otherTextCol];
        }
    }
    self.dataArray = [totalArr copy];
    self.colorsArray = [totalColorArr copy];
    self.textColorsArray = [totalTextColorArr copy];
    
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    [self.dataFormatArray removeAllObjects];
    for (int i=0; i<self.dataArray.count; i++) {
        
        NSString *str = self.dataArray[i];
        UILabel *lb = [UILabel new];
        lb.numberOfLines = 0;
        lb.layer.borderColor = LO_COLOR_WITH_HEX(0xCCCCCC).CGColor;
        lb.layer.borderWidth = 0.5;
        lb.tag      = 1000 + i;
        lb.font     = self.font;
        NSMutableString *maStr = [[NSMutableString alloc] initWithString:str];
        for (int i = 1; i < str.length; i ++) {
            [maStr insertString:@"\n" atIndex:i*2 - 1];
        }
        lb.textColor = [UIColor blackColor];
        lb.text = maStr;
        lb.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.layer.cornerRadius   = self.tagWidth * 0.5;
        lb.layer.masksToBounds  = YES;
        lb.backgroundColor = LO_COLOR_WITH_HEX(0xEEEEEE);
        [self addSubview:lb];
        [self.dataFormatArray addObject:maStr];
        
    }
    
    LOWeakify(self);
    [self.dataArray enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
        LOStrongify(self);
        
        NSMutableString *maStr = self.dataFormatArray[idx];
        CGSize Size_str = [maStr boundingRectWithSize:CGSizeMake(self.tagWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
        Size_str.height += _additionHeight;
        
        [self.heightArray addObject:@(Size_str.height)];
        
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    LOWeakify(self);
    __block CGFloat totalWidth = 0;//总宽度
    
    __block CGRect previousFrame = CGRectZero;
    __block CGRect lbSize     = CGRectZero;
    CGFloat containerW = self.bounds.size.width;
    CGFloat containerH = self.bounds.size.height;
    
    [self.dataArray enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
        LOStrongify(self);
        
        
        UILabel *lb = [self viewWithTag:1000+idx];
        
        CGFloat tagHeight = [self.heightArray[idx] doubleValue];
        
        if (idx == 0 ) {
            previousFrame.origin = CGPointMake(containerW-self.tagWidth, 0);
        }
        
        
        CGRect newRect = CGRectZero;
        
        CGFloat verticalSpace = _tagVerticalSpace;//垂直间隔
        if(idx == 0){
            verticalSpace = 0;
            totalWidth    = self.tagWidth;
        }
        
        //控件的y坐标
        CGFloat newRectY = previousFrame.origin.y + tagHeight + verticalSpace;
        //容器的高度
        //        CGFloat containerH = self.bounds.size.height;
        if(newRectY + tagHeight  > containerH){
            //新起一列开始排版
            newRect.origin = CGPointMake(previousFrame.origin.x - _tagHorizontalSpace - self.tagWidth, 0);
            totalWidth += (self.tagWidth + _tagHorizontalSpace);
        }else {
            //在原来那一列继续排版
            newRect.origin = CGPointMake(previousFrame.origin.x, previousFrame.origin.y + CGRectGetHeight(previousFrame) + verticalSpace);
            
        }
        
        newRect.size    = CGSizeMake(self.tagWidth, tagHeight);
        [lb setFrame:newRect];
        previousFrame   = newRect;
        
        lbSize = newRect;
    }];
    if (_totalWidthBlock && totalWidth) {
        _totalWidthBlock(totalWidth);
    }
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
