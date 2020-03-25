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

@interface MovieViewController () <UITableViewDelegate, UITableViewDataSource, MovieViewControllerProtocol>

@property(nonatomic, strong) MovieViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel movieCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    Movie *movie = [self.viewModel movieAtIndex:indexPath.row];
    
    if (movie != nil) {
        cell.textLabel.text = movie.title;
    }
    
    return cell;
}

#pragma -
#pragma mark MovieViewControllerProtocol

- (void)reloadData {
    [self.tableView reloadData];
}

@end
