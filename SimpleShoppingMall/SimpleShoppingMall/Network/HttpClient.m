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
    NSURL *url;
    if ([hostKey isEqualToString:@"mall"]) {
        url = [HttpClient MallHost];
    } else {
        url = [HttpClient DoubanHost];
    }
    self.sessionManger = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    return self;
}

+ (NSURL * _Nonnull)DoubanHost {
    /*
     NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
    NSString *host = [infoDict objectForKey:@"DOUBAN_HOST"];
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://%@", host]];
     */
    return  [NSURL URLWithString:@"https://api.douban.com"];
}

+ (NSURL * _Nonnull)MallHost{
//  private letter yangyi
    return [NSURL URLWithString:@"https://example.com"];
}

- (void)getDataWithPath:(NSString * _Nonnull)path parameters:(id _Nullable)parameters success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    [self.sessionManger GET:path parameters:parameters progress:nil success:success failure:failure];
}

@end
