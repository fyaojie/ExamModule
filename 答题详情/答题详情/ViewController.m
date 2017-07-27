//
//  ViewController.m
//  答题详情
//
//  Created by 冯垚杰 on 2017/6/28.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "ViewController.h"
#import "AnswerViewController.h"

#import <YYKit/YYKit.h>

@interface ViewController () <YYTextViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    

    
    

}
- (IBAction)duoxuanti:(id)sender {
    AnswerViewController *VC = [[AnswerViewController alloc] init];
    VC.name = @"不定项选择题";
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)tiankongti:(id)sender {
    AnswerViewController *VC = [[AnswerViewController alloc] init];
    VC.name = @"填空题";
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)wenziti:(id)sender {
    AnswerViewController *VC = [[AnswerViewController alloc] init];
    VC.name = @"文字题";
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)danxuanti:(id)sender {
    AnswerViewController *VC = [[AnswerViewController alloc] init];
    VC.name = @"单选题";
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)leixingqiquan:(id)sender {
    AnswerViewController *VC = [[AnswerViewController alloc] init];
    VC.name = @"类型齐全";
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)chengjibaogao:(id)sender {
    AnswerViewController *VC = [[AnswerViewController alloc] init];
    VC.name = @"成绩报告";
    [self.navigationController pushViewController:VC animated:YES];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


@end
