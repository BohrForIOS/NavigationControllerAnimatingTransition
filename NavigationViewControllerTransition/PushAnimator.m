//
//  PushAnimator.m
//  ViewControllersTransition
//
//  Created by YouXianMing on 15/7/21.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "PushAnimator.h"

@implementation PushAnimator

- (void)animateTransitionEvent {
    
    UIImageView *tmpImageView  = [[UIImageView alloc] initWithFrame:IMAGE_FRAME_NORMAL
                                                              image:SHOW_IMAGE];
    [self.containerView addSubview:self.toViewController.view];
    [self.containerView addSubview:tmpImageView];
    
    self.toViewController.view.alpha   = 0.f;
    
    [UIView animateWithDuration:self.transitionDuration
                          delay:0.0f
         usingSpringWithDamping:1 initialSpringVelocity:0.f options:0 animations:^{
             
             tmpImageView.frame = IMAGE_FRAME_BIG;

             self.fromViewController.view.alpha = 0.f;
             self.toViewController.view.alpha   = 1.f;
             
         } completion:^(BOOL finished) {
             
             [tmpImageView removeFromSuperview];
             [self completeTransition];
         }];
}

@end
