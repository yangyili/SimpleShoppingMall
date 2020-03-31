//
//  GoodDetail.h
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/31.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodDetail : NSObject
@property NSString *name;
@property NSString *brand;
@property NSInteger price;
@property NSString *cover_image;
@property NSArray *product_images;
@end

NS_ASSUME_NONNULL_END
