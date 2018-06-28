//
//  NHNextViewController.m
//  NHNavigationBarDemo
//
//  Created by nenhall_work on 2018/6/22.
//  Copyright © 2018年 nenhall_studio. All rights reserved.
//

#import "NHNextViewController.h"
#import <UIViewController+NHItem.h>

@interface NHNextViewController ()

@end

@implementation NHNextViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self addFullScreenGestureBlackList];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    __weak typeof(self)weakself = self;
    [self addRightItemWithTitle:@"从黑名单中移除" imageName:nil itemOffset:NHItemOffsetMake(0, 0) titleTextAttributes:^NSDictionary<NSAttributedStringKey,id> * _Nonnull{
        
        return @{NSForegroundColorAttributeName:[UIColor blackColor],
                 NSFontAttributeName : [UIFont systemFontOfSize:12],
                 };
        
    } actionBlock:^{

        [weakself removeFromFullScreenGestureBlackList];
    }];
    
}

- (void)backController {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
