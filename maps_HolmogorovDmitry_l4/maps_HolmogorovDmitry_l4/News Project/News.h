//
//  News.h
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject
@property (nonatomic, strong) NSString* imageNews;
@property (nonatomic, strong) NSString* titleNews;
@property (nonatomic, strong) NSString* descNews;
-(instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end

NS_ASSUME_NONNULL_END
