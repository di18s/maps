//
//  TabBarControllerViewController.m
//  maps_HolmogorovDmitry_l4
//
//  Created by Дмитрий on 01/04/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "TabBarController.h"
#import "ViewController.h"
#import "News Project/NewsTitleViewController.h"
#import "Photo Project/PhotoViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.viewControllers = [self createViewControllers];
        self.tabBar.tintColor = [UIColor blackColor];
    }
    return self;
}


- (NSArray<UIViewController*> *)createViewControllers {
    NSMutableArray<UIViewController*> *controllers = [NSMutableArray new];
    
    ViewController *mapViewController = [[ViewController alloc] init];
    mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Карта" image:[UIImage imageNamed:@"map"] selectedImage:[UIImage imageNamed:@"map_selected"]];
    UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    [controllers addObject:mapNavigationController];
    
    NewsTitleViewController *newsViewController = [[NewsTitleViewController alloc] init];
    newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Новости" image:[UIImage imageNamed:@"news"] selectedImage:[UIImage imageNamed:@"news_selected"]];
    UINavigationController *newsNavigationController = [[UINavigationController alloc] initWithRootViewController:newsViewController];
    [controllers addObject:newsNavigationController];
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    PhotoViewController *photoViewController = [[PhotoViewController alloc]
                               initWithCollectionViewLayout:flowLayout];
    photoViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Фото" image:[UIImage imageNamed:@"photo"] selectedImage:[UIImage imageNamed:@"photo_selected"]];
    UINavigationController *photoNavigationController = [[UINavigationController alloc] initWithRootViewController:photoViewController];
    [controllers addObject:photoNavigationController];
    
    return controllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
