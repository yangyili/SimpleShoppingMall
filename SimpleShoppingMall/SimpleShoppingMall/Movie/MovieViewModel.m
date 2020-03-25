//
//  MovieViewModel.m
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "MovieViewModel.h"
#import "HttpClientProtocol.h"

@interface MovieViewModel ()

@property(nonatomic, strong) id<HttpClientProtocol> httpClient;
@property(nonatomic, weak) id<MovieViewControllerProtocol> viewController;

@end

@implementation MovieViewModel

- (instancetype) initWithHttpClient:(id<HttpClientProtocol> ) httpClient viewController:(id<MovieViewControllerProtocol>) viewController{
    self = [super init];
    self.httpClient = httpClient;
    self.viewController = viewController;
    return self;
}

- (void)fetchTop250 {
    [self.httpClient getDataWithPath:@"/v2/movie/top250" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
