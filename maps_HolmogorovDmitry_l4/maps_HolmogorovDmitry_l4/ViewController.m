//
//  ViewController.m
//  maps_HolmogorovDmitry_l4
//
//  Created by Дмитрий on 26/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.orangeColor];
    [self searchBarSetup];

}

//MARK: - SearchBar
-(void)searchBarSetup{
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.barStyle = UIBarStyleDefault;
    self.navigationItem.titleView = _searchBar;
}


@end
