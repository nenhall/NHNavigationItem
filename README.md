# NHNavigationItem

> 一个完全支持在系统原生的导航栏上面随意定制导航按钮及自带侧滑返回手势的工具类，你只需要简单调用一句代码即可添加导航栏按钮，支持block回调及函数调用。
>
> 支持系统平台：iPhone、iPad iOS 8.0 ~ 11
>
> 功能特性：
>
> 1. 完美解决在iOS11上返回按钮与边缘间隙无法控制问题；
>
> 2. 自带全屏返回手势，已处理与scrollView的冲突问题；
>
> 3. 随意控制每一个控制器的全屏返回势的开关；
>
> 4. 可全面性的定制按钮：文字大小、颜色、图片、事件链；
>
> 5. 使用方便，侵入性小，你只需要将两文件拖入工程导入头文件即可；

#### 添加NavigationItem使用方法：

* 部份属性说明

  ```
  NHItemOffsetMake(CGFloat insetsOffset, CGFloat itemSpace);
  //insetsOffset：button内部的偏移，可用来控制按钮与屏幕边缘的间隙
  //itemSpace：用于同一个方向添加了多个按钮的时候，来控制按钮与按钮之间的间隙
  ```

* 统一设置所有push出来的控制器的返回按钮：

  ```objective-c
  @interface NHNavigationController : UINavigationController
  @end
  @implementation NHNavigationController
  // ...  
  - (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
      
      [viewController addBackItemWithTarget:self
                                     action:@selector(backController)
                                  imageName:@"nav_back_black"
                                 itemOffset:NHItemOffsetMake(-3, 0)];
          
      [super pushViewController:viewController animated:animated];
  }
  @end
  ```

* 给控制器导航栏左边添加一个按钮方法一(不设置button文字属性)

  ```objective-c
  [self addLeftItemWithTitle:@"保存" imageName:nil itemOffset:NHItemOffsetMake(-10, 0) titleTextAttributes:nil target:self action:@selector(backController)];
  ```

* 给控制器导航栏左边添加一个按钮方法二(并设置button文字属性)

  ```objective-c
  [self addLeftItemWithTitle:@"保存" imageName:nil itemOffset:NHItemOffsetMake(-10, 0) titleTextAttributes:^NSDictionary<NSAttributedStringKey,id> * _Nonnull{
          return @{
                   NSForegroundColorAttributeName:[UIColor redColor],
                   NSFontAttributeName : [UIFont systemFontOfSize:15],
                   };
      } actionBlock:^{
          //do  something
      }];
  ```

* 给控制器导航栏右边添加一个按钮方法

  ```objective-c
  [self addRightItemWithTitle:nil imageName:@"icon_search" itemOffset:NHItemOffsetMake(-6, 0) titleTextAttributes:^NSDictionary<NSAttributedStringKey,id> * _Nonnull{
          return @{NSForegroundColorAttributeName:[UIColor blueColor]};
      } actionBlock:^{
          //do  something
      }];
  ```

* 给控制器导航栏右边添加多个按钮方法

  ```
  //`addMore`开头的方法调用一次就会添加一个左/右边按钮，以此类推
  //添加的顺序都是先从边缘往中间排
  //右边添加多个按钮
  [self addMoreRightItemWithTitle:nil imageName:@"icon_search" itemOffset:NHItemOffsetMake(-6, 0) titleTextAttributes:^NSDictionary<NSAttributedStringKey,id> * _Nonnull{
          return @{NSForegroundColorAttributeName:[UIColor blueColor]};
      } actionBlock:^{
          NSLog(@"点击了搜索");
      }];
      
  //左边添加多个按钮：[self addMoreLeftItemWithTitle:...];
  ```

* 取出相应按钮

  ```
  /*
   * 如果你还需要自定义`button`的其它属性，按如下方法：
   * 从`UIBarButtonItem`的`customView`属性中取出来的就是对应的`button`
   */
  UIBarButtonItem *item = [self addMoreRightItemWithTitle:@"下一步" imageName:nil itemOffset:NHItemOffsetMake(6, 0) titleTextAttributes:^NSDictionary<NSAttributedStringKey,id> * _Nonnull{
          return @{NSForegroundColorAttributeName:[UIColor blackColor]};
      } target:self action:@selector(goNextVC)];
      
  // UIButton *button2 = item.customView;
  // button2.backgroundColor = [UIColor blueColor];
  ```


#### 全屏返回手势使用

* UIViewController的实例方法：添加当前控制到禁止全屏返回手势的列表中

  ```
  - (NSDictionary<NSString *, NSString*> *)addFullScreenGestureBlackList;
  ```

  

* 添加一个指定的控制器到禁止全屏返回手势的列表中

  ```
  /**
   @param blackController 需要禁止全屏返回的类:传[xxx class] or @"class name"
   @return 所有已禁止全屏返回手势的控制器
   */
  - (NSDictionary<NSString *, NSString*> *)addFullScreenGestureBlackList:(id)blackController;
  ```

  * 示例

    ```
    @interface NHNextViewController : UIViewController
    @end
    
    @implementation NHNextViewController
    
    - (void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
    	//把当前控制添加到禁止全屏返回手势列表中
        [self addFullScreenGestureBlackList];
    }
    ```
* 从全屏返回手势列表中移除
   ```
   //把当前控制器从禁止全屏返回手势列表中移除
   - (void)removeFromFullScreenGestureBlackList;
    
    /**
    移除指定的控制器
    */
   - (void)removeFromFullScreenGestureBlackList:(id)blackController;
   ```

* 开启或关闭全屏侧滑手势，

  ```
  /**
   关闭、打开全屏侧滑手势，默认是打开，此属性是全局的(控制整个工程)
   */
  - (void)fullScreenGestureEnabled:(BOOL)enabled;
  ```
