//
//  QuestionListModel.m
//  LearnFriendEnterprise
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "QuestionListModel.h"
#import <MJExtension/MJExtension.h>

#define ISAnsweKey @"ISAnsweKey"  // yes 代表答题  no 代表成绩报告
#define GetISAnsweKey [[[NSUserDefaults standardUserDefaults] objectForKey:ISAnsweKey] boolValue]
#define SetISAnsweKey(bool) [[NSUserDefaults standardUserDefaults] setObject:@(bool) forKey:ISAnsweKey];

@implementation QuestionListModel

- (NSString *)qtypename {
    
    NSDictionary *dict = @{@"S":@"单选题",
                           @"M":@"多项题",
                           @"N":@"不定项选择题",
                           @"F":@"填空题",
                           @"J":@"判断题",
                           @"Q":@"文字题"};
    
    if (dict[self.qtypecode.uppercaseString]) {
        return dict[self.qtypecode];
    }
    return self.qtypecode;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"descriptionField":@"description"
             };
}

- (NSInteger)answerStatus {
    if (!GetISAnsweKey || self.answertext.length > 0 || self.fillBlankOptionList.count > 0 ) {
        return 2;  //
    }
    return 0;
}

@end
