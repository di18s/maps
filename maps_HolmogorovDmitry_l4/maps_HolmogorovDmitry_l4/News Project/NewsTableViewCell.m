//
//  NewsTableViewCell.m
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsTitleViewController.h"

@implementation NewsTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _imageNews = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 170, 140)];
        self.imageNews.layer.cornerRadius = 15;
        self.imageNews.clipsToBounds = YES;
        self.imageNews.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageNews];
        
        _titleNews = [[UILabel alloc] initWithFrame:CGRectMake(180, 5 , self.contentView.frame.size.width - 110, 140)];
        [_titleNews setContentMode:UIViewContentModeTopLeft];
        _titleNews.numberOfLines = 7;
        [self.contentView addSubview:_titleNews];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
