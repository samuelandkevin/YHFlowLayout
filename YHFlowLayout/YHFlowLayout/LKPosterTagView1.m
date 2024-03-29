// 自定义横排流水标签 实现文件
//  LKPosterTagView1.m
//  LaiKeBaoNew
//
//  Created by 黄坤鹏 on 2019/5/22.
//  Copyright © 2019 lgh. All rights reserved.
//

#import "LKPosterTagView1.h"

@interface LKPosterTagView1()
@property(nonatomic,copy) NSArray *dataArray;
@property(nonatomic,assign) CGFloat tagConWidth;//标签容器的宽度
@property(nonatomic,copy) NSMutableArray *frameArray;//标签的frame数组
@property(nonatomic,strong)NSMutableDictionary *dictWidthInRow;//记录每行标签的总宽度
@end

@implementation LKPosterTagView1


#pragma mark - init

- (instancetype)initWithTagConWidth:(CGFloat)tagConWidth{
    self = [super init];
    _tagConWidth = tagConWidth;
    return self;
}

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
    if(!_additionWidth){
        _additionWidth = 2*15;
    }
    
    if (!self.tagHeight) {
        self.tagHeight = 24;
    }
    if (!_tagVerticalSpace){
        _tagVerticalSpace = 7;
    }
    if (!_tagHorizontalSpace) {
        _tagHorizontalSpace = 7;
    }
    
    
    
    [self layoutUI];
}

- (void)layoutUI{
    
}

#pragma mark - Lazy Load

-(NSMutableArray *)frameArray{
    if (!_frameArray) {
        _frameArray = [NSMutableArray new];
    }
    return _frameArray;
}

#pragma mark - Public

- (CGFloat)getHeightWithDataArray:(NSArray<NSString *>*)array{
    self.dataArray   = array;
    [self.frameArray removeAllObjects];
    return [self setupTagsAndGetHeight];
}


- (CGFloat)setupTagsAndGetHeight{
    CGFloat totalHeight = 0;//总高度
    CGRect  previousFrame = CGRectZero;//前一个标签的frame
    CGFloat previousRowWidth = 0;//上一行的宽度
    CGFloat containerW = _tagConWidth ? _tagConWidth : self.bounds.size.width;//容器宽度
    CGFloat maxWidth = 0;//比较每一行，获取最大行宽度。
    NSInteger curRow = 1;//当前为第一行
    NSMutableDictionary *dictWidthInRow = [NSMutableDictionary new];
    for (int i=0; i<self.dataArray.count; i++) {
        NSString *str = self.dataArray[i];
        UILabel *lb = [UILabel new];
        lb.numberOfLines = 1;
        if (self.borderWidth) {
            lb.layer.borderWidth = self.borderWidth;
        }
        if (self.borderColor) {
            lb.layer.borderColor = self.borderColor.CGColor;
        }
        lb.tag      = 1000 + i;
        lb.font     = self.font;
        
        lb.textColor       = self.tagTextColor;
        lb.backgroundColor = self.tagColor;
        lb.text      = str;
        lb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.layer.cornerRadius   = self.tagHeight/2;
        lb.layer.masksToBounds  = YES;
        [self addSubview:lb];
        
        CGSize Size_str = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, self.tagHeight) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
        Size_str.width += _additionWidth;
        
        
        /******计算标签布局********/
        CGFloat tagWidth = Size_str.width;
        
        if (i == 0) {
            previousFrame.origin = CGPointMake(0, 0);
        }
        
        CGRect newRect = CGRectZero;
        
        CGFloat horizontalSpace = _tagHorizontalSpace;//水平方向间隔
        if(i == 0){
            horizontalSpace = 0;
            totalHeight    = self.tagHeight;
        }
        
        //控件的x坐标
        CGFloat newRectX = previousFrame.origin.x + CGRectGetWidth(previousFrame) + horizontalSpace ;
        
        if(newRectX + tagWidth  > containerW){
            
            //记录当前标签行的宽度
            previousRowWidth = tagWidth;
            
            //新起一行开始排版
            curRow += 1;
            
            //记录新一行的坐标
            newRect.origin = CGPointMake(0, previousFrame.origin.y + _tagVerticalSpace + self.tagHeight);
            totalHeight += (self.tagHeight + _tagVerticalSpace);
        }else {
            //在原来那一行继续排版
            newRect.origin = CGPointMake(newRectX,previousFrame.origin.y );
            
            //记录当前标签行的宽度
            previousRowWidth = newRectX + tagWidth;
            
        }
        
        //记录每一行标签的总宽度，dict可以去重
        [dictWidthInRow setObject:@(previousRowWidth) forKey:@(curRow)];
        
        
        if(self.numberOfRowsToShow && curRow > self.numberOfRowsToShow){
            lb.hidden = YES;//行数限制，其他行标签隐藏
        }
        
        newRect.size    = CGSizeMake(tagWidth,self.tagHeight);
        [lb setFrame:newRect];
        previousFrame   = newRect;
        [self.frameArray addObject:NSStringFromCGRect(newRect)];
        
    }
    
    _dictWidthInRow= dictWidthInRow;
    _numberOfRows  = curRow;
    _maxWidthInRow = maxWidth;
    _totalHeight   = totalHeight;
    return _totalHeight;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    LOWeakify(self);
    
    [self.dataArray enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
        LOStrongify(self);
        UILabel *lb       = [self viewWithTag:1000+idx];
        NSString *rectStr = self.frameArray[idx];
        [lb setFrame:CGRectFromString(rectStr)];
    }];
}

- (CGFloat)getWidthInRow:(NSInteger)row{
    CGFloat width =  [self.dictWidthInRow[@(row)] doubleValue];
    return width;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
