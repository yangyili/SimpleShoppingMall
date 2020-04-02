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

- (void) fetchGoodBy: (NSInteger)brandID withPage:(NSInteger) page{
    NSInteger defaultBrand = 15;
    NSInteger defaultPage = 1;
    NSDictionary *filterParams = @{@"filter_action": @"brand_product", @"filter_data": [NSString stringWithFormat:@"%ld", brandID ? brandID : defaultBrand], @"page": [NSString stringWithFormat:@"%ld", page ? page : defaultPage]};
    [self.httpClient getDataWithPath:@"/api/v2/products.json" parameters:filterParams success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSLog(@"get products success: %ld", page);
        if (self.list && self.list.products) {
            GoodList *appendList = [GoodList yy_modelWithDictionary:responseObject];
            [self.list.products addObjectsFromArray:appendList.products];
        } else {
            self.list = [GoodList yy_modelWithDictionary:responseObject];
        }
        [self.viewController reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"get products error: %@", error);
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
