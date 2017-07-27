//
//  AnswerHeaderView.h
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"

@interface AnswerHeaderView : UIView

//+ (AnswerHeaderView *)loadViewFromXib;

@property (nonatomic,strong) QuestionListModel *model;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic,strong) void(^didEndEditingBlock)(QuestionListModel *model);

@end
