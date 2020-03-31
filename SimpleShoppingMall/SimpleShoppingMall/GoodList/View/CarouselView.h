//
//  CarouselView.h
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/30.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
  CarouselViewStyleNone,
  CarouselViewStyleTitle,
  CarouselViewStylePageControl,
  CarouselViewStyleBoth
} CarouselViewStyle;

@protocol CarouselViewDelegate <NSObject>

@optional

- (void)whenCycleClick:(NSInteger)index;

@end

@interface CarouselView : UIView

{
  float _automaticScrollDelay;
  CarouselViewStyle _carouselViewStyle;
}
@property(nonatomic, strong) NSArray *picDataArray;
@property(nonatomic, strong) NSArray *titleDataArray;
@property(nonatomic, assign) NSUInteger currentImageIndex;
@property(nonatomic, weak) UIFont *titleLabelTextFont;
@property(nonatomic, weak) UIColor *titleLabelTextColor;
@property(nonatomic, weak) UIColor *pageControlTintColor;
@property(nonatomic, weak) UIColor *pageControlCurrentColor;

@property(nonatomic, assign) BOOL isAutomaticScroll;
@property(nonatomic, copy) NSString *currentImageName;
@property(nonatomic, assign) float automaticScrollDelay;
@property(nonatomic, assign) CarouselViewStyle carouselViewStyle;

@property(nonatomic, weak) id<CarouselViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
