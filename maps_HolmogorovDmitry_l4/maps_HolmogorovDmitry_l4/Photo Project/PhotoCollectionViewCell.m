//
//  NewsCollectionViewCell.m
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "NewsTitleViewController.h"

@implementation PhotoCollectionViewCell

//-(instancetype)init
//{
//    self = [super init];
//    if (self){
//        _imageNews = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x + 5, self.contentView.frame.origin.y / 2 - 140, 300, 280)];
//        self.imageNews.layer.cornerRadius = 15;
//        [self.contentView addSubview:_imageNews];
//
//        _titleNews = [[UILabel alloc] initWithFrame:CGRectMake(310, self.contentView.frame.origin.y / 2 - 140, self.contentView.frame.size.width - 310, 280)];
//        [self.contentView addSubview:_titleNews];
//
//    }
//    return self;
//}


- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self){
		_imageNews = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
		_imageNews.layer.cornerRadius = 15;
		[self.contentView addSubview:_imageNews];
		
		_titleNews = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, self.contentView.frame.size.width - 75, 50)];
		[self.contentView addSubview:_titleNews];
	}
	return self;
}


@end
