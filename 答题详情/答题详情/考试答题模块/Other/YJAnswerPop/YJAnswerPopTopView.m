//
//  YJAnswerPopTopView.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/7/3.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "YJAnswerPopTopView.h"

@implementation YJAnswerPopTopView

#pragma mark- (快速从xib中加载)
+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (IBAction)clickAssignmen:(UIButton *)sender {
    if (self.clickAssignmentBlock) {
        self.clickAssignmentBlock(sender);
    }
}

- (IBAction)clickSelectedTopic:(UIButton *)sender {
    if (self.clickSelectedTopicBlock) {
        self.clickSelectedTopicBlock(sender);
    }
}

@end
