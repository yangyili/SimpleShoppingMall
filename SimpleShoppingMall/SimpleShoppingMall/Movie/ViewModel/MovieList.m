//
//  MovieList.m
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "MovieList.h"
#import "Movie.h"

@implementation MovieList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"subjects" : [Movie class]};
}

@end
