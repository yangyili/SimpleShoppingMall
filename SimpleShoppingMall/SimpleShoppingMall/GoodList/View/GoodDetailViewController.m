//
//  GoodDetailViewController.m
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/30.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "GoodDetailViewController.h"

@interface GoodDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *carouselScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *carouselPageControl;
@property (weak, nonatomic) IBOutlet UIImageView *carouselLeftImage;
@property (weak, nonatomic) IBOutlet UIImageView *carouselCenterImage;
@property (weak, nonatomic) IBOutlet UIImageView *carouselRightImage;

@property(nonatomic, assign) NSInteger leftImageIndex;
@property(nonatomic, assign) NSInteger rightImageIndex;
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startCarouselTimer];
    [self.carouselScrollView setContentOffset: CGPointMake(self.carouselScrollView.bounds.size.width, 0)
 animated:YES];
    [self.carouselPageControl setNumberOfPages:4];
}

- (void)automaticScroll {
    CGPoint currentPoint = self.carouselScrollView.contentOffset;
    if (currentPoint.x >= self.carouselScrollView.bounds.size.width) {
        currentPoint.x = -self.carouselScrollView.bounds.size.width;
        [self.carouselScrollView setContentOffset:currentPoint animated:NO];
    } else {
        currentPoint.x += self.carouselScrollView.bounds.size.width;
        [self.carouselScrollView setContentOffset:currentPoint animated:YES];
    }
}


- (void)startCarouselTimer {
    NSTimer *newTimer =
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                     selector:@selector(automaticScroll)
                                     userInfo:nil
                                      repeats:YES];

    _timer = newTimer;

    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)endCarouselTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void) viewWillDisappear:(BOOL)animated{
    [self endCarouselTimer];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
