//
//  NHNavigationController.m
//  NHNavigationBarDemo
//
//  Created by nenhall_work on 2018/6/22.
//  Copyright © 2018年 nenhall_studio. All rights reserved.
//

#import "NHNavigationController.h"
#import <UIViewController+NHItem.h>



@interface NHNavigationController ()

@end

@implementation NHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationAppearance];
}


- (void)setNavigationAppearance {
    
    UINavigationBar *navBar = self.navigationBar;
    navBar.tintColor = [UIColor blackColor];
    navBar.barTintColor = [UIColor whiteColor];
    navBar.translucent = NO;
    [navBar setTitleTextAttributes:@{
                                     NSFontAttributeName:[UIFont systemFontOfSize:15],
                                     NSForegroundColorAttributeName:[UIColor blackColor]
                                     }
     ];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [viewController addBackItemWithTarget:self
                                   action:@selector(backController)
                                imageName:@"nav_back_black"
                               itemOffset:NHItemOffsetMake(-3, 0)];
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}


- (void)backController {
    [self popViewControllerAnimated:YES];
}


@end
