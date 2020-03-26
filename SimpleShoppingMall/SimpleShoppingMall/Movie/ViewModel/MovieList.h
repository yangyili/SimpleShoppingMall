//
//  MovieList.h
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieList : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, copy) NSArray *subjects;
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
