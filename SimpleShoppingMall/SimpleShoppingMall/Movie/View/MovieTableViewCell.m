//
//  MovieTableViewCell.m
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "MovieTableViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface MovieTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIImageView *cover;

@end

@implementation MovieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configWithMovie:(Movie *) movie {
    [self.mainTitle setText:movie.title];
    [self.subTitle setText:movie.original_title];
    [self.cover sd_setImageWithURL:[NSURL URLWithString:movie.images[@"small"]]  placeholderImage:[UIImage imageNamed: @"defaultMovie.png"]];
}

@end
