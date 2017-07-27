//
//  ViewController.h
//  MYPresentation
//
//  Created by qc on 2017/5/3.
//  Copyright © 2017年 qc. All rights reserved.
//

#import "MYColorBackView.h"

@implementation MYColorBackView

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,64)];
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

- (UIView *)backColorView
{
    if (!_backColorView) {
        _backColorView = [[UIView alloc]initWithFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - 64)];
    }
    return _backColorView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.topView];
        [self addSubview:self.backColorView];
    }
    return self;
}

@end
