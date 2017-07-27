//
//  AnswerOptionTableViewCell.h
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoiceOptionListModel.h"

@interface AnswerOptionTableViewCell : UITableViewCell  // 选择题 选项

@property (nonatomic,strong) ChoiceOptionListModel *model;

@end


