//
//  HttpClient.h
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "HttpClientProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HttpClient : NSObject <HttpClientProtocol>
- (instancetype) initWithHostKey: (NSString *)hostKey;


@end

NS_ASSUME_NONNULL_END
