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
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIButton *selectGoodButton;
@property (weak, nonatomic) IBOutlet UILabel *baseNotice1;
@property (weak, nonatomic) IBOutlet UILabel *baseNotice2;

@property (weak, nonatomic) IBOutlet UILabel *sizeNotice1;
@property (weak, nonatomic) IBOutlet UILabel *sizeNotice2;
@property (weak, nonatomic) IBOutlet UILabel *logisticsService;
@property(nonatomic, assign) NSInteger leftImageIndex;
@property(nonatomic, assign) NSInteger rightImageIndex;
@property(nonatomic, assign) NSUInteger currentImageIndex;
@property(nonatomic, assign) NSInteger carouselImageCount;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, copy) NSMutableArray *carouselImages;
@property(nonatomic, assign) NSInteger carouselImageLeadingSpaceCarouselScrollView;
@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGoodDetail];
    [self initIBoutletStyle];
    [_carouselScrollView setContentOffset:CGPointMake(_carouselScrollView.bounds.size.width, 0)
    animated:NO];
    [self setCarouselImages];
    [self startCarouselTimer];
}

- (void) initIBoutletStyle{
    self.selectGoodButton.layer.cornerRadius = 10;
    self.selectGoodButton.layer.borderWidth = 1;
    self.selectGoodButton.layer.borderColor = UIColor.grayColor.CGColor;
}
- (void) setGoodDetail{
    [self.brand setText:_good.brand];
    [self.name setText:_good.name];
    [self.price setText:[NSString stringWithFormat:@"¥%ld" , (NSInteger)ceil(_good.price/100)]];
    NSInteger detailNoticeCount = 3;
    for (int i=0; i<detailNoticeCount; i++) {
        NSDictionary *notice = [_good.detail_notice objectAtIndex:i];
        NSString *title = notice[@"title"];
        NSArray *notices = notice[@"notice"];
        NSError *error = nil;
        NSRegularExpression *regexhtmla = [NSRegularExpression regularExpressionWithPattern:@"(<a.*?>|</a>)" options:NSRegularExpressionCaseInsensitive error:&error];
        NSRegularExpression *regexhtmlcopy = [NSRegularExpression regularExpressionWithPattern:@"(<copy.*?>|</copy>)" options:NSRegularExpressionCaseInsensitive error:&error];
        if ([title isEqual:@"基本信息"]  ) {
            NSString *notice0 = [notices objectAtIndex:0];
            NSString *notice1 = [notices objectAtIndex:1];
            [self.baseNotice1 setText:[regexhtmlcopy stringByReplacingMatchesInString:notice0 options:0 range:NSMakeRange(0, [notice0 length]) withTemplate:@""]];
            [self.baseNotice2 setText:[regexhtmlcopy stringByReplacingMatchesInString:notice1 options:0 range:NSMakeRange(0, [notice1 length]) withTemplate:@""]];
        }
        if ([title isEqual:@"尺码参考"]  ) {
            NSString *notice0 = [notices objectAtIndex:0];
            NSString *notice1 = [notices objectAtIndex:1];
            [self.sizeNotice1 setText:[regexhtmla stringByReplacingMatchesInString:notice0 options:0 range:NSMakeRange(0, [notice0 length]) withTemplate:@""]];
            [self.sizeNotice2 setText:[regexhtmla stringByReplacingMatchesInString:notice1 options:0 range:NSMakeRange(0, [notice1 length]) withTemplate:@""]];
        }
        if ([title isEqual:@"物流售后"]  ) {
            [self.logisticsService setText:[regexhtmla stringByReplacingMatchesInString:[notices objectAtIndex:0] options:0 range:NSMakeRange(0, [[notices objectAtIndex:0] length]) withTemplate:@""]];
        }
    }
}

- (void)automaticScroll {
    CGPoint currentPoint = self.carouselScrollView.contentOffset;
    currentPoint.x += self.carouselScrollView.bounds.size.width;
    [self.carouselScrollView setContentOffset:currentPoint animated:YES];
}


- (void)startCarouselTimer {
    NSTimer *newTimer =
    [NSTimer scheduledTimerWithTimeInterval:5.0
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
- (NSInteger)leftImageIndex {
    if (_currentImageIndex == 0) {
        _leftImageIndex = _carouselImageCount - 1;
    } else {
        _leftImageIndex = _currentImageIndex - 1;
    }
    return _leftImageIndex;
}

- (NSInteger)rightImageIndex {
    if (_currentImageIndex == _carouselImageCount - 1) {
        _rightImageIndex = 0;
    } else {
        _rightImageIndex = _currentImageIndex + 1;
    }
    return _rightImageIndex;
}

- (NSUInteger)currentImageIndex {
    if (!_currentImageIndex) {
        _currentImageIndex = 0;
    }
    return _currentImageIndex;
}

- (void)currentImageIndexAdd {
    if (_currentImageIndex == _carouselImageCount - 1) {
        _currentImageIndex = 0;
    } else {
        _currentImageIndex +=  1;
    }
}

- (void)currentImageIndexMinus {
    if (_currentImageIndex == 0) {
        _currentImageIndex = _carouselImageCount - 1;
    } else {
        _currentImageIndex -= 1;
    }
}

- (void)reloadImageViews {
    CGPoint scrollViewOffset = [_carouselScrollView contentOffset];
    if (scrollViewOffset.x == 2 * _carouselScrollView.bounds.size.width) {
        [self currentImageIndexAdd];
    } else if (scrollViewOffset.x == 0) {
        [self currentImageIndexMinus];
    }
    _carouselPageControl.currentPage = _currentImageIndex;
    [_carouselCenterImage sd_setImageWithURL:[NSURL URLWithString:_carouselImages[_currentImageIndex]] placeholderImage:[UIImage imageNamed: @"gooddefault.png"]];
    [_carouselLeftImage sd_setImageWithURL:[NSURL URLWithString:_carouselImages[_leftImageIndex]] placeholderImage:[UIImage imageNamed: @"gooddefault.png"]];
    [_carouselRightImage sd_setImageWithURL:[NSURL URLWithString:_carouselImages[_rightImageIndex]] placeholderImage:[UIImage imageNamed: @"gooddefault.png"]];
}

- (void)setCarouselImages {
    _carouselImageCount = [_good.product_images count];
    _carouselImages = [NSMutableArray arrayWithCapacity:_carouselImageCount];
    for (int i=0; i<_carouselImageCount; i++) {
        [_carouselImages addObject:[_good.product_images objectAtIndex:i][@"image_url"]];
    }
    _carouselPageControl.numberOfPages = _carouselImageCount;
    _currentImageIndex = 0;
    [self reloadImageViews];
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

  [_carouselScrollView setContentOffset:CGPointMake(_carouselScrollView.bounds.size.width, 0)
              animated:NO];
}
@end
