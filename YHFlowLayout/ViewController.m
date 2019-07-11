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
    LKPosterTagView1 *tag1 = [[LKPosterTagView1 alloc] initWithTagConWidth:200];
    [self.view addSubview:tag1];
    
    
}


@end
