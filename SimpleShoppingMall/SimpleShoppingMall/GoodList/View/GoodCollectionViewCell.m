//
//  GoodCollectionViewCell.m
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/29.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "GoodCollectionViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface GoodCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation GoodCollectionViewCell

-(void) configCell:(Good *)good{
    [self.brand setText:good.brand];
    [self.name setText:good.name];
    [self.price setText: [NSString stringWithFormat:@"¥%ld", (NSInteger)ceil(good.price/100)]];
    [self.cover sd_setImageWithURL:[NSURL URLWithString:good.cover_image] placeholderImage:[UIImage imageNamed:@"defaultGood.jpg"]];
}
@end
