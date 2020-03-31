//
//  GoodDetailViewController.m
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/30.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "GoodDetailViewController.h"
#import <SDWebImage/SDWebImage.h>

@interface GoodDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *carouselScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *carouselPageControl;
@property (weak, nonatomic) IBOutlet UIImageView *carouselLeftImage;
@property (weak, nonatomic) IBOutlet UIImageView *carouselCenterImage;
@property (weak, nonatomic) IBOutlet UIImageView *carouselRightImage;

@property(nonatomic, assign) NSInteger leftImageIndex;
@property(nonatomic, assign) NSInteger rightImageIndex;
@property(nonatomic, assign) NSUInteger currentImageIndex;
@property(nonatomic, assign) NSInteger carouselImageCount;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, copy) NSMutableArray *carouselImages;
@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCarouselImages];
    [self startCarouselTimer];
    [self.carouselScrollView setContentOffset: CGPointMake(self.carouselScrollView.bounds.size.width, 0)
 animated:YES];
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

/*
 carousel scrollview
 */

- (void)currentImageIndexAdd {
    if (_carouselImageCount == 0 || self.currentImageIndex == _carouselImageCount - 1) {
        self.currentImageIndex = 0;
    } else {
        self.currentImageIndex = self.currentImageIndex + 1;
    }
}

- (void)currentImageIndexMinus {
    if (self.currentImageIndex == 0) {
        self.currentImageIndex = _carouselImageCount - 1;
    } else {
        self.currentImageIndex = self.currentImageIndex - 1;
    }
}

- (void)reloadImageViews {
    CGPoint scrollViewOffset = [_carouselScrollView contentOffset];
    if (scrollViewOffset.x == 2 * _carouselScrollView.bounds.size.width) {
        [self currentImageIndexAdd];
    } else if (scrollViewOffset.x == 0) {
        [self currentImageIndexMinus];
    }
    [_carouselCenterImage sd_setImageWithURL:[NSURL URLWithString:_carouselImages[_currentImageIndex]] placeholderImage:[UIImage imageNamed: @"gooddefault.png"]];
    [_carouselLeftImage sd_setImageWithURL:[NSURL URLWithString:_carouselImages[_leftImageIndex]] placeholderImage:[UIImage imageNamed: @"gooddefault.png"]];
    [_carouselRightImage sd_setImageWithURL:[NSURL URLWithString:_carouselImages[_rightImageIndex]] placeholderImage:[UIImage imageNamed: @"gooddefault.png"]];
  _carouselPageControl.currentPage = self.currentImageIndex;
}

- (void)setCarouselImages {
    _carouselImageCount = [_good.product_images count];
    _carouselImages = [NSMutableArray arrayWithCapacity:_carouselImageCount];
    for (int i=0; i<_carouselImageCount; i++) {
        [_carouselImages addObject:[_good.product_images objectAtIndex:i][@"image_url"]];
    }
    _carouselPageControl.numberOfPages = _carouselImageCount;
    [self reloadImageViews];
}

/*
  #program scrollview delegate
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {

  [self startCarouselTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

  [self endCarouselTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.x > 1.5 * _carouselScrollView.bounds.size.width) {
        _carouselPageControl.currentPage = self.rightImageIndex;
    } else if (scrollViewOffset.x < 0.5 * _carouselScrollView.bounds.size.width) {
        _carouselPageControl.currentPage = self.leftImageIndex;
    } else {
        _carouselPageControl.currentPage = self.currentImageIndex;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

  [self reloadImageViews];

  [_carouselScrollView
      setContentOffset:CGPointMake(_carouselScrollView.bounds.size.width, 0)
              animated:NO];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

  [self reloadImageViews];

  [_carouselScrollView
      setContentOffset:CGPointMake(_carouselScrollView.bounds.size.width, 0)
              animated:NO];
}
@end
