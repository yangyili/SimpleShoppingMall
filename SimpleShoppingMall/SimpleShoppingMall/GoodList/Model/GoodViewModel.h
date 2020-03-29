//
//  GoodViewModel.h
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/29.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClientProtocol.h"
#import "Good.h"
#import "GoodList.h"

NS_ASSUME_NONNULL_BEGIN
@protocol GoodListViewControllerProtocol <NSObject>

@required
- (void) reloadData;

@end

@interface GoodViewModel : NSObject
-(instancetype) initWithHttpClient: (id<HttpClientProtocol>) httpClient viewController:(id<GoodListViewControllerProtocol>) viewController;

- (void) fetchGoodByBrand: (NSInteger)brand;

- (NSInteger) goodCount;

-(Good*) goodAtIndex:(NSInteger) index;
@end

NS_ASSUME_NONNULL_END
