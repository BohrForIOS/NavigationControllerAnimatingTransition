//
//  RootViewController.m
//  NavigationViewControllerTransition
//
//  Created by 王二 on 17/2/7.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"
#import "GlobalValue.h"
#import "UIButton+inits.h"
#import "PushAnimator.h"

@interface RootViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation RootViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    self.imageView.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.imageView.hidden = YES;
}

- (void)initViews {
    
    self.imageView = [[UIImageView alloc] initWithFrame:IMAGE_FRAME_NORMAL
                                                  image:SHOW_IMAGE];
    [self.view addSubview:self.imageView];
    
    
    // 按钮
    UIButton *pushButton = [UIButton createButtonWithFrame:CGRectMake(Width - 100, Height - 40, 90, 30)
                                                buttonType:BUTTON_NORMAL
                                                     title:@"Push"
                                                       tag:0
                                                    target:self
                                                    action:@selector(buttonsEvent:)];
    [self.view addSubview:pushButton];
}

#pragma mark - 动画代理UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[SecondViewController class]]) {
        
        PushAnimator *transition = [[PushAnimator alloc] init];
        return transition;
        
    }else{
        
        return nil;
    }
}

#pragma mark - action

- (void)buttonsEvent:(UIButton *)button {
    
    [self.navigationController pushViewController:[SecondViewController new]
                                         animated:YES];
}
@end
