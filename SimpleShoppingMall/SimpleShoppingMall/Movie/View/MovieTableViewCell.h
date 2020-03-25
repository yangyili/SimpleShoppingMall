//
//  MovieTableViewCell.h
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTableViewCell : UITableViewCell

- (void) configWithMovie:(Movie *) movie;

@end

NS_ASSUME_NONNULL_END
