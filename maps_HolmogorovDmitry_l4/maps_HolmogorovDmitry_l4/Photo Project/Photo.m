//
//  News.m
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "Photo.h"

@implementation Photo
-(instancetype)initWithPhoto:(UIImage*)photo andTitle:(NSString*)title{
    if (self = [super init]){
        _title_Photo = title;
        _image_Photo = photo;
    
    }
    return self;
}
@end
