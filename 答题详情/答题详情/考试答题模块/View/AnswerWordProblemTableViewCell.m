//
//  AnswerWordProblemTableViewCell.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/29.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "AnswerWordProblemTableViewCell.h"
#import "Header.h"

@interface AnswerWordProblemTableViewCell () <YYTextViewDelegate>
//@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet YYTextView *textView;


@end

@implementation AnswerWordProblemTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.borderColor = HEXCOLOR(0xdfdfdf).CGColor;
    self.textView.textVerticalAlignment = YYTextVerticalAlignmentTop;
    self.textView.placeholderFont = self.textView.font;
    self.textView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QuestionListModel *)model {
    _model = model;
    
    self.textView.text = model.answertext;
}

- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView {
    return GetISAnsweKey;
}

- (void)textViewDidEndEditing:(YYTextView *)textView {
    
    QuestionListModel *QLModel = self.model;
    QLModel.answertext = textView.text;
    self.model = QLModel;
    
    if (self.didEndEditingBlock) {
        self.didEndEditingBlock(QLModel);
    }
}

@end
