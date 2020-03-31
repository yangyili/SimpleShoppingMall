//
//  GoodViewModel.m
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/29.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "GoodViewModel.h"

@interface GoodViewModel ()

@property(nonatomic, strong) id<HttpClientProtocol> httpClient;
@property(nonatomic, weak) id<GoodListViewControllerProtocol> viewController;
@property(nonatomic, strong) GoodList *list;

@end

@implementation GoodViewModel

-(instancetype) initWithHttpClient: (id<HttpClientProtocol>) httpClient viewController:(id<GoodListViewControllerProtocol>) viewController{
    self = [super init];
    self.httpClient = httpClient;
    self.viewController = viewController;
    return self;
}

- (void) fetchGoodBy: (NSInteger)brandID{
    NSInteger defaultBrand = 15;
    NSDictionary *filterParams = @{@"filter_action": @"brand_product", @"filter_data": [NSString stringWithFormat:@"%ld", brandID ? brandID : defaultBrand]};
    [self.httpClient getDataWithPath:@"/api/v2/products.json" parameters:filterParams success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        self.list = [GoodList yy_modelWithDictionary:responseObject];
        [self.viewController reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"get product error: %@", error);
    }];
}

- (void) fetchGoodDetailBy: (NSInteger)goodId{
    [self.httpClient getDataWithPath:[NSString stringWithFormat:@"/api/v1/products/%ld.json", goodId] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        GoodDetail *good = [GoodDetail yy_modelWithDictionary:responseObject];
        [self.viewController pushDetailViewWithGoodDetail: good];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"get good detail error: %@", error);
    }];
}
- (NSInteger) goodCount{
    if (self.list && self.list.products) {
        return self.list.products.count;
    }
    return 0;
}

-(Good*) goodAtIndex:(NSInteger) index{
    if (self.list && self.list.products && self.list.products.count > index){
        return [self.list.products objectAtIndex: index];
    }
    return nil;
}
@end
