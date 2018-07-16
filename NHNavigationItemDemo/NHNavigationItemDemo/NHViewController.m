//
//  NHViewController.m
//  NHNavigationItemDemo
//
//  Created by neghao on 2018/6/22.
//  Copyright © 2018年 nenhall_studio. All rights reserved.
//

#import "NHViewController.h"
#import "NHNextViewController.h"
#import <NHNavigationItem/NHNavigationItem.h>


@interface NHViewController ()

@end

@implementation NHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self addLeftItemWithTitle:@"保存" imageName:nil itemOffset:NHItemOffsetMake(-10, 0) titleTextAttributes:^NSDictionary<NSAttributedStringKey,id> * _Nonnull{
//        return @{
//                 NSForegroundColorAttributeName:[UIColor redColor],
//                 NSFontAttributeName : [UIFont systemFontOfSize:15],
//                 };
//    } actionBlock:^{
//        NSLog(@"点击了保存");
//    }];
    
    [self addLeftItemWithTitle:@"保存" imageName:nil itemOffset:NHItemOffsetMake(-6, 0) titleTextAttributes:nil target:self action:@selector(backController)];
    
    
    [self addMoreRightItemWithTitle:nil imageName:@"icon_search" itemOffset:NHItemOffsetMake(-6, 0) titleTextAttributes:^NSDictionary<NSAttributedStringKey,id> * _Nonnull{
        return @{NSForegroundColorAttributeName:[UIColor blueColor]};
    } actionBlock:^{
        NSLog(@"点击了搜索");
    }];
    
    
    UIBarButtonItem *item = [self addMoreRightItemWithTitle:@"下一步" imageName:nil itemOffset:NHItemOffsetMake(6, 0) titleTextAttributes:^NSDictionary<NSAttributedStringKey,id> * _Nonnull{
        return @{NSForegroundColorAttributeName:[UIColor blackColor]};
    } target:self action:@selector(goNextVC)];
    
    /*
     * 如果你还需要自定义button的其它属性，按如下方法：
     */
    UIButton *button2 = item.customView;
    button2.backgroundColor = [UIColor whiteColor];
    
}

- (void)backController {
    NSLog(@"点击了保存");

}

- (void)goNextVC {
    [self goNextVC:nil];
}

- (IBAction)goNextVC:(UIButton *)sender {
    
    NHNextViewController *next = [[NHNextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

@end
