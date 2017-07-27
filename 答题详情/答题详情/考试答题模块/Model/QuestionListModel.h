//
//  QuestionListModel.h
//  LearnFriendEnterprise
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChoiceOptionModel.h"
#import <UIKit/UIKit.h>
@interface QuestionListModel : NSObject

/**
 文字题输入框的行数
 */
@property (nonatomic,copy) NSString *answerRows;

/**
 用户的答案（选择题为选项ID的数组，填空题为各个空的数组，判断题为R或W，文字题为回答的内容）
 */
@property (nonatomic,copy) NSString *answertext;
/**
 非选择题的正确答案（判断题时R代表正确，W代表错误；）
 */
@property (nonatomic, strong) NSString * answer;
/**
 题目分数
 */
@property (nonatomic, strong) NSString * score;

/**
 题干内容，填空题题干中的{|*|}代表空，显示时需用______替换
 */
@property (nonatomic, strong) NSString * text;

/**
 题目类型编码（S-单选题；M-多项题；N-不定项选择题；F-填空题；J-判断题；Q-文字题）
 */
@property (nonatomic, strong) NSString * qtypecode;

/**
 题目类型名称
 */
@property (nonatomic,copy) NSString *qtypename;

@property (nonatomic, strong) NSString * name;

// ==========================考试独有字段========================================

@property (nonatomic, strong) ChoiceOptionModel * choiceOption;

/**
 题目ID
 */
@property (nonatomic,copy) NSString *id;

/**
 填空题的答案
 */
@property (nonatomic,strong) NSArray *fillBlankOptionList;


// ==========================成绩报告独有字段========================================
/**
 用户是否答对该题目（true代表对，false代表错）
 */
@property (nonatomic, assign) BOOL correctindicator;
/**
 0到1之间的小数，用户答对该题的正确比例，主要针对填空题和问答题
 */
@property (nonatomic, assign) CGFloat correctpersent;
@property (nonatomic, strong) NSString * descriptionField;

/**
 用户该题目的得分
 */
@property (nonatomic, strong) NSString * finalscore;


/**
 答题状态
 */
@property (nonatomic, assign) NSInteger answerStatus;

@end


    
