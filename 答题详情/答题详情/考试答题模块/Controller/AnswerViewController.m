//
//  AnswerViewController.m
//  LearnFriendEnterprise
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerModel.h"
#import "CategoryQuestionListModel.h"
#import <MJExtension/MJExtension.h>
#import "AnswerCollectionViewCell.h"
#import "ScoreReportModel.h"
#import "ChoiceOptionListModel.h"

#import "YJAnswerPopTopView.h"
#import "YJAnswerPopViewController.h"

#import "Header.h"

@interface AnswerViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) AnswerModel *model;

@property (nonatomic,strong) ScoreReportModel *scoreModel;

@property (nonatomic, assign) NSInteger totalTime; // 秒数

@property (nonatomic,strong) YJAnswerPopTopView *topView;


/**
 当前位置，只能滑动至下一题时使用
 */
@property (nonatomic,strong) NSIndexPath *currentIndexPath;



@end

@implementation AnswerViewController

#pragma mark - 底部视图

- (YJAnswerPopTopView *)topView {
    if (!_topView) {
        
        __weak typeof(self) weakSelf = self;
        _topView = [YJAnswerPopTopView viewFromXib];
        _topView.frame = CGRectMake(0, self.view.frame.size.height - 40 - 64, CGRectGetWidth(self.collectionView.frame), 40);
        _topView.clickAssignmentBlock = ^(UIButton *button) {
            [weakSelf assignment];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        _topView.clickSelectedTopicBlock = ^(UIButton *button) {
            [weakSelf popView];
        };
        [self.view addSubview:_topView];
    }
    return _topView;
}

#pragma mark - YJAnswerPopViewController

- (void)popView {
    __weak typeof(self) weakSelf = self;
    YJAnswerPopViewController *popVC = [[YJAnswerPopViewController alloc] initWithShowFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100) ShowStyle:MYPresentedViewShowStyleFromBottomDropStyle callback:^(id callback) {
        NSLog(@"callback - %@",callback);
        if ([callback isKindOfClass:[NSIndexPath class]]) {
            NSIndexPath *indexPath = callback;
            
            if (GetISAnsweKey == YES && GetAnswernextque == YES) {  // 如果是考试状态bing
                if (indexPath.section < self.currentIndexPath.section) {
                    return ;
                }
                if (indexPath.section == self.currentIndexPath.section) {
                    if (indexPath.row < self.currentIndexPath.row) {
                        return;
                    }
                }
            }
            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
        }
    }];
    popVC.categoryQuestionList = self.model ? self.model.categoryQuestionList : self.scoreModel.categoryQuestionList;
    [self presentViewController:popVC animated:YES completion:nil];
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
//    [self requestData];
}


#pragma mark - collectionView
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -40 - 64) collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        
        _collectionView.scrollEnabled = !GetAnswernextque; // 如果只能滑动至下一题取消滚动效果
        [_collectionView registerClass:[AnswerCollectionViewCell class] forCellWithReuseIdentifier:@"AnswerCollectionViewCell"];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollView.contentOffset.x:%f",scrollView.contentOffset.x);
//    
//    NSLog(@"scrollViewDidScroll-visibleCells:%@",self.collectionView.visibleCells);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidEndDecelerating");
//    
//    NSLog(@"scrollViewDidEndDecelerating-visibleCells:%@",self.collectionView.visibleCells);
    
    if (self.collectionView.visibleCells.count == 1) {
        if ([self.collectionView.visibleCells.firstObject isKindOfClass:[AnswerCollectionViewCell class]]) {
           self.currentIndexPath = [self.collectionView indexPathForCell:self.collectionView.visibleCells.firstObject];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidEndScrollingAnimation");
//    
//    NSLog(@"scrollViewDidEndScrollingAnimation-visibleCells:%@",self.collectionView.visibleCells);
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    
    if ([[YJ_GCDTimerManager sharedInstance] existTimer:Answerquetime]) {
        [[YJ_GCDTimerManager sharedInstance] cancelTimerWithName:Answerquetime];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.model) {
        return self.model.categoryQuestionList.count;
    }
    
    if (self.scoreModel) {
        return self.scoreModel.categoryQuestionList.count;
    }
    return 0;
}

/* 个数 **/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CategoryQuestionListModel *CQLM = nil;
    
    if (self.model) {
        CQLM = self.model.categoryQuestionList[section];
    }
    
    if (self.scoreModel) {
        CQLM = self.scoreModel.categoryQuestionList[section];
    }
    
    if (CQLM) {
        return  CQLM.questionList.count;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

/* cell设置 **/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnswerCollectionViewCell" forIndexPath:indexPath];
    CategoryQuestionListModel *CQLM = nil;
    
    if (self.model) {
        CQLM = self.model.categoryQuestionList[indexPath.section];
    }
    
    if (self.scoreModel) {
        CQLM = self.scoreModel.categoryQuestionList[indexPath.section];
    }
    
    if (CQLM) {
        cell.model= CQLM.questionList[indexPath.row];
    }
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (void)setName:(NSString *)name {
    _name = name;
    [self requestData];
}

#pragma mark - requestData

- (void)requestData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.json",self.name ?: @"单选题"] ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.model =  [AnswerModel mj_objectWithKeyValues:dict];
    
    self.navigationItem.title = [self handleTime:self.totalTime];
    // 获得应用程序沙盒的Documents文件夹路径
    NSArray *arrDocumentPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentPath=[[arrDocumentPaths objectAtIndex:0] stringByAppendingPathComponent:@"exam.plist"];
    NSLog(@"Documents path: %@",documentPath);
    
    SetISAnsweKey(![self.name isEqualToString:@"成绩报告"])
    
    if (GetISAnsweKey == YES) {
        // 设置最大答题时间
        self.totalTime = self.model.testInfo.remainingTime > 0 ? self.model.testInfo.remainingTime : self.model.testInfo.answerTime * 60;
        [self startTimer];
    } else {
        self.title = @"成绩报告";
    }
    
    SetAnswerquetime(self.model.testInfo.answerquetime)
    SetAnswernextque(self.model.testInfo.answernextque == 1)
    SetCommitmode(self.model.testInfo.commitmode)

    
    [self.model.mj_keyValues writeToFile:documentPath atomically:YES];
    [self topView];
    
    
    if (GetAnswernextque == YES) { // 只能切换至下一题
        UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftAction:)];
        leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:leftSwipe];
    }
    
    if (self.currentIndexPath == nil) {
        self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0 ];
    }
    
    
    if (GetCommitmode == 3 && GetISAnsweKey == YES) { // 五分钟提交一次 并且是答题状态
        __weak typeof(self) weakSelf = self;
        [[YJ_GCDTimerManager sharedInstance] scheduledDispatchTimerWithName:Commitmode timeInterval:60.f * 5 queue:nil repeats:YES actionOption:(YJ_ActionOptionAbandonPrevious) action:^{
            //        NSLog(@"======%ld",weakSelf.totalTime);
            if (weakSelf.totalTime <= 0) { // 全部交卷
                
                [weakSelf endTimer];
                [[YJ_GCDTimerManager sharedInstance] cancelTimerWithName:Commitmode];
                return ;
            }
            
            NSLog(@"5分钟交卷一次");
            [self assignment];
        }];
    }
}

- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath {
    
    if (self.currentIndexPath != nil && self.currentIndexPath != currentIndexPath && GetCommitmode == 1 && GetISAnsweKey == YES) {
        NSLog(@"逐题提交");
        [self assignment];
    }
    
    if (self.currentIndexPath != nil && self.currentIndexPath.section != currentIndexPath.section && GetCommitmode == 2 && GetISAnsweKey == YES) {
        NSLog(@"逐大题提交");
        [self assignment];
    }
    
    _currentIndexPath = currentIndexPath;
    
    if (GetAnswerquetime > 0) {
        
        __weak typeof(self) weakSelf = self;
        [[YJ_GCDTimerManager sharedInstance] scheduledDispatchTimerWithName:Answerquetime timeInterval:GetAnswerquetime queue:nil repeats:YES actionOption:(YJ_ActionOptionAbandonPrevious) action:^{
            NSLog(@"======%ld",weakSelf.totalTime);
            
            [[YJ_GCDTimerManager sharedInstance] cancelTimerWithName:Answerquetime];
            
            [weakSelf nextQuestion];
        }];
    }
}

- (void)leftAction:(UISwipeGestureRecognizer *)sender {
    [self nextQuestion];
}

// 下一题
- (void)nextQuestion {
    
    if (self.currentIndexPath == nil) {
        self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0 ];
    }
    
    if (self.currentIndexPath.item + 1 >= [self.collectionView numberOfItemsInSection:self.currentIndexPath.section]) { // 某组的最后一个
        
        if (self.model.categoryQuestionList.count - 1 > self.currentIndexPath.section) { // 判断是不是最后一组
            self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:self.currentIndexPath.section + 1];
        } else {
            // 在这里要交卷
            NSLog(@"最后一题答题时间到了，交卷");
            [self endTimer];
            return;
        }
    } else {
        self.currentIndexPath = [NSIndexPath indexPathForItem:self.currentIndexPath.row + 1 inSection:self.currentIndexPath.section];
    }
    
    [self.collectionView scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

#pragma mark - 定时器

- (void)setTotalTime:(NSInteger)totalTime {
    _totalTime = totalTime;
    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        self.navigationItem.title = [self handleTime:totalTime];
    });
    
}

- (NSString *)handleTime:(NSInteger)time {
    if (time <= 0) {
        return @"00:00";
    }
//    NSLog(@"%@",[NSString stringWithFormat:@"%02ld:%02ld",time/60,time%60]);
    return [NSString stringWithFormat:@"倒计时%02ld分%02ld秒",time/60,time%60];
}

//- (void)requestData {
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"成绩报告.json" ofType:nil];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    self.scoreModel =  [ScoreReportModel mj_objectWithKeyValues:dict];
//    SetISAnsweKey(NO)
//    
//    [self.collectionView reloadData];
//}

- (void)startTimer {
    __weak typeof(self) weakSelf = self;
    [[YJ_GCDTimerManager sharedInstance] scheduledDispatchTimerWithName:NSStringFromClass([AnswerViewController class]) timeInterval:1.f queue:nil repeats:YES actionOption:(YJ_ActionOptionAbandonPrevious) action:^{
//        NSLog(@"======%ld",weakSelf.totalTime);
        weakSelf.totalTime -= 1;
        if (weakSelf.totalTime <= 0) {
            [weakSelf endTimer];
        }
    }];
}


- (void)endTimer {
    
    NSLog(@"到时间了交卷");
    [self assignment];
    
    [[YJ_GCDTimerManager sharedInstance] cancelTimerWithName:NSStringFromClass([AnswerViewController class])];
}


/**
 交卷
 */
- (void)assignment {
    if (GetISAnsweKey == NO) {
        NSLog(@"成绩报告不需要交卷");
        return;
    }
    NSLog(@"交卷");
    
    // 获得应用程序沙盒的Documents文件夹路径
    NSArray *arrDocumentPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentPath=[[arrDocumentPaths objectAtIndex:0] stringByAppendingPathComponent:@"exam.plist"];
    
   AnswerModel *model = [AnswerModel mj_objectWithFile:documentPath];
    
    if (model.categoryQuestionList.count <= 0) {
        NSLog(@"没有题目不需要交卷");
        return;
    }
    
    NSMutableDictionary *mudict = [NSMutableDictionary dictionary];

    // ========================= 第一步添加大题的参数================================================
//    针对每个大题构建一个参数，通过对categoryQuestionList进行循环构建每个大题的题目ID列表参数，当questionTypeCode＝S时参数名为singleSelectInput；当questionTypeCode＝M时参数名为multiSelectInput；当questionTypeCode＝N时参数名为unmuSelectInput，当questionTypeCode＝F时参数名为fillBlankInput；当questionTypeCode＝J时参数名为jurgeInput，当questionTypeCode＝Q时参数名为wordInput，值为该大题下的题目ID列表，通过对questionInputList进行循环，多个ID之间用~分隔，填空题时需两次循环，先对题目循环，再对选项进行循环，例如填空题构建的参数值为42_1~43_2~43_3，非填空题构建的参数值为9~10~11~12~13

    NSDictionary *keys = @{@"S":@"singleSelectInput",
                           @"M":@"multiSelectInput",
                           @"N":@"unmuSelectInput",
                           @"F":@"fillBlankInput",
                           @"J":@"jurgeInput",
                           @"Q":@"wordInput"};
    
    [model.categoryQuestionList enumerateObjectsUsingBlock:^(CategoryQuestionListModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 当questionTypeCode＝S时参数名为singleSelectInput 单选题  值为该大题下的题目ID列表
        NSString *value = [self handleBigQuestionDataWithArray:obj.questionInputList];
        NSString *key = [keys objectForKey:obj.questionTypeCode.uppercaseString];

        if (key && value) {
            [mudict setObject:value forKey:key];
        }
    }];
    
    // ========================= 第二步添加小题的参数================================================
    
    //    针对每个题目构建一个参数，当questionTypeCode＝S时参数名为sin_que_{queid}，值为用户选择的选项ID；当questionTypeCode＝M时参数名为multi_que_{queid}，值为用户选择的选项ID列表，多个ID之间用~分隔；当questionTypeCode＝N时参数名为unmu_que_{queid}，值为用户选择的选项ID列表，多个ID之间用~分隔； 当questionTypeCode＝J时参数名为jurge_que_{queid}，值为R或W，R代表用户选择对，W代表用户选择错；当questionTypeCode＝F时参数名为fill_que_{queid}_{optionid}，值为用户输入的内容；当questionTypeCode＝Q时参数名为word_que_{queid}，值为用户输入的内容。

    NSDictionary *resourceParams = @{@"S":@"sin_que_",
                           @"M":@"multi_que_",
                           @"N":@"unmu_que_",
                           @"F":@"fillBlankInput",
                           @"J":@"fill_que_",
                           @"Q":@"word_que_"};
    
    [model.categoryQuestionList enumerateObjectsUsingBlock:^(CategoryQuestionListModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {

        [obj.questionList enumerateObjectsUsingBlock:^(QuestionListModel  * obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            if (obj1.answerStatus > 0) { // 如果是已答题
               __block NSString *value = nil;
                NSString *key = [NSString stringWithFormat:@"%@%@",[resourceParams objectForKey:obj.questionTypeCode.uppercaseString],obj1.id];
                
                // 单选题
                if ([obj.questionTypeCode.uppercaseString isEqualToString:@"S"]) {
                    [obj1.choiceOption.choiceOptionList enumerateObjectsUsingBlock:^(ChoiceOptionListModel  * obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                        if (obj2.checked == YES) {
                            value = [NSString stringWithFormat:@"%ld",obj2.chopId];
                            *stop2 = YES;
                        }
                    }];
                }
                
                // 多选题
                if ([obj.questionTypeCode.uppercaseString isEqualToString:@"M"] || [obj.questionTypeCode.uppercaseString isEqualToString:@"N"]) {
                    NSMutableString *mustr = [NSMutableString string];
                    [obj1.choiceOption.choiceOptionList enumerateObjectsUsingBlock:^(ChoiceOptionListModel  * obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                        if (obj2.checked == YES) {
                            if (mustr.length > 0) {
                                [mustr appendString:@"~"];
                            }
                            [mustr appendFormat:@"%ld",obj2.chopId];
                        }
                    }];
                    value = mustr;
                }
                
                // 判断题
                if ([obj.questionTypeCode.uppercaseString isEqualToString:@"J"]) {
                    value = obj1.answertext;
                }
                
                // 文字题
                if ([obj.questionTypeCode.uppercaseString isEqualToString:@"Q"]) {
                    value = obj1.answertext;
                }
                
                // 填空题
                if ([obj.questionTypeCode.uppercaseString isEqualToString:@"F"]) {
//                    value = obj1.answertext;
                    
                    NSLog(@"获取填空题的答案");
                }
                
                
                if (key && value) {
                    [mudict setObject:value forKey:key];
                }
            }
        }];
    }];
    
    NSLog(@"%@",mudict);
}

// 递归的方式获取所有大题参数值
- (NSString *)handleBigQuestionDataWithArray:(NSArray *)array {
    if (array.count <= 0) {
        return nil;
    }
    
    NSMutableArray *muarr = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [muarr addObject:obj];
        }
        
        if ([obj isKindOfClass:[NSArray class]]) {
            [muarr addObject:[self handleBigQuestionDataWithArray:obj]];
        }
    }];
    if (muarr.count <= 0) {
        return nil;
    }
    return [muarr componentsJoinedByString:@"~"];
}

#pragma mark - dealloc

- (void)dealloc {
    
    if ([[YJ_GCDTimerManager sharedInstance] existTimer:NSStringFromClass([AnswerViewController class])]) {
        [[YJ_GCDTimerManager sharedInstance] cancelTimerWithName:NSStringFromClass([AnswerViewController class])];
    }
    
    if ([[YJ_GCDTimerManager sharedInstance] existTimer:Answerquetime]) {
        [[YJ_GCDTimerManager sharedInstance] cancelTimerWithName:Answerquetime];
    }
    
    if ([[YJ_GCDTimerManager sharedInstance] existTimer:Commitmode]) {
        [[YJ_GCDTimerManager sharedInstance] cancelTimerWithName:Commitmode];
    }
}

@end
