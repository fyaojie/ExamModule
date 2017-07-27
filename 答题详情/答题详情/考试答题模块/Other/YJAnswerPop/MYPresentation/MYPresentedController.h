//
//  ViewController.h
//  MYPresentation
//
//  Created by qc on 2017/5/3.
//  Copyright © 2017年 qc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYPresentAnimationManager.h"

typedef void(^handleBack)(id callback);

@interface MYPresentedController : UIViewController

//创建菜单
- (instancetype)initWithShowFrame:(CGRect)showFrame ShowStyle:(MYPresentedViewShowStyle)showStyle callback:(handleBack)callback;
//是否展开
@property (nonatomic, assign,getter=isPresented) BOOL presented;
//是否需要显示透明蒙板
@property (nonatomic, assign,getter=isNeedClearBack) BOOL clearBack;
//回调
@property (copy, nonatomic)handleBack callback;

@end
