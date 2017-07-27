//
//  AnswerTestInfoModel.h
//  LearnFriendEnterprise
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestTypeModel.h"

@interface AnswerTestInfoModel : NSObject

/**
 课程（考试）的成绩ID
 */
@property (nonatomic, assign) NSInteger actAttId;
@property (nonatomic, assign) NSInteger actTestAttId;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) NSInteger allowattemptfailed;
@property (nonatomic, assign) BOOL allowdisplayscore;
@property (nonatomic, assign) BOOL allowpause;
@property (nonatomic, assign) BOOL allowreview;

/**
 答题时间（分钟）
 */
@property (nonatomic, assign) NSInteger answerTime;

/**
 答题时是否只能切换到下一题（1代表是，0代表否）
 */
@property (nonatomic, assign) NSInteger answernextque;

/**
 每题至多答题时间，（0代表不限制）
 */
@property (nonatomic, assign) NSInteger answerquetime;
@property (nonatomic, assign) BOOL assessind;
@property (nonatomic, assign) NSInteger assessmentId;
@property (nonatomic, assign) NSInteger attemptmethod;
@property (nonatomic, assign) NSInteger attemptperiod;
@property (nonatomic, assign) NSInteger categoryNumber;

/**
 试卷提交模式（0=整卷提交　1=逐题提交 2=逐大题提交  3=每隔5分钟自动提交）
 */
@property (nonatomic, assign) NSInteger commitmode;

@property (nonatomic, assign) NSInteger containChildCatalog;
@property (nonatomic, assign) NSInteger createdate;
@property (nonatomic, assign) NSInteger creator;
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, assign) NSInteger difficultlevel;
@property (nonatomic, strong) NSString * displayanswer;
@property (nonatomic, assign) NSInteger displaymode;
@property (nonatomic, strong) NSString * endtime;
@property (nonatomic, strong) NSArray * exactCol;

/**
 出卷时间
 */
@property (nonatomic, strong) NSString * formatDate;

/**
 合格分数
 */
@property (nonatomic, assign) NSInteger formatPassingscore;

/**
 试卷总分
 */
@property (nonatomic, strong) NSString * formatScore;
@property (nonatomic, assign) NSInteger fromScore;
@property (nonatomic, assign) NSInteger fromTime;

/**
 试卷生成策略（1=题目与选项都固定  2=题目固定选项随机 3=题目随机选项固定 4=题目与选项都随机）
 */
@property (nonatomic, assign) NSInteger generatemode;
@property (nonatomic, assign) BOOL hastAttendance;
@property (nonatomic, assign) NSInteger maxattempts;
@property (nonatomic, assign) NSInteger modifiedby;
@property (nonatomic, assign) NSInteger modifieddate;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger passingscore;
@property (nonatomic, assign) NSInteger questionNumber;

/**
 需求问卷ID
 */
@property (nonatomic, assign) NSInteger questionnaireId;

/**
 剩余答题时间（0代表还有全部时间，单位为秒）
 */
@property (nonatomic, assign) NSInteger remainingTime;
@property (nonatomic, strong) NSString * saveType;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger scoremethod;
@property (nonatomic, strong) NSString * scorepolicy;

/**
 开始测验时间戳
 */
@property (nonatomic, strong) NSString * starttime;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, assign) BOOL surveyind;
@property (nonatomic, assign) NSInteger testCatalogId;
@property (nonatomic, strong) NSString * testCatalogIdLst;
@property (nonatomic, strong) NSString * testCatalogName;
@property (nonatomic, strong) NSArray * testCategoryList;
@property (nonatomic, strong) NSArray * testDrawRuleList;
@property (nonatomic, strong) TestTypeModel * testType;
@property (nonatomic, strong) NSString * testTypeCode;
@property (nonatomic, strong) NSString * testTypeLabel;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger toScore;
@property (nonatomic, assign) NSInteger toTime;

/**
 出卷人姓名
 */
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * visitType;

/**
 题目数量
 */
@property (nonatomic,copy) NSString *questionCount;

/**
 大题数量
 */
@property (nonatomic,copy) NSString *categoryCount;
/**
 试卷ID
 */
@property (nonatomic,copy) NSString *id;

/**
 测验模块的成绩历史ID
 */
@property (nonatomic,copy) NSString *actatthisid;

/**
 考试的监考ID
 */
@property (nonatomic,copy) NSString *monitorid;

/**
 当前回答的题目ID
 */
@property (nonatomic,copy) NSString *curAnsweredQueId;

/**
 已回答的题目ID，多个题目ID之间用~分隔
 */
@property (nonatomic,copy) NSString *answeredQuestion;

/**
 已回答的题目数量
 */
@property (nonatomic,copy) NSString *answeredQueCnt;

@end

