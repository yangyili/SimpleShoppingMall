//
//  HttpClientProtocol.h
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#ifndef HttpClientProtocol_h
#define HttpClientProtocol_h

@protocol HttpClientProtocol <NSObject>

- (NSURL *_Nonnull) host;

- (void)getDataWithPath:(NSString * _Nonnull)path parameters:(id _Nonnull)parameters success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

@end


#endif /* HttpClientProtocol_h */
