//
//  AnswerDetailedTableViewCell.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "AnswerDetailedTableViewCell.h"

@interface AnswerDetailedTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation AnswerDetailedTableViewCell

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
    
    self.contentLabel.text = [NSString stringWithFormat:@"详解:%@",model.descriptionField];
}

@end
