//
//  AnswerCompletionResultTableViewCell.h
//  答题详情
//
//  Created by 冯垚杰 on 2017/7/2.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionListModel.h"

@interface AnswerCompletionResultTableViewCell : UITableViewCell // 填空题或者问答题答案

@property (nonatomic,strong) QuestionListModel *model;

@end
