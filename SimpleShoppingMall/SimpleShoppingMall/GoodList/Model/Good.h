//
//  Good.h
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/29.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Good : NSObject
@property NSString *name;
@property NSString *brand;
@property NSInteger price;
@property NSString *cover_image;

@end

NS_ASSUME_NONNULL_END
