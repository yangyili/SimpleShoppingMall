//
//  HttpClient.m
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "HttpClient.h"
#import <AFNetworking/AFNetworking.h>

@interface HttpClient ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManger;
@end

@implementation HttpClient

-(instancetype)init{
    self = [super init];
    self.sessionManger = [[AFHTTPSessionManager alloc] initWithBaseURL:[HttpClient host]];
    return self;
}

+ (NSURL * _Nonnull)host {
    return [NSURL URLWithString:@"https://douban.uieee.com/"];
}

- (void)getDataWithPath:(NSString * _Nonnull)path parameters:(id _Nullable)parameters success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    [self.sessionManger GET:path parameters:parameters progress:nil success:success failure:failure];
}

@end
