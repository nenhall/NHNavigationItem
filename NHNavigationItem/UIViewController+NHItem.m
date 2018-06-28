//
//  UINavigationItem+NHItem.m
//  NHNavigationItemDemo
//
//  Created by nenhall_work on 2018/6/22.
//  Copyright © 2018年 nenhall_studio. All rights reserved.
//

#import "UIViewController+NHItem.h"
#include <objc/message.h>


NHItemOffset NHItemOffsetMake(CGFloat insetsOffset, CGFloat itemSpace) {
    NHItemOffset itemoffset;
    itemoffset.itemSpace = itemSpace;
    itemoffset.insetsOffset = insetsOffset;
    return itemoffset;
}

const NHItemOffset NHItemOffsetMakeZero = {0, 0};


@interface UIButton (NHItemAction)
@property (nonatomic, copy) void(^itemActionBlock)(void);
@end

@implementation UIButton (NHItemAction)
- (void)setItemActionBlock:(void (^)(void))itemActionBlock {
    objc_setAssociatedObject(self, @selector(itemActionBlock), itemActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(void))itemActionBlock {
    return objc_getAssociatedObject(self, @selector(itemActionBlock));
}
@end


@interface UIViewController ()
@property (nonatomic, strong) NSPointerArray *leftItems;
@property (nonatomic, strong) NSPointerArray *rightItems;
@end

@implementation UIViewController (NHItem)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"
#pragma clang diagnostic ignored "-Wnonnull"

- (void)resetLeftItems {
    self.leftItems = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItems = nil;
}

- (void)resetRightItems {
    self.rightItems = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItems = nil;
}

- (UIBarButtonItem *)addBackItemWithTarget:(id)target
                                    action:(SEL)action
                                 imageName:(NSString *)imageName
                                itemOffset:(struct NHItemOffset)itemOffset {
    return [self addLeftItemWithTitle:nil
                            imageName:imageName
                           itemOffset:itemOffset
                  titleTextAttributes:nil
                               target:target
                               action:action];
}

- (UIBarButtonItem *)addBackItemWithBlock:(void (^)(void))actionBlock
                                imageName:(NSString *)imageName
                               itemOffset:(struct NHItemOffset)itemOffset {
    return [self addLeftItemWithTitle:nil
                            imageName:imageName
                           itemOffset:itemOffset
                  titleTextAttributes:nil
                          actionBlock:actionBlock];
}


- (UIBarButtonItem *)addLeftItemWithTitle:(NSString *)title
                                imageName:(NSString *)imageName
                               itemOffset:(struct NHItemOffset)itemOffset
                      titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey,id> * _Nonnull (^)(void))titleTextAttributes
                              actionBlock:(void (^ _Nullable)(void))actionBlock {
    
    UIButton *button = [self createLButtonTitle:title imageName:imageName titleTextAttributes:titleTextAttributes];
    [self setButton:button Offset:itemOffset left:YES];
    [self setButton:button target:nil action:nil actionBlock:actionBlock];
    return [self settingLeftBarItems:button itemOffset:itemOffset isMore:NO];
}



- (UIBarButtonItem *)addLeftItemWithTitle:(NSString *)title
                                imageName:(NSString *)imageName
                               itemOffset:(struct NHItemOffset)itemOffset
                      titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey,id> * _Nonnull (^)(void))titleTextAttributes
                                   target:(nonnull id)target
                                   action:(nonnull SEL)action {
    
    UIButton *button = [self createLButtonTitle:title imageName:imageName titleTextAttributes:titleTextAttributes];
    [self setButton:button Offset:itemOffset left:YES];
    [self setButton:button target:target action:action actionBlock:nil];
    return [self settingLeftBarItems:button itemOffset:itemOffset isMore:NO];
    
}

- (UIBarButtonItem *)addMoreLeftItemWithTitle:(NSString *)title
                                    imageName:(NSString *)imageName
                                   itemOffset:(struct NHItemOffset)itemOffset
                          titleTextAttributes:(nullable NSDictionary<NSAttributedStringKey,id> * _Nonnull (^)(void))titleTextAttributes
                                  actionBlock:(void (^ _Nonnull)(void))actionBlock {
    
    UIButton *button = [self createLButtonTitle:title imageName:imageName titleTextAttributes:titleTextAttributes];
    [self setButton:button Offset:itemOffset left:YES];
    [self setButton:button target:nil action:nil actionBlock:nil];
    return [self settingLeftBarItems:button itemOffset:itemOffset isMore:YES];
}

- (UIBarButtonItem *)addMoreLeftItemWithTitle:(NSString *)title
                                    imageName:(NSString *)imageName
                                   itemOffset:(struct NHItemOffset)itemOffset
                          titleTextAttributes:(NSDictionary<NSAttributedStringKey,id> * _Nonnull (^)(void))titleTextAttributes
                                       target:(id)target
                                       action:(SEL)action {
    
    UIButton *button = [self createLButtonTitle:title imageName:imageName titleTextAttributes:titleTextAttributes];
    [self setButton:button Offset:itemOffset left:YES];
    [self setButton:button target:target action:action actionBlock:nil];
    return [self settingLeftBarItems:button itemOffset:itemOffset isMore:YES];
}

- (UIBarButtonItem *)addRightItemWithTitle:(NSString *)title
                                 imageName:(NSString *)imageName
                                itemOffset:(struct NHItemOffset)itemOffset
                       titleTextAttributes:(NSDictionary<NSAttributedStringKey,id> * _Nonnull (^)(void))titleTextAttributes
                               actionBlock:(void (^)(void))actionBlock {
    UIButton *button = [self createLButtonTitle:title imageName:imageName titleTextAttributes:titleTextAttributes];
    [self setButton:button Offset:itemOffset left:NO];
    [self setButton:button target:nil action:nil actionBlock:actionBlock];
    return [self settingRightBarItems:button itemOffset:itemOffset isMore:NO];
}

- (UIBarButtonItem *)addRightItemWithTitle:(NSString *)title
                                 imageName:(NSString *)imageName
                                itemOffset:(struct NHItemOffset)itemOffset
                       titleTextAttributes:(NSDictionary<NSAttributedStringKey,id> * _Nonnull (^)(void))titleTextAttributes
                                    target:(id)target
                                    action:(SEL)action {
    
    UIButton *button = [self createLButtonTitle:title imageName:imageName titleTextAttributes:titleTextAttributes];
    [self setButton:button Offset:itemOffset left:NO];
    [self setButton:button target:target action:action actionBlock:nil];
    return [self settingRightBarItems:button itemOffset:itemOffset isMore:NO];
}


- (UIBarButtonItem *)addMoreRightItemWithTitle:(NSString *)title
                                     imageName:(NSString *)imageName
                                    itemOffset:(struct NHItemOffset)itemOffset
                           titleTextAttributes:(NSDictionary<NSAttributedStringKey,id> * _Nonnull (^)(void))titleTextAttributes
                                   actionBlock:(void (^)(void))actionBlock {
    
    UIButton *button = [self createLButtonTitle:title imageName:imageName titleTextAttributes:titleTextAttributes];
    [self setButton:button Offset:itemOffset left:NO];
    [self setButton:button target:nil action:nil actionBlock:actionBlock];
    return [self settingRightBarItems:button itemOffset:itemOffset isMore:YES];
}

- (UIBarButtonItem *)addMoreRightItemWithTitle:(NSString *)title
                                     imageName:(NSString *)imageName
                                    itemOffset:(struct NHItemOffset)itemOffset
                           titleTextAttributes:(NSDictionary<NSAttributedStringKey,id> * _Nonnull (^)(void))titleTextAttributes
                                        target:(id)target
                                        action:(SEL)action {
    
    UIButton *button = [self createLButtonTitle:title imageName:imageName titleTextAttributes:titleTextAttributes];
    [self setButton:button Offset:itemOffset left:NO];
    [self setButton:button target:target action:action actionBlock:nil];
    return [self settingRightBarItems:button itemOffset:itemOffset isMore:YES];
}

#pragma clang diagnostic pop
- (UIButton *)createLButtonTitle:(NSString *)title
                       imageName:(NSString *)imageName
             titleTextAttributes:(NSDictionary<NSAttributedStringKey, id>* (^)(void))titleTextAttributes {
    
    CGFloat titleWidth;
    UIFont *font = [UIFont systemFontOfSize:15];
    
    UIButton *itemButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [itemButton setTitle:title forState:UIControlStateNormal];
    if (imageName) {
        UIImage *image = [UIImage imageNamed:imageName];
        [itemButton setImage:image forState:UIControlStateNormal];
        [itemButton setImage:image forState:UIControlStateNormal | UIControlStateHighlighted];
    }
    
    if (titleTextAttributes && titleTextAttributes()) {
        NSMutableDictionary *att = titleTextAttributes().mutableCopy;
        if ([att objectForKey:NSFontAttributeName]) {
            [itemButton.titleLabel setFont:[att objectForKey:NSFontAttributeName]];
        } else {
            [att setObject:NSFontAttributeName forKey:font];
            [itemButton.titleLabel setFont:font];
        }
        
        UIColor *titleColor = [att objectForKey:NSForegroundColorAttributeName];
        if (titleColor) {
            [itemButton setTitleColor:titleColor forState:UIControlStateNormal];
        } else {
            [att setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
            [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        titleWidth = [title sizeWithAttributes:att].width;
        CGRect rect = itemButton.frame;
        if (titleWidth > rect.size.width) {
            rect.size.width = titleWidth;
            itemButton.frame = rect;
        }
    } else {
        itemButton.titleLabel.font = font;
        [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleWidth = [title sizeWithAttributes:@{ NSFontAttributeName : font }].width;
        CGRect rect = itemButton.frame;
        if (titleWidth > rect.size.width) {
            rect.size.width = titleWidth;
            itemButton.frame = rect;
        }
    }
    
    return itemButton;
}

- (void)setButton:(UIButton *)itemButton Offset:(NHItemOffset)itemOffset left:(BOOL)left {
    
    CGFloat leftOffset = itemOffset.insetsOffset;
    CGFloat rightOffset = itemOffset.insetsOffset;
    
    if (left) {
        leftOffset = itemOffset.insetsOffset;
        rightOffset = 0;
        itemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    } else {
        rightOffset = itemOffset.insetsOffset;
        leftOffset = 0;
        itemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
#ifdef __IPHONE_11_0
    if (@available(iOS 11, *)) {
        itemButton.contentEdgeInsets = UIEdgeInsetsMake(0, leftOffset, 0, rightOffset);
    }
#else
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        itemButton.contentEdgeInsets = UIEdgeInsetsMake(0, leftOffset, 0, rightOffset);
    }
#endif
}

- (void)setButton:(UIButton *)itemButton
           target:(id)target
           action:(SEL)action
      actionBlock:(nonnull void (^)(void))actionBlock {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if (actionBlock) {
        [itemButton setItemActionBlock:actionBlock];
        [itemButton addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [itemButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
#pragma clang diagnostic pop
}

- (UIBarButtonItem *)settingLeftBarItems:(UIButton *)itemButton itemOffset:(NHItemOffset)itemOffset isMore:(BOOL)isMore {
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
    NSMutableArray *items = [[NSMutableArray alloc] init];

    if (isMore) {

        if (!itemButton.titleLabel.text) {
            CGRect rect = itemButton.frame;
            rect.size.width = 40;
            itemButton.frame = rect;
        }
        
        if (!self.leftItems) {
            self.leftItems = [NSPointerArray weakObjectsPointerArray];
        }
        
        for (UIBarButtonItem *item in self.leftItems) {
            [items addObject:item];
        }
        
        [self.leftItems addPointer:(__bridge void *)barItem];
    }

    [items addObject:[self addSpaceItem:(items.count > 0) ? itemOffset.itemSpace : itemOffset.insetsOffset]];
    [items addObject:barItem];
    self.navigationItem.leftBarButtonItems = items;

    return barItem;
}



- (UIBarButtonItem *)settingRightBarItems:(UIButton *)itemButton itemOffset:(NHItemOffset)itemOffset isMore:(BOOL)isMore {
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
    NSMutableArray *items = [[NSMutableArray alloc] init];

    if (isMore) {
        if (!itemButton.titleLabel.text) {
            CGRect rect = itemButton.frame;
            rect.size.width = 40;
            itemButton.frame = rect;
        }
        
        if (!self.leftItems) {
            self.leftItems = [NSPointerArray weakObjectsPointerArray];
        }
        
        for (UIBarButtonItem *item in self.leftItems) {
            [items addObject:item];
        }
        
        [self.leftItems addPointer:(__bridge void *)barItem];
    }
    
    [items addObject:[self addSpaceItem:(items.count > 0) ? itemOffset.itemSpace : itemOffset.insetsOffset]];
    [items addObject:barItem];
    self.navigationItem.rightBarButtonItems = items;

    return barItem;
}


#pragma mark - private method
- (void)itemAction:(UIButton *)button {
    if (button.itemActionBlock) {
        button.itemActionBlock();
    }
}

- (void)setLeftItems:(NSPointerArray *)leftItems {
    objc_setAssociatedObject(self, @selector(leftItems), leftItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSPointerArray *)leftItems {
    return objc_getAssociatedObject(self, @selector(leftItems));
}

- (void)setRightItems:(NSPointerArray *)rightItems {
    objc_setAssociatedObject(self, @selector(rightItems), rightItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSPointerArray *)rightItems {
    return objc_getAssociatedObject(self, @selector(rightItems));
}

- (UIBarButtonItem *)addSpaceItem:(CGFloat)space {
    UIBarButtonItem *backSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    backSpace.width = space;
    return backSpace;
}

- (void)setButton:(UIButton *)button imageName:(NSString *)imageName titleTextAttributes:(NSDictionary<NSAttributedStringKey, id>* (^)(void))titleTextAttributes {
    
    if (imageName) {
        UIImage *image = [UIImage imageNamed:imageName];
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateNormal | UIControlStateHighlighted];
    }
    
    if (titleTextAttributes) {
        NSDictionary *att = titleTextAttributes();
        if (att) {
            
            if ([att objectForKey:NSFontAttributeName]) {
                [button.titleLabel setFont:[att objectForKey:NSFontAttributeName]];
            }
            
            UIColor *titleColor = [att objectForKey:NSForegroundColorAttributeName];
            if (titleColor) {
                [button setTitleColor:titleColor forState:UIControlStateNormal];
            }
        }
    }
}

@end
