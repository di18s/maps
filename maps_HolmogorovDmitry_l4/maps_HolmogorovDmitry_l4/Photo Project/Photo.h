//
//  News.h
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject
@property (nonatomic, strong) UIImage* image_Photo;
@property (nonatomic, strong) NSString* title_Photo;
-(instancetype)initWithPhoto:(UIImage*)photo andTitle:(NSString*)title;
@end

NS_ASSUME_NONNULL_END
