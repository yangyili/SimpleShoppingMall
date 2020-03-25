//
//  MovieViewModel.h
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClientProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MovieViewControllerProtocol <NSObject>

@end

@interface MovieViewModel : NSObject

- (instancetype) initWithHttpClient:(id<HttpClientProtocol> ) httpClient viewController:(id<MovieViewControllerProtocol>) viewController;

- (void)fetchTop250;

@end

NS_ASSUME_NONNULL_END
