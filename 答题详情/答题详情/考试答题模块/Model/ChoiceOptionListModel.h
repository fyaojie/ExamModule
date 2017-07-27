//
//  ChoiceOptionListModel.h
//  LearnFriendEnterprise
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoiceOptionListModel : NSObject

/**
 是否选中该选项（true为选中，false为不选中）
 */
@property (nonatomic, assign) BOOL checked;

/**
 选项ID
 */
@property (nonatomic, assign) NSInteger chopId;

/**
 选项编号
 */
@property (nonatomic, strong) NSString * chopLabel;

/**
 选项的内容
 */
@property (nonatomic, strong) NSString * chopText;

/**
 正确答案
 */
@property (nonatomic, strong) NSString * answer;

@end
