//
//  CategoryQuestionListModel.h
//  LearnFriendEnterprise
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryQuestionListModel : NSObject

/**
 用户已回答的题目数量
 */
@property (nonatomic, assign) NSInteger answeredNumber;

/**
 大题ID
 */
@property (nonatomic, assign) NSInteger categoryId;

/**
 是否显示大题标题（true为显示，false为不显示）
 */
@property (nonatomic, assign) BOOL displaytitle;

/**
 用户该大题的得分
 */
@property (nonatomic, strong) NSString * finalScore;

/**
 该大题下的题目ID列表，如果是填空题，每道题为空的列表，例如[["42_1"],["43_2","43_3"]]，说明该大题下有两个填空题，第1个填空题有一个空，第2个填空题有2个空
 */
@property (nonatomic, strong) NSArray * questionInputList;

/**
 大题下的题目列表
 */
@property (nonatomic, strong) NSArray * questionList;

/**
 大题类型编码（S-单选题；M-多项题；N-不定项选择题；F-填空题；J-判断题；Q-文字题）
 */
@property (nonatomic, strong) NSString * questionTypeCode;

/**
 大题标题
 */
@property (nonatomic, strong) NSString * questionTypeText;
@property (nonatomic, strong) NSString * questionTypeTitle;

/**
 大题总分
 */
@property (nonatomic, strong) NSString * totalScore;


@end

