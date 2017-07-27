//
//  ViewController.h
//  MYPresentation
//
//  Created by qc on 2017/5/3.
//  Copyright © 2017年 qc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYPresentedController.h"

@interface MYPresentationController : UIPresentationController

@property (nonatomic, assign) MYPresentedViewShowStyle style;
@property (nonatomic, assign,getter=isNeedClearBack) BOOL clearBack;
//frame
@property (assign, nonatomic) CGRect showFrame;
@end
