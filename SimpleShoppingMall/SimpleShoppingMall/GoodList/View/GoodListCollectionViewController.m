//
//  GoodListCollectionViewController.m
//  SimpleShoppingMall
//
//  Created by yangyi Li  on 2020/3/29.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "GoodListCollectionViewController.h"
#import "GoodCollectionViewCell.h"
#import "HttpClient.h"
#import "GoodViewModel.h"
#import "GoodDetailViewController.h"

@interface GoodListCollectionViewController ()<GoodListViewControllerProtocol>

@property(nonatomic, strong) GoodViewModel *viewModel;

@end

@implementation GoodListCollectionViewController

static NSString * const reuseIdentifier = @"goodintro";

- (void)awakeFromNib {
    [super awakeFromNib];
    HttpClient *client = [[HttpClient alloc] initWithHostKey: @"mall"];
    self.viewModel = [[GoodViewModel alloc] initWithHttpClient:client viewController: self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[GoodCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    NSInteger brand = 15;
    [self.viewModel fetchGoodByBrand: brand];
}


- (void) reloadData {
    [self.collectionView reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel goodCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Good *good = [self.viewModel goodAtIndex:indexPath.item];
    [cell configCell:good];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Good *good = [self.viewModel goodAtIndex:indexPath.item];
    NSLog(@"select good: %ld", good.id);
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GoodDetailViewController *detailView = [main instantiateViewControllerWithIdentifier:@"gooddetail"];
    [self.navigationController pushViewController:detailView animated:YES];
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
