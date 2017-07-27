//
//  YJAnswerPopViewController.m
//  MYPresentation
//
//  Created by 冯垚杰 on 2017/7/3.
//  Copyright © 2017年 qc. All rights reserved.
//

#define PopMargin 15 // 边距
#define PopLineSpacing 10 // 上下间距
#define PopInteritemSpacing 20 // 左右间距
#define PopItemNumber 6 // 每一行的个数
#define TopBgViewHeight 50  // 顶部视图的高度
//#define TopBgViewTopCons 0.2  // 顶部视图的顶部间距倍数

#import "YJAnswerPopViewController.h"
#import "YJAnswerPopCollectionViewCell.h"
#import "YJAnswerPopTopView.h"

#import "CategoryQuestionListModel.h"
#import "QuestionListModel.h"

@interface YJAnswerPopViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) YJAnswerPopTopView *topView;

@property (nonatomic,strong) NSMutableArray *dataSources;

@end

@implementation YJAnswerPopViewController

- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        
        _dataSources = [NSMutableArray array];
        
        __block int i = 0;
        [self.categoryQuestionList enumerateObjectsUsingBlock:^(CategoryQuestionListModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.questionList enumerateObjectsUsingBlock:^(QuestionListModel * obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                i += 1;
                YJAnswerPopModel *model = [[YJAnswerPopModel alloc] init];
                model.number = [NSString stringWithFormat:@"%d",i];
                model.status = obj1.answerStatus;
                [_dataSources addObject:model];
            }];
        }];
        
        
    }
    return _dataSources;
}



#pragma mark - collectionView
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(PopMargin, PopMargin, 0, PopMargin);
//        layout.itemSize = CGSizeMake(100, 100);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, self.view.frame.size.height - 100 - CGRectGetHeight(self.topView.frame)) collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"YJAnswerPopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"YJAnswerPopCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark  collectionViewDataSource -  UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return PopInteritemSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return PopLineSpacing;
}

/* 个数 **/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

/* 选中 **/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __block NSIndexPath *temp = nil;
    __block int i = 0;
    [self.categoryQuestionList enumerateObjectsUsingBlock:^(CategoryQuestionListModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.questionList enumerateObjectsUsingBlock:^(QuestionListModel * obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
           
            if (indexPath.item == i) {
               temp = [NSIndexPath indexPathForRow:idx1 inSection:idx];
                *stop = YES;
                *stop1 = YES;
            }
            
            i += 1;
        }];
    }];
    
    if (temp) {
        if (self.callback) {
            self.callback(temp);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat w = (CGRectGetWidth(self.view.frame) - PopMargin * 2 - (PopItemNumber - 1) * PopInteritemSpacing)/ PopItemNumber;
    return CGSizeMake(w, w);
}

/* cell设置 **/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YJAnswerPopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YJAnswerPopCollectionViewCell" forIndexPath:indexPath];
    if (self.dataSources.count > indexPath.item) {
        cell.model = self.dataSources[indexPath.item];
    }
    
    return cell;
}


- (YJAnswerPopTopView *)topView {
    if (!_topView) {
        
        __weak typeof(self) weakSelf = self;
        _topView = [YJAnswerPopTopView viewFromXib];
        _topView.frame = CGRectMake(0, 0,  self.view.frame.size.width, TopBgViewHeight);
        _topView.clickAssignmentBlock = ^(UIButton *button) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        _topView.clickSelectedTopicBlock = ^(UIButton *button) {
           [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self collectionView];
}



@end
