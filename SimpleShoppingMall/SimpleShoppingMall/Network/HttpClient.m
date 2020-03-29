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

-(instancetype)initWithHostKey: (NSString *)hostKey{
    self = [super init];
    NSURL *url = [HttpClient DoubanHost];
    if ([hostKey isEqualToString:@"mall"]) {
        url = [HttpClient MallHost];
    }
    self.sessionManger = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    return self;
}

+ (NSURL * _Nonnull)DoubanHost {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
    NSString *host = [infoDict objectForKey:@"DOUBAN_HOST"];
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://%@", host]];
}

+ (NSURL * _Nonnull)MallHost{
    return [NSURL URLWithString:@"https://api.2ccm.net"];
}

- (void)getDataWithPath:(NSString * _Nonnull)path parameters:(id _Nullable)parameters success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    [self.sessionManger GET:path parameters:parameters progress:nil success:success failure:failure];
}

@end
