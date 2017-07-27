//
//  ChoiceOptionModel.h
//  LearnFriendEnterprise
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoiceOptionModel : NSObject


/**
 选择题的正确答案
 */
@property (nonatomic, strong) NSString * choiceAnswer;

/**
 选择题的选项列表
 */
@property (nonatomic, strong) NSArray * choiceOptionList;

@end

 
