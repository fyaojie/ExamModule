//
//  AnswerHeaderView.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "AnswerHeaderView.h"


#import "Header.h"

#define ContentColor HEXCOLOR(0x777777)

#define LeftMargin 5
#define TopMargin 5

@interface AnswerHeaderView ()  <YYTextViewDelegate>
@property (nonatomic,strong) YYTextView *textView;

@property (nonatomic,strong) UILabel *typeLabel;

@property (nonatomic,strong) NSArray *rangeArray;

@end

@implementation AnswerHeaderView

- (YYTextView *)textView {
    if (!_textView) {
        _textView = [[YYTextView alloc] init];
        [self addSubview:_textView];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14];
    }
    return _textView;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textColor = HEXCOLOR(0x1cb177);
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.layer.borderColor = HEXCOLOR(0x1cb177).CGColor;
        _typeLabel.layer.borderWidth = 0.5;
    }
    return _typeLabel;
}

- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView {
    if (!GetISAnsweKey) {
        return NO;
    }
    return [self handleResponseWithText:textView];
}

- (void)textViewDidEndEditing:(YYTextView *)textView {

    NSMutableArray *muarr = [NSMutableArray array];
    [self.rangeArray enumerateObjectsUsingBlock:^(NSValue * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSAttributedString *att = [textView.attributedText attributedSubstringFromRange:NSMakeRange(obj.rangeValue.location + 1, obj.rangeValue.length - 1)];
        
        NSString *content = att.string;
        NSArray *tempArr = @[@"\t",@"\n"];
        for (NSString *str in tempArr) {
            content = [content stringByReplacingOccurrencesOfString:str withString:@""];
        }
        NSLog(@"textViewDidEndEditing:%@",content);
        [muarr addObject:content];
    }];
    
    QuestionListModel *QLModel = self.model;
    QLModel.fillBlankOptionList = muarr;
    self.model = QLModel;
    
    if (self.didEndEditingBlock) {
        self.didEndEditingBlock(QLModel);
    }
}



- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) { // 删除
        
        NSAttributedString *att = [textView.attributedText attributedSubstringFromRange:range];
        if (att.string.length > 0 && ![att.string isEqualToString:@"\t"] && att.attributes[@"NSUnderline"]) {
            
            __block NSInteger tempIdx = -1;
            NSMutableArray *muarr = [NSMutableArray array];
            [self.rangeArray enumerateObjectsUsingBlock:^(NSValue  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.rangeValue.location <= range.location &&  obj.rangeValue.location + obj.rangeValue.length >= range.location) { // 获取改变是哪个下划线部分
                    NSValue *value = [NSValue valueWithRange:NSMakeRange(obj.rangeValue.location, obj.rangeValue.length - 1)];
                    [muarr addObject:value];
                    tempIdx = idx;
                } else {
                    if (tempIdx >= 0) {
                        [muarr addObject:[NSValue valueWithRange:NSMakeRange(obj.rangeValue.location - 1, obj.rangeValue.length)]];
                    } else {
                        [muarr addObject:obj];
                    }
                }
            }];
            self.rangeArray = muarr;
            [self updateFrame];
            
            return YES;
        }
        [self endEditing:YES];
        
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [self endEditing:YES];
        return NO;
    }
    
    if (text.length > 0 && self.rangeArray.count > 0) {
        
       __block NSInteger tempIdx = -1;
        NSMutableArray *muarr = [NSMutableArray array];
        [self.rangeArray enumerateObjectsUsingBlock:^(NSValue  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.rangeValue.location <= range.location &&  obj.rangeValue.location + obj.rangeValue.length >= range.location) { // 获取改变是哪个下划线部分
                NSValue *value = [NSValue valueWithRange:NSMakeRange(obj.rangeValue.location, obj.rangeValue.length + text.length)];
                [muarr addObject:value];
                tempIdx = idx;
            } else {
                if (tempIdx >= 0) {
                    [muarr addObject:[NSValue valueWithRange:NSMakeRange(obj.rangeValue.location + text.length, obj.rangeValue.length)]];
                } else {
                    [muarr addObject:obj];
                }
            }
        }];
        self.rangeArray = muarr;
        [self updateFrame];
    }
    
    return YES;
}

- (void)textViewDidChange:(YYTextView *)textView {
//    NSLog(@"textViewDidChange");
}
- (void)textViewDidChangeSelection:(YYTextView *)textView {

    if ([self handleResponseWithText:textView] == NO) {
        [self endEditing:YES];
    }
}

- (BOOL)handleResponseWithText:(YYTextView *)textView {
    __block BOOL isExist = NO;
    [self.rangeArray enumerateObjectsUsingBlock:^(NSValue * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (textView.selectedRange.location > obj.rangeValue.location + 1 && textView.selectedRange.location <= obj.rangeValue.location + obj.rangeValue.length) {
            isExist = YES;
            *stop = YES;
        }
    }];
    return isExist;
}

- (void)setModel:(QuestionListModel *)model {
    _model = model;
    self.textView.frame = CGRectMake(LeftMargin, 0, [UIScreen mainScreen].bounds.size.width - LeftMargin, 0);
    NSMutableAttributedString *muatt = [[NSMutableAttributedString alloc] init];

    self.typeLabel.text = [NSString stringWithFormat:@"%@  ",model.qtypename];

    CGSize size = [self.typeLabel.text sizeWithpreferHeight:MAXFLOAT font:self.typeLabel.font];
    self.typeLabel.frame = CGRectMake(0, 0, size.width, size.height);
    
    NSMutableAttributedString *labelatt = [NSMutableAttributedString attachmentStringWithContent:self.typeLabel contentMode:(UIViewContentModeCenter) attachmentSize:(self.typeLabel.size) alignToFont:self.textView.font alignment:YYTextVerticalAlignmentTop];
    [muatt appendAttributedString:labelatt];
    
    NSString *tempStr = [NSString stringWithFormat:@"  %@[%@分]",model.text,model.score];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    if (model.fillBlankOptionList && model.fillBlankOptionList.count > 0) {
       NSArray *tempArr = [self rangesOfString:@"{|*|}" inString:tempStr replacing:model.fillBlankOptionList];
        
        if ([tempArr.firstObject isKindOfClass:[NSArray class]]) {
            self.rangeArray = tempArr.firstObject;
        }
        [str appendString:tempArr.lastObject];
    } else {
        [str appendString:[tempStr stringByReplacingOccurrencesOfString:@"{|*|}" withString:@"\t\t\t\t"]];
        self.rangeArray = [self rangesOfString:@"\t\t\t\t" inString:str.string];
    }
    
    [self.rangeArray enumerateObjectsUsingBlock:^(NSValue * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [str addAttribute:NSForegroundColorAttributeName value:
         ContentColor range:obj.rangeValue];
        [str addAttribute:NSUnderlineStyleAttributeName value:
         [NSNumber numberWithInteger:NSUnderlineStyleSingle] range:obj.rangeValue]; // 下划线类型
        [str addAttribute:NSUnderlineColorAttributeName value:
         ContentColor range:obj.rangeValue]; // 下划线颜色
    }];
    [muatt appendAttributedString:str];
    
    [muatt addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, muatt.length)];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 3; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    // 行间距设置
    [muatt addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, muatt.length)];

    
    self.textView.attributedText = muatt;
    
    [self updateFrame];
}

- (void)updateFrame {
    self.textView.frame = CGRectMake(LeftMargin, TopMargin, [UIScreen mainScreen].bounds.size.width - LeftMargin, self.textView.contentSize.height);
    self.headerHeight = self.textView.contentSize.height + TopMargin * 2;
}


- (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str replacing:(NSArray *)replacing {
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSRange searchRange = NSMakeRange(0, [str length]);
    
    NSRange range;
    
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        
        [results addObject:[NSValue valueWithRange:range]];
        
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    
    for (NSInteger i = results.count - 1; i >= 0; i--) {
        
        str = [str stringByReplacingCharactersInRange:[results[i] rangeValue] withString:[NSString stringWithFormat:@"\t\t%@\t\t",replacing[i]]];
    }
    
    NSMutableArray *rangeArray = [NSMutableArray array];
    [replacing enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSRange range = [str rangeOfString:[NSString stringWithFormat:@"\t\t%@\t\t",obj]];
        if (range.location > str.length || range.length > str.length) {
            
        } else {
            [rangeArray addObject:[NSValue valueWithRange:range]];
        }
        
    }];
    
    return @[rangeArray,str];
}

// 某个字符串在大字符串中所有的range
- (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSRange searchRange = NSMakeRange(0, [str length]);
    
    NSRange range;
    
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        
        [results addObject:[NSValue valueWithRange:range]];
        
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    
    return results;
}

@end
