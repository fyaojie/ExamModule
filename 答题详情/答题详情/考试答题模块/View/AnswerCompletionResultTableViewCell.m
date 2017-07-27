//
//  AnswerCompletionResultTableViewCell.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/7/2.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "AnswerCompletionResultTableViewCell.h"

@interface AnswerCompletionResultTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *rightKeyLabel; // 正确答案
@property (weak, nonatomic) IBOutlet UILabel *answerResultLabel; // 回答结果
@end

@implementation AnswerCompletionResultTableViewCell

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
    
    if ([model.qtypecode.uppercaseString isEqualToString:@"F"]) {
        self.answerResultLabel.text = [NSString stringWithFormat:@"回答:[%@]",model.correctindicator ? @"正确" :@"错误"];
        
        self.rightKeyLabel.text = [NSString stringWithFormat:@"正确答案:%@",[model.fillBlankOptionList componentsJoinedByString:@"、"]];
    }
    
    if ([model.qtypecode.uppercaseString isEqualToString:@"Q"]) {
        self.answerResultLabel.text = [NSString stringWithFormat:@"您的得分:[%@]",model.finalscore];
        
        self.rightKeyLabel.text = [NSString stringWithFormat:@"参考答案:\n%@",model.answer];
    }
    
}


@end
