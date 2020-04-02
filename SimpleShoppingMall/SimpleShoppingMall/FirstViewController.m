//
//  FirstViewController.m
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "FirstViewController.h"
#import <SDWebImage/SDWebImage.h>
#import "GoodListCollectionViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *guccui;
@property (weak, nonatomic) IBOutlet UIImageView *burberry;
@property (weak, nonatomic) IBOutlet UIImageView *bag;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_guccui sd_setImageWithURL:[NSURL URLWithString:@"https://api-2ccm-main.oss-cn-beijing.aliyuncs.com/public/mall_blocks/original/000/000/006/3GUCCI.png?1582280623"]];
    [_burberry sd_setImageWithURL:[NSURL URLWithString:@"https://api-2ccm-main.oss-cn-beijing.aliyuncs.com/public/mall_blocks/original/000/000/010/6BURBERRY.png?1582280624"]];
    [_bag sd_setImageWithURL:[NSURL URLWithString:@"https://api-2ccm-main.oss-cn-beijing.aliyuncs.com/public/mall_blocks/original/000/000/009/7%E5%8C%85%E8%A2%8B.png?1582280625"]];
}
- (IBAction)gotoSpecifyBrandProducts:(id)sender {
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GoodListCollectionViewController *vc = [board instantiateViewControllerWithIdentifier:@"goodlist"];
    NSInteger brandID = 0;
    NSString *btnText= [[sender titleLabel] text];
    if ([btnText isEqual:@"GUCCUI"]) {
        brandID = 15;
    } else if ([btnText isEqual:@"BURBBERY"]) {
        brandID = 122;
    } else if([btnText isEqual: @"包袋"]) {
        brandID = 4;
    }
    if (brandID > 0) {
        vc.currentBrand = brandID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
