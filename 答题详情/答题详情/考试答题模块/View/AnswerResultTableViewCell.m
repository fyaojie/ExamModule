//
//  AnswerResultTableViewCell.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "AnswerResultTableViewCell.h"

@interface AnswerResultTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *rightKeyLabel; // 正确答案
@property (weak, nonatomic) IBOutlet UILabel *userAnswerLabel; // 用户答案
@property (weak, nonatomic) IBOutlet UILabel *answerResultLabel; // 回答结果

@end

@implementation AnswerResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QuestionListModel *)model {
    _model = model;
    
    self.answerResultLabel.text = [NSString stringWithFormat:@"回答:[%@]",model.correctindicator ? @"正确" :@"错误"];
    
    // 选择题
    if ([self.model.qtypecode.uppercaseString isEqualToString:@"S"] || [self.model.qtypecode.uppercaseString isEqualToString:@"M"] || [self.model.qtypecode.uppercaseString isEqualToString:@"N"]) {
        self.rightKeyLabel.text = [NSString stringWithFormat:@"正确答案是:%@",model.answer];
        self.userAnswerLabel.text = [NSString stringWithFormat:@"您的答案是:%@",model.choiceOption.choiceAnswer];
    }
    
    if ([self.model.qtypecode.uppercaseString isEqualToString:@"J"]) {
        
        self.rightKeyLabel.text = [NSString stringWithFormat:@"正确答案是:%@",[model.answer.uppercaseString isEqualToString:@"R"] ? @"正确" : @"错误"];
        self.userAnswerLabel.text = [NSString stringWithFormat:@"您的答案是:%@",[model.answertext.uppercaseString isEqualToString:@"R"] ? @"正确" : @"错误"];
    }
}

@end
