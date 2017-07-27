//
//  AnswerWordProblemTableViewCell.h
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/29.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"

@interface AnswerWordProblemTableViewCell : UITableViewCell // 文字题

@property (nonatomic,strong) QuestionListModel *model;

@property (nonatomic,strong) void(^didEndEditingBlock)(QuestionListModel *model);

@end
