//
//  AnswerModel.h
//  LearnFriendEnterprise
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnswerTestInfoModel.h"

@interface AnswerModel : NSObject

@property (nonatomic, assign) NSInteger actAttId;
@property (nonatomic, assign) NSInteger actatthisid;

/**
 试卷题目列表，数组中每个元素为一个大题
 */
@property (nonatomic, strong) NSArray * categoryQuestionList;
@property (nonatomic, assign) NSInteger monitorid;
@property (nonatomic, assign) NSInteger questionnaireId;
@property (nonatomic, assign) NSInteger startTime;

/**
 试卷信息及答卷情况
 */
@property (nonatomic, strong) AnswerTestInfoModel * testInfo;

@end

