//
//  UINavigationController+NHFullGesture.h
//  NHNavigationItemDemo
//
//  Created by neghao on 2018/6/22.
//  Copyright © 2018年 nenhall_studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NHFullGesture)
/**
 添加当前控制到禁止全屏返回手势的列表中
 @return 所有已禁止全屏返回手势的控制器
 */
- (NSDictionary<NSString *, NSString*> *)addFullScreenGestureBlackList;

/**
 把当前控制器从禁止全屏返回手势列表中移除
 */
- (void)removeFromFullScreenGestureBlackList;

@end

@interface UINavigationController (NHFullGesture)

/**
 关闭、打开全屏侧滑手势，默认是打开
 */
- (void)fullScreenGestureEnabled:(BOOL)enabled;


/**
 添加一个禁止全屏返回手势的控制器，传[xxx class] or @"class name"

 @param blackController 需要禁止全屏返回的类:[xxx class] or @"class name"
 @return 所有已禁止全屏返回手势的控制器
 */
- (NSDictionary<NSString *, NSString*> *)addFullScreenGestureBlackList:(id)blackController;


/**
 把某控制器从禁止全屏返回手势列表中移除

 @param blackController 需要移除的控制器
 */
- (void)removeFromFullScreenGestureBlackList:(id)blackController;

@end
