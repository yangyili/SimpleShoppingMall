//
//  MovieViewModel.m
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "MovieViewModel.h"

@interface MovieViewModel ()

@property(nonatomic, strong) id<HttpClientProtocol> httpClient;
@property(nonatomic, weak) id<MovieViewControllerProtocol> viewController;
@property(nonatomic, strong) MovieList *list;

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
        self.list = [MovieList yy_modelWithDictionary:responseObject];
        [self.viewController reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"get movies error:%@", error);
    }];
    
}

- (NSInteger) movieCount {
    if (self.list != nil) {
        return self.list.count;
    }
    return 0;
}

- (Movie*) movieAtIndex:(NSInteger) index {
    if (self.list !=nil && self.list.subjects != nil && self.list.subjects.count > index) {
        return [self.list.subjects objectAtIndex:index];
    }
    return nil;
}

@end
