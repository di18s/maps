//
//  News.m
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "Photo.h"

@implementation Photo
-(instancetype)init{
    if (self = [super init]){
        _titleNews = @"title";
        _descNews = @"description news";
        _imageNews = @"url for news image";
    
    }
    return self;
}
@end
