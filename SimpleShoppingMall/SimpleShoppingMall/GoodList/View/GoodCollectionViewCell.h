//
//  GoodCollectionViewCell.h
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/29.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Good.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodCollectionViewCell : UICollectionViewCell

- (void) configCell:(Good *)good;

@end

NS_ASSUME_NONNULL_END
