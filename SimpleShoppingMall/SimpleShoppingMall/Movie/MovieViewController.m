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
#import "MovieTableViewCell.h"

@interface MovieViewController () <UITableViewDelegate, UITableViewDataSource, MovieViewControllerProtocol>

@property(nonatomic, strong) MovieViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MovieViewController

- (void) awakeFromNib {
    [super awakeFromNib];
    HttpClient *client = [[HttpClient alloc] init];
    self.viewModel = [[MovieViewModel alloc] initWithHttpClient:client viewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];
    
    [self.viewModel fetchTop250];
}

#pragma -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel movieCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MovieTableViewCell"];
    Movie *movie = [self.viewModel movieAtIndex:indexPath.row];
    
    if (movie != nil) {
        [cell configWithMovie:movie];
    }
    
    return cell;
}

#pragma -
#pragma mark - MovieViewControllerProtocol

- (void)reloadData {
    [self.tableView reloadData];
}

@end
