//
//  YJAnswerPopTopView.h
//  答题详情
//
//  Created by 冯垚杰 on 2017/7/3.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJAnswerPopTopView : UIView

/**
 交卷
 */
@property (nonatomic,strong) void(^clickAssignmentBlock)(UIButton *button);

/**
 选题
 */
@property (nonatomic,strong) void(^clickSelectedTopicBlock)(UIButton *button);
@property (weak, nonatomic) IBOutlet UIButton *selectedTopicButton;

+ (instancetype)viewFromXib;

@end
