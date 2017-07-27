//
//  AnswerJudgeTableViewCell.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "AnswerJudgeTableViewCell.h"

#import "Header.h"

@interface AnswerJudgeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;


@end

@implementation AnswerJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QuestionListModel *)model index:(NSInteger)index {
    
    self.titleLabel.text = index == 0 ? @"对" : @"错";
    
    NSString *imageName = (index == 0 && [model.answertext.uppercaseString isEqualToString:@"R"]) || (index ==1  && [model.answertext.uppercaseString isEqualToString:@"W"]) ? @"e_select_s" : @"e_select";
    self.statusImageView.image = [UIImage imageNamed:imageName];
    
    self.backgroundColor = GetISAnsweKey == NO && [imageName isEqualToString:@"e_select_s"] ? HEXCOLOR(0xe4f6ef) : [UIColor whiteColor];
    
    if (GetISAnsweKey) {
        self.resultImageView.hidden = YES;
    } else {
        
        if ([model.answer isEqualToString:model.answertext]) { // 回答正确
            if ((index == 0 && [model.answer.uppercaseString isEqualToString:@"R"]) || (index ==1  && [model.answer.uppercaseString isEqualToString:@"W"]) ) {
                self.resultImageView.image = [UIImage imageNamed:@"e_right"];
                self.resultImageView.hidden = NO;
            } else {
                self.resultImageView.hidden = YES;
            }
        } else {
            self.resultImageView.hidden = NO;
            if ((index == 0 && [model.answer.uppercaseString isEqualToString:@"R"]) || (index ==1  && [model.answer.uppercaseString isEqualToString:@"W"]) ) {
                self.resultImageView.image = [UIImage imageNamed:@"e_error"];
            } else {
                self.resultImageView.image = [UIImage imageNamed:@"e_right"];
            }
        }
    }

}

@end
