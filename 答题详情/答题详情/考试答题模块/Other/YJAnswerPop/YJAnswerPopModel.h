//
//  YJAnswerPopModel.h
//  MYPresentation
//
//  Created by 冯垚杰 on 2017/7/3.
//  Copyright © 2017年 qc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    YJAnswerPopStatusNoAnswer, // 未答
    YJAnswerPopStatusAnswering, // 正在答题
    YJAnswerPopStatusAnswered  // 已答
} YJAnswerPopStatus;

@interface YJAnswerPopModel : NSObject

// 第几题
@property (nonatomic,copy) NSString *number;


@property (nonatomic, assign) YJAnswerPopStatus status;


@end
