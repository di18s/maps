//
//  Temperature.h
//  maps_HolmogorovDmitry_l4
//
//  Created by Дмитрий on 27/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Temperature : NSObject
@property (nonatomic, strong) NSString* temperature;
@property (nonatomic, strong) NSString* icon;
-(instancetype)initWithTemperature:(NSNumber*)temperature icon:(NSString*)icon;
@end

NS_ASSUME_NONNULL_END
