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
		_imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, self.contentView.bounds.size.width - 1, self.contentView.bounds.size.height - 20)];
		_imagePhoto.layer.cornerRadius = 10;
        self.imagePhoto.clipsToBounds = YES;
        self.imagePhoto.contentMode = UIViewContentModeScaleAspectFill;
		[self.contentView addSubview:_imagePhoto];
		
		_titlePhoto = [[UILabel alloc] initWithFrame:CGRectMake(1, self.contentView.bounds.size.height - 20, self.contentView.bounds.size.width - 1, self.contentView.bounds.size.height - (self.contentView.bounds.size.height - 20))];
        [self.titlePhoto setTextAlignment:NSTextAlignmentCenter];
		[self.contentView addSubview:_titlePhoto];
	}
	return self;
}


@end
