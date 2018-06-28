//
//  UINavigationController+NHFullGesture.m
//  NHNavigationItemDemo
//
//  Created by neghao on 2018/6/22.
//  Copyright © 2018年 nenhall_studio. All rights reserved.
//

#import "UINavigationController+NHFullGesture.h"
#include <objc/message.h>


@implementation UIViewController (NHFullGesture)

- (NSDictionary<NSString *,NSString *> *)addFullScreenGestureBlackList {
    
    return [self.navigationController addFullScreenGestureBlackList:[self class]];
}

- (void)removeFromFullScreenGestureBlackList {
    [self.navigationController removeFromFullScreenGestureBlackList:[self class]];
}

@end


@interface UINavigationController ()<UIGestureRecognizerDelegate>
@property(nonatomic, strong) NSMutableDictionary *interactivePopGestureBlackList;
@property (nonatomic, strong) UIPanGestureRecognizer * fullScreenGes;
@end


@implementation UINavigationController (NHFullGesture)

__attribute__((constructor)) static void NH_Inject(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        void (^nh_method_swizzling)(Class, SEL, SEL) = ^(Class class, SEL originalSelector, SEL swizzledSelector) {

            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

            if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        };

        nh_method_swizzling([UINavigationController class], @selector(viewDidLoad), @selector(nh_viewDidLoad));

    });
}


- (void)nh_viewDidLoad {
    [self nh_viewDidLoad];
    [self addFullPopGestureRecognizer];
}

- (void)addFullPopGestureRecognizer {
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");

    //  获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;

    //创建pan手势 作用范围是全屏
    UIPanGestureRecognizer * fullScreenGes = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    self.fullScreenGes = fullScreenGes;
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
}

- (void)fullScreenGestureEnabled:(BOOL)enabled{
    self.fullScreenGes.enabled = enabled;
}

- (NSDictionary<NSString *, NSString*> *)addFullScreenGestureBlackList:(id)blackController {

    if ([blackController isKindOfClass:[NSString class]]) {
        [self.interactivePopGestureBlackList setObject:blackController forKey:blackController];

    } else if ([blackController isSubclassOfClass:[UIViewController class]]) {
        NSString *className = NSStringFromClass([blackController class]);
        if (className) {
            [self.interactivePopGestureBlackList setObject:className forKey:className];
        } else {
            NSLog(@"%s：你添加的不是一个UIViewController类",__func__);
        }
        
    } else {
        NSLog(@"%s：你添加的不是一个UIViewController类",__func__);
    }
    
    return self.interactivePopGestureBlackList.copy;
}

- (void)removeFromFullScreenGestureBlackList:(id)blackController {
    
    if ([blackController isKindOfClass:[NSString class]]) {
        [self.interactivePopGestureBlackList removeObjectForKey:blackController];

    } else if ([blackController isSubclassOfClass:[UIViewController class]]) {
        NSString *className = NSStringFromClass([blackController class]);
        if (className) {
            [self.interactivePopGestureBlackList removeObjectForKey:className];
        } else {
            NSLog(@"%s：你移除的不是一个UIViewController类",__func__);
        }
        
    } else {
        NSLog(@"%s：你移除的不是一个UIViewController类",__func__);
    }
}

//拦截自定义手势的触发，并记录触发手势的开始位置
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {

    // 解决左滑冲突
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }

    //导航控制器的跟控制器不需要返回侧滑手势
    if (self.childViewControllers.count == 1) {
        return NO;
    }

    // 根据具体控制器对象决定是否开启全屏右滑返回
    for (NSString *viewController in self.interactivePopGestureBlackList) {
        if ([[self topViewController] isKindOfClass:NSClassFromString(viewController)]) {
            return NO;
        }
    }

    return YES;
}


#pragma mark - private method

- (void)setFullScreenGes:(UIPanGestureRecognizer *)fullScreenGes {
    objc_setAssociatedObject(self, @selector(fullScreenGes), fullScreenGes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPanGestureRecognizer *)fullScreenGes {
   return objc_getAssociatedObject(self, @selector(fullScreenGes));
}

- (void)setInteractivePopGestureBlackList:(NSMutableDictionary *)interactivePopGestureBlackList {
    objc_setAssociatedObject(self, @selector(interactivePopGestureBlackList), interactivePopGestureBlackList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)interactivePopGestureBlackList {
    NSMutableDictionary *list = objc_getAssociatedObject(self, @selector(interactivePopGestureBlackList));
    if (!list) {
        list = [[NSMutableDictionary alloc] initWithCapacity:2];
        [self setInteractivePopGestureBlackList:list];
    }
    return list;
}


@end

@implementation UIScrollView (Extension)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self panBack:gestureRecognizer]) {
        return NO;
    }
    //        UINavigationController *nav = (UINavigationController *)[gestureRecognizer.view currentViewController];
    //        if ([nav isKindOfClass:[UINavigationController class]]) {
    //            if (nav.viewControllers.count > 1) {
    //                return NO;
    //            }
    //        }
    return YES;
}

- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self];
        UIGestureRecognizerState state = gestureRecognizer.state;
        if (UIGestureRecognizerStateBegan == state || UIGestureRecognizerStatePossible == state) {
            CGPoint location = [gestureRecognizer locationInView:self];
            if (point.x > 0 && location.x < [UIScreen mainScreen].bounds.size.width && self.contentOffset.x <= 0) {
                return YES;
            }
        }
    }
    return NO;
}

@end

