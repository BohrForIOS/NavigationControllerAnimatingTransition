# NavigationControllerAnimatingTransition
这篇文章与我前面写的一篇文章"[普通控制器的自定义转场动画的实现步骤-iOS](http://www.jianshu.com/p/d88030216001)"都是关于控制器的自定义转场动画的，前面一篇介绍了普通控制器的自定义转场动画的实现，这一篇则介绍导航控制器的自定义转场动画的实现。

在Object-C中，控制器的转场有两类，一类是导航控制器的push和pop，一类是普通控制器的present和dismiss，这里只讲导航控制器的转场动画，普通控制器的转场动画前面已经讲过。

当我们调用`[self.navigationController pushViewController:vc animated:YES]`或者`[self.navigationController popViewControllerAnimated:YES]`时，即可实现系统自带的导航控制器的push和pop转场动画，但是有时候你可能想要别的效果，这个时候就需要我们自定义控制器的转场动画了

当你了解后，你会发现，导航控制器的自定义转场动画，实现起来其实也很简单。以下的gif图里就是我实现的导航控制器的自定义转场动画，这也是调用`[self.navigationController pushViewController:vc animated:YES]`或者`[self.navigationController popViewControllerAnimated:YES]`实现的效果哦，跟系统的push，pop的效果明显不一样吧

![image](https://github.com/BohrForIOS/NavigationControllerAnimatingTransition/blob/master/NavigationViewControllerTransition/NavigationControllerAnimatingTransition.gif )

实现步骤如下：

1.push前的控制器遵守导航控制器协议UINavigationControllerDelegate


2..push前的控制器成为导航控制器的代理`self.navigationController.delegate = self`


3.push前的控制器实现代理方法`- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC`




需要注意的是，代理方法返回的是一个遵守UIViewControllerAnimatedTransitioning协议的对象，这个对象负责转场的动画控制，而这个协议里面又有两个方法需要实现

1.动画的时间：`- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext` 
2.动画的具体实现：`- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext`

不同的动画实现即控制着不同的效果，我这里push动画是透明度和视图的transform变化

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


这样，导航控制器的push动画即实现完成。当push前的控制器调用`[self.navigationController pushViewController:vc animated:YES]`时，就会有push动画。当然现在还没有实现pop动画，pop动画是在push后的控制器里实现，实现步骤和push动画类似，也是上面几个步骤，具体可看代码。

聪明的你，了解实现步骤后是不是也很容易就可以做自己定制的push和pop动画了呢？
