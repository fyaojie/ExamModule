//
//  AnswerCollectionViewCell.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "AnswerCollectionViewCell.h"
#import "ChoiceOptionListModel.h"
#import "AnswerModel.h"
#import "CategoryQuestionListModel.h"

#import "AnswerDetailedTableViewCell.h"
#import "AnswerJudgeTableViewCell.h"
#import "AnswerOptionTableViewCell.h"
#import "AnswerResultTableViewCell.h"
#import "AnswerWordProblemTableViewCell.h"
#import "AnswerCompletionResultTableViewCell.h"

#import "AnswerHeaderView.h"


#import <MJExtension/MJExtension.h>

#import "Header.h"

@interface AnswerCollectionViewCell() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) AnswerHeaderView *headerView;



@end

@implementation AnswerCollectionViewCell



- (AnswerHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[AnswerHeaderView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
//        _headerView.userInteractionEnabled = YES;
        // kvo 为per.name添加观察者
        [_headerView addObserver:self forKeyPath:@"headerHeight" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        __weak typeof(self) weakSelf = self;
        _headerView.didEndEditingBlock = ^(QuestionListModel *model) {
            if ([weakSelf updateCacheWithModel:model]) {
                NSLog(@"缓存成功");
            } else {
                NSLog(@"缓存失败");
            }
        };
    }
    return _headerView;
}

/** 添加观察者必须要实现的方法 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    /** 打印新老值 */
    // 从打印结果看 分别打印出了 name 与 height的新老值
//    NSLog(@"old : %@  new : %@",[change objectForKey:@"old"],[change objectForKey:@"new"]);
    //    NSLog(@"keypath :  %@",keyPath);
    //    NSLog(@"change : %@",change);
    [self.tableView reloadData];
}

- (void)setModel:(QuestionListModel *)model {
    _model = model;
    
    self.headerView.model = model;
    [self.tableView reloadData];
}

#pragma mark - tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  self.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"AnswerDetailedTableViewCell" bundle:nil] forCellReuseIdentifier:@"AnswerDetailedTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"AnswerJudgeTableViewCell" bundle:nil] forCellReuseIdentifier:@"AnswerJudgeTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"AnswerOptionTableViewCell" bundle:nil] forCellReuseIdentifier:@"AnswerOptionTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"AnswerResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"AnswerResultTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"AnswerWordProblemTableViewCell" bundle:nil] forCellReuseIdentifier:@"AnswerWordProblemTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"AnswerCompletionResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"AnswerCompletionResultTableViewCell"];
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *header = [[UIView alloc] init];
        header.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10);
        _tableView.tableHeaderView = header;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.contentView addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark  UITableViewDataSource - UITableViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.headerView.headerHeight;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.headerView;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (GetISAnsweKey == NO) {
        // 判断是不有详解字段
        NSInteger index = (self.model.descriptionField &&  self.model.descriptionField.length > 0) == YES ? 1 : 0;
        
        return 2 + index;
    }
    return 1;
}

/* 行数 **/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (GetISAnsweKey == YES || section == 0) {
        // 判断题
        if ([self.model.qtypecode.uppercaseString isEqualToString:@"J"]) {
            return 2;
        }
        
        // 文字题
        if ([self.model.qtypecode.uppercaseString isEqualToString:@"Q"]) {
            return 1;
        }
        return self.model.choiceOption.choiceOptionList.count;
    }
    return 1;
}

/* 选中 **/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!GetISAnsweKey) {
        return;
    }
    
    // 选择题的处理
    if ([self.model.qtypecode.uppercaseString isEqualToString:@"M"] || [self.model.qtypecode.uppercaseString isEqualToString:@"N"] || [self.model.qtypecode.uppercaseString isEqualToString:@"S"]) {
        
        [self updateCacheWithModel:[self updateCurrentDataWithIndex:indexPath.row]];
    }
    
    // 判断题的处理
    if ([self.model.qtypecode.uppercaseString isEqualToString:@"J"]) {
        QuestionListModel *QLModel = self.model;
        QLModel.answertext = indexPath.row == 0 ? @"R" : @"W";
        self.model = QLModel;
        [self updateCacheWithModel:QLModel];
    }
}

// 更新本地数据
- (QuestionListModel *)updateCurrentDataWithIndex:(NSInteger)index {
    QuestionListModel *QLModel = self.model;
    NSMutableArray *arr = [NSMutableArray array];
    
    [self.model.choiceOption.choiceOptionList enumerateObjectsUsingBlock:^(ChoiceOptionListModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == index) {
            obj.checked = !obj.checked;
        } else {
            if ([self.model.qtypecode.uppercaseString isEqualToString:@"S"]) {
                obj.checked = NO;
            }
        }
        [arr addObject:obj];
    }];
    QLModel.choiceOption.choiceOptionList = arr;
    self.model = QLModel;
    return QLModel;
}

// 更新缓存数据
- (BOOL)updateCacheWithModel:(QuestionListModel *)model {
    if (!model) {
        return NO;
    }
    NSArray *arrDocumentPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentPath=[[arrDocumentPaths objectAtIndex:0] stringByAppendingPathComponent:@"exam.plist"];
    //    NSLog(@"Documents path: %@",documentPath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:documentPath];
    
    if (!isDirExist) {
        return NO;
    }
    
    AnswerModel *answerModel = [AnswerModel mj_objectWithFile:documentPath];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [answerModel.categoryQuestionList enumerateObjectsUsingBlock:^(CategoryQuestionListModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *muarr = [NSMutableArray arrayWithArray:obj.questionList];
        [obj.questionList enumerateObjectsUsingBlock:^(QuestionListModel * obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            if ([obj1.id isEqualToString:model.id]) {
                [muarr replaceObjectAtIndex:idx1 withObject:model];
            }
        }];
        obj.questionList = muarr;
        [tempArray addObject:obj];
    }];
    answerModel.categoryQuestionList = tempArray;
   return [answerModel.mj_keyValues writeToFile:documentPath atomically:YES];
}

/* cell设置 **/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 答案
    if (indexPath.section == 1) {
        if ([self.model.qtypecode.uppercaseString isEqualToString:@"F"] || [self.model.qtypecode.uppercaseString isEqualToString:@"Q"]) {
            
            AnswerCompletionResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCompletionResultTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return cell;
        } else {
            AnswerResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerResultTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return cell;
        }
        
    }
    
    // 详解
    if (indexPath.section == 2) {
        AnswerDetailedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerDetailedTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }
    
    // 选择题
    if ([self.model.qtypecode.uppercaseString isEqualToString:@"S"] || [self.model.qtypecode.uppercaseString isEqualToString:@"M"] || [self.model.qtypecode.uppercaseString isEqualToString:@"N"]) {
        AnswerOptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerOptionTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ChoiceOptionListModel *m = self.model.choiceOption.choiceOptionList[indexPath.row];
        m.answer = self.model.answer;
        cell.model = m;
        return cell;
    }
    
    // 判断题
    if ([self.model.qtypecode.uppercaseString isEqualToString:@"J"]) {
        AnswerJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerJudgeTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.model index:indexPath.row];
        return cell;
    }
    
    // 文字题
    if ([self.model.qtypecode.uppercaseString isEqualToString:@"Q"]) {
        AnswerWordProblemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerWordProblemTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        
        __weak typeof(self) weakSelf = self;
        cell.didEndEditingBlock = ^(QuestionListModel *model) {
            if ([weakSelf updateCacheWithModel:model]) {
                NSLog(@"缓存成功");
            } else {
                NSLog(@"缓存失败");
            }
        };
        
//        [cell setModel:self.model index:indexPath.row];
        return cell;
    }
    return nil;
}

- (void)dealloc {
    [self.headerView removeObserver:self forKeyPath:@"headerHeight"];
}

@end
