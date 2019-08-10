//
//  ViewController.m
//  YHFlowlayout
//
//  Created by kunpeng on 2019/7/11.
//  Copyright © 2019 samuelandkevin. All rights reserved.
//

#import "ViewController.h"
#import "LKPosterTagView1.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LKPosterTagView1 *tag1 = [[LKPosterTagView1 alloc] initWithTagConWidth:self.view.bounds.size.width];
    tag1.font      = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
    tag1.tagHeight = 18;
    tag1.tagColor  = LO_COLOR_WITH_HEX(0xF6F6F6);
    tag1.tagTextColor = LO_COLOR_WITH_HEX(0x555555);
    tag1.additionWidth = 16;
    tag1.tagVerticalSpace   = 5;
    tag1.tagHorizontalSpace = 5;
    CGFloat height = [tag1 getHeightWithDataArray:@[@"风采点击",@"达瓦",@"格局法规价格",@"晚点再说",@"史蒂夫34の",@"爱的发的是",@"来一个",@"凤凰号发货哈撒丽枫酒店撒荆防颗粒"]];
    tag1.frame = CGRectMake(0, 100, self.view.bounds.size.width, height);
    tag1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:tag1];
    
    
}


@end
