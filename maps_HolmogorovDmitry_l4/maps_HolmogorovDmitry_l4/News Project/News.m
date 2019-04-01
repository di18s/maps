//
//  News.m
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "Photo.h"

@implementation Photo
-(instancetype)initWithDictionary:(NSDictionary*)dictionary{
    if (self = [super init]){
        if ([dictionary valueForKey:@"title"] && ![[dictionary valueForKey:@"title"] isEqual:[NSNull null]]) {
            _titleNews = [dictionary valueForKey:@"title"];
        } if ([dictionary valueForKey:@"description"] && ![[dictionary valueForKey:@"description"] isEqual:[NSNull null]]){
            _descNews = [dictionary valueForKey:@"description"];
        }  if ([dictionary valueForKey:@"urlToImage"] &&![[dictionary valueForKey:@"urlToImage"] isEqual:[NSNull null]]){
            _imageNews = [dictionary valueForKey:@"urlToImage"];
            //NSLog(@"%@",_imageNews);
        }
 
    }
    return self;
}
@end
