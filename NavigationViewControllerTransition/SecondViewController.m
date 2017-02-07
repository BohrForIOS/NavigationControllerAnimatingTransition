//
//  SecondViewController.m
//  NavigationViewControllerTransition
//
//  Created by 王二 on 17/2/7.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import "SecondViewController.h"
#import "GlobalValue.h"
#import "UIButton+inits.h"
#import "RootViewController.h"
#import "PopAnimator.h"

@interface SecondViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SecondViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.imageView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.imageView.hidden = NO;
    
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.imageView.hidden = YES;
}

#pragma mark

- (void)setup {
    self.view.backgroundColor = [UIColor blackColor];
}


- (void)initViews {
    
    self.imageView = [[UIImageView alloc] initWithFrame:IMAGE_FRAME_BIG
                                                  image:SHOW_IMAGE];
    self.imageView.hidden = YES;
    [self.view addSubview:self.imageView];
    
    // 按钮
    UIButton *pushButton = [UIButton createButtonWithFrame:CGRectMake(Width - 100, Height - 40, 90, 30)
                                                buttonType:BUTTON_RED
                                                     title:@"Pop"
                                                       tag:0
                                                    target:self
                                                    action:@selector(buttonsEvent:)];
    [self.view addSubview:pushButton];
}

- (void)buttonsEvent:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 动画代理 (导航栏控制器动画代理)
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    
    if ([toVC isKindOfClass:[RootViewController class]]) {
        
        PopAnimator *transition = [[PopAnimator alloc] init];
        return transition;
        
    }else{
        
        return nil;
    }
}

@end
