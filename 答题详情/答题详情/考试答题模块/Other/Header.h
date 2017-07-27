//
//  Header.h
//  答题详情
//
//  Created by 冯垚杰 on 2017/7/4.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// ============================ yes 代表答题  no 代表成绩报告 =======================
#define ISAnsweKey @"ISAnsweKey"
#define GetISAnsweKey [[[NSUserDefaults standardUserDefaults] objectForKey:ISAnsweKey] boolValue]
#define SetISAnsweKey(bool) [[NSUserDefaults standardUserDefaults] setObject:@(bool) forKey:ISAnsweKey];

// ============================ 每道题最多答题时间 0代表不限制 =======================
#define Answerquetime @"answerquetime"
#define GetAnswerquetime [[[NSUserDefaults standardUserDefaults] objectForKey:Answerquetime] integerValue]
#define SetAnswerquetime(int) [[NSUserDefaults standardUserDefaults] setObject:@(int) forKey:Answerquetime];

// ============================ 答题时是否只能切换到下一题（1代表是，0代表否）=======================
#define Answernextque @"answernextque"
#define GetAnswernextque [[[NSUserDefaults standardUserDefaults] objectForKey:Answernextque] boolValue]
#define SetAnswernextque(int) [[NSUserDefaults standardUserDefaults] setObject:@(int) forKey:Answernextque];

// ============================ 试卷提交模式 =======================
#define Commitmode  @"commitmode" // 试卷提交模式（0=整卷提交　1=逐题提交 2=逐大题提交  3=每隔5分钟自动提交）
#define GetCommitmode [[[NSUserDefaults standardUserDefaults] objectForKey:Commitmode] integerValue]
#define SetCommitmode(int) [[NSUserDefaults standardUserDefaults] setObject:@(int) forKey:Commitmode];

#import "NSString+StringSize.h"
#import <YYKit/YYKit.h>
#import "YJ_GCDTimerManager.h"

#endif /* Header_h */
