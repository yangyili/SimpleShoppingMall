//
//  GoodList.m
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/29.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "GoodList.h"
#import "Good.h"

@implementation GoodList

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"products": [Good class]};
}
@end
