//
//  ScoreReportModel.h
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/30.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnswerTestInfoModel.h"

@interface ScoreReportModel : NSObject


/**
 评卷人，当assessor为空时在页面不显示评卷人及评卷时间
 */
@property (nonatomic, strong) NSString * assessor;

/**
 评卷时间
 */
@property (nonatomic, strong) NSString * assesstime;
@property (nonatomic, strong) NSArray * categoryQuestionList;

/**
 当前是第几次测试成绩
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 我的得分
 */
@property (nonatomic, strong) NSString * myScore;

/**
 考试状态
 */
@property (nonatomic, strong) NSString * myStatus;

/**
 总共有几次测试成绩
 */
@property (nonatomic, assign) NSInteger pageCount;

/**
 交卷时间
 */
@property (nonatomic, strong) NSString * testCommitTime;
@property (nonatomic, strong) AnswerTestInfoModel * testInfo;

@end
