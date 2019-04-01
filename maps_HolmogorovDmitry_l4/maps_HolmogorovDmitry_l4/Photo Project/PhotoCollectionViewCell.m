//
//  NewsCollectionViewCell.m
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "PhotoViewController.h"

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self){
		_imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
		_imagePhoto.layer.cornerRadius = 10;
        self.imagePhoto.clipsToBounds = YES;
		[self.contentView addSubview:_imagePhoto];
		
		_titlePhoto = [[UILabel alloc] initWithFrame:CGRectMake(0, 81, 100, 19)];
        [self.titlePhoto setTextAlignment:NSTextAlignmentCenter];
		[self.contentView addSubview:_titlePhoto];
	}
	return self;
}


@end
