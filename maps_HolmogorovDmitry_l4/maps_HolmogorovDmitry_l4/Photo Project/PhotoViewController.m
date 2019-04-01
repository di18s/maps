//
//  ViewController.m
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "PhotoTitleViewController.h"
#import "NewsDescriptionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "Photo.h"

@interface PhotoTitleViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray* photoArray;
@end

@implementation PhotoTitleViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
	[self.collectionView setBackgroundColor:UIColor.whiteColor];
	self.collectionView.dataSource = self;
	self.collectionView.delegate = self;
	
	
	//[self.view addSubview:self.collectionView];
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

    PhotoCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    cell.imageNews.image = [UIImage imageNamed:@"imageNews"];
    cell.titleNews.text = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Praesent aliquam, justo convallis luctus rutrum, erat nulla fermentum diam, at nonummy quam ante ac quam.";
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}




@end
