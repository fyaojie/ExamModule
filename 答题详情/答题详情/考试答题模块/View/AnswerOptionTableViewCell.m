//
//  AnswerOptionTableViewCell.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "AnswerOptionTableViewCell.h"
#import "Header.h"

@interface AnswerOptionTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *optionLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation AnswerOptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.optionLabel.layer.cornerRadius = CGRectGetHeight(self.optionLabel.frame)/2;
    self.optionLabel.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ChoiceOptionListModel *)model {
    _model = model;
    
    self.optionLabel.text = model.chopLabel;
    

    self.optionLabel.layer.borderColor = model.checked ? HEXCOLOR(0x1cb177).CGColor : HEXCOLOR(0x777777).CGColor;
    
    self.optionLabel.backgroundColor = model.checked ? HEXCOLOR(0x1cb177) : [UIColor whiteColor];
    self.optionLabel.textColor = model.checked ? [UIColor whiteColor] : [UIColor blackColor];
    
    self.backgroundColor = GetISAnsweKey == NO && model.checked == YES ? HEXCOLOR(0xe4f6ef) : [UIColor whiteColor];
    
    
    
    if (GetISAnsweKey == NO) {
        
        if (!model.answer || model.answer.length <= 0) {
            return;
        }
        NSString *imageName = @"e_error";
        BOOL isRight = NO;
        for (int i = 0; i < model.answer.length; i ++) {
            unichar ch = [model.answer.uppercaseString characterAtIndex:i];
//            NSLog(@"%@",[NSString stringWithUTF8String:(char *)&ch]);
            
            if ([model.chopLabel.uppercaseString isEqualToString:[NSString stringWithUTF8String:(char *)&ch]]) {
                imageName = @"e_right";
                isRight = YES;
                break;
            }
        }
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@    ",model.chopText]];
        
        CGSize size = [model.chopText sizeWithpreferHeight:MAXFLOAT font:self.contentLabel.font];
        
        if (model.checked == YES  || isRight == YES) {
            //2.创建图片附件
            NSTextAttachment *attach=[[NSTextAttachment alloc]init];
            attach.image=[UIImage imageNamed:imageName];// e_right
            attach.bounds=CGRectMake(0, 0, size.height / 3 * 2, size.height / 3 * 2);
            //3.创建属性字符串 通过图片附件
            NSAttributedString *attrStr=[NSAttributedString attributedStringWithAttachment:attach];
            [string appendAttributedString:attrStr];
        }
        
        self.contentLabel.attributedText = string;
    } else {
        self.contentLabel.text = model.chopText;
    }
}

@end
