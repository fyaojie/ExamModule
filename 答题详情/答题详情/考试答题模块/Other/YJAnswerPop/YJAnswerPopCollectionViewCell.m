//
//  YJAnswerPopCollectionViewCell.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/7/3.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "YJAnswerPopCollectionViewCell.h"

@interface YJAnswerPopCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YJAnswerPopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.layer.borderWidth = 0.5;
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.titleLabel.layer.cornerRadius = CGRectGetHeight(self.titleLabel.frame)/2.0;
}

- (void)setModel:(YJAnswerPopModel *)model {
    _model = model;
    
    self.titleLabel.text = model.number;
    
    switch (model.status) {
        case YJAnswerPopStatusNoAnswer:
            self.titleLabel.backgroundColor = [UIColor whiteColor];
            self.titleLabel.layer.borderColor = [UIColor redColor].CGColor;
            break;
        case YJAnswerPopStatusAnswering:
            self.titleLabel.backgroundColor = [UIColor whiteColor];
            self.titleLabel.layer.borderColor = [UIColor brownColor].CGColor;
            break;
        case YJAnswerPopStatusAnswered:
            self.titleLabel.backgroundColor = [UIColor orangeColor];
            self.titleLabel.layer.borderColor = [UIColor orangeColor].CGColor;
            break;
            
        default:
            break;
    }
}

@end
