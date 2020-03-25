//
//  MovieViewController.m
//  SimpleShoppingMall
//
//  Created by Yang Dev Luo on 2020/3/25.
//  Copyright © 2020 Thoughtworks. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieViewModel.h"
#import "HttpClient.h"

@interface MovieViewController () <MovieViewControllerProtocol>

@property(nonatomic, strong) MovieViewModel *viewModel;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HttpClient *client = [[HttpClient alloc] init];
    self.viewModel = [[MovieViewModel alloc] initWithHttpClient:client viewController:self];
    [self.viewModel fetchTop250];
}

#pragma -
#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    return cell;
}

@end
