//
//  Movie.h
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *original_title;
@property (nonatomic, copy) NSURL *alt;
@end

NS_ASSUME_NONNULL_END
