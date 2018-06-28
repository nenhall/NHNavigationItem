//
//  UINavigationItem+NHItem.h
//  NHNavigationItemDemo
//
//  Created by nenhall_work on 2018/6/22.
//  Copyright © 2018年 nenhall_studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+NHFullGesture.h"

/** BarItem的间隙 */
struct NHItemOffset {
    CGFloat insetsOffset;/**< BarItem 内部的间隙*/
    CGFloat itemSpace;/**< BarItem与BarItem之间的间隙，用在有多个item的时候 */
};
typedef struct CG_BOXABLE NHItemOffset NHItemOffset;

/**
 BarItem的间隙 (insetsOffset: 内部的间隙, itemSpace: BarItem与BarItem的间隙)
 
 @param insetsOffset barItem 内部的间隙
 @param itemSpace barItem与barItem的间隙
 */
NHItemOffset NHItemOffsetMake(CGFloat insetsOffset, CGFloat itemSpace);

/** The "zero" offsetangle -- equivalent to NHItemOffsetMake(0, 0). */
CG_EXTERN const NHItemOffset NHItemOffsetMakeZero;


@interface UIViewController (NHItem)


/**
 重置左边所有的itemBar
 */
- (void)resetLeftItems;


/**
 重置右边所有的itemBar
 */
- (void)resetRightItems;

NS_ASSUME_NONNULL_BEGIN

/**
 导航栏的左边添加一个返回按钮
 */
- (UIBarButtonItem *)addBackItemWithBlock:(void(^)(void))actionBlock
                                imageName:(NSString *)imageName
                               itemOffset:(struct NHItemOffset)itemOffset;

/**
 导航栏的左边添加一个返回按钮
 */
- (UIBarButtonItem *)addBackItemWithTarget:(id)target
                                    action:(SEL)action
                                 imageName:(NSString *)imageName
                                itemOffset:(struct NHItemOffset)itemOffset;


/**
 导航栏的左边添加一个按钮

 @param title 标题
 @param imageName 图片名
 @param itemOffset 偏移
 @param titleTextAttributes 标题大小及颜色
 @param actionBlock 响应事件链
 */
- (UIBarButtonItem *)addLeftItemWithTitle:(nullable NSString *)title
                                imageName:(nullable NSString *)imageName
                               itemOffset:(struct NHItemOffset)itemOffset
                      titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey, id>* (^)(void))titleTextAttributes
                              actionBlock:(void(^_Nullable)(void))actionBlock;


/**
 导航栏的左边添加一个按钮
 */
- (UIBarButtonItem *)addLeftItemWithTitle:(nullable NSString *)title
                                imageName:(nullable NSString *)imageName
                               itemOffset:(struct NHItemOffset)itemOffset
                      titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey, id>* (^)(void))titleTextAttributes
                                   target:(id)target
                                   action:(SEL)action;

/**
 导航栏的左边添加多个按钮
 */
- (UIBarButtonItem *)addMoreLeftItemWithTitle:(nullable NSString *)title
                                    imageName:(nullable NSString *)imageName
                                   itemOffset:(struct NHItemOffset)itemOffset
                          titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey, id>* (^)(void))titleTextAttributes
                                  actionBlock:(void(^_Nonnull)(void))actionBlock;

/**
 导航栏的左边添加多个按钮
 */
- (UIBarButtonItem *)addMoreLeftItemWithTitle:(nullable NSString *)title
                                    imageName:(nullable NSString *)imageName
                                   itemOffset:(struct NHItemOffset)itemOffset
                          titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey, id>* (^)(void))titleTextAttributes
                                       target:(id)target
                                       action:(SEL)action;


/**
 导航栏的右边添加一个按钮
 
 @param title 标题
 @param imageName 图片名
 @param itemOffset 偏移
 @param titleTextAttributes 标题大小及颜色
 @param actionBlock 响应事件链
 */
- (UIBarButtonItem *)addRightItemWithTitle:(nullable NSString *)title
                                 imageName:(nullable NSString *)imageName
                                itemOffset:(struct NHItemOffset)itemOffset
                       titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey, id>* (^)(void))titleTextAttributes
                               actionBlock:(void(^)(void))actionBlock;


/**
 导航栏的右边添加一个按钮
 */
- (UIBarButtonItem *)addRightItemWithTitle:(nullable NSString *)title
                                 imageName:(nullable NSString *)imageName
                                itemOffset:(struct NHItemOffset)itemOffset
                       titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey, id>* (^)(void))titleTextAttributes
                                    target:(id)target
                                    action:(SEL)action;

/**
 导航栏的右边添加多个按钮
 */
- (UIBarButtonItem *)addMoreRightItemWithTitle:(nullable NSString *)title
                                     imageName:(nullable NSString *)imageName
                                    itemOffset:(struct NHItemOffset)itemOffset
                           titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey, id>* (^)(void))titleTextAttributes
                                   actionBlock:(void(^)(void))actionBlock;

/**
 导航栏的右边添加多个按钮
 */
- (UIBarButtonItem *)addMoreRightItemWithTitle:(nullable NSString *)title
                                     imageName:(nullable NSString *)imageName
                                    itemOffset:(struct NHItemOffset)itemOffset
                           titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey, id>* (^)(void))titleTextAttributes
                                        target:(id)target
                                        action:(SEL)action;
@end


NS_ASSUME_NONNULL_END


