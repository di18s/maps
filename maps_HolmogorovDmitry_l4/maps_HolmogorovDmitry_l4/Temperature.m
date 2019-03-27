//
//  Temperature.m
//  maps_HolmogorovDmitry_l4
//
//  Created by Дмитрий on 27/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "Temperature.h"
#import "ViewController.h"

@implementation Temperature
- (instancetype)initWithTemperature:(NSNumber*)temperature icon:(NSString *)icon{
    self = [super init];
    if (self) {
        _temperature = [NSString stringWithFormat:@"%ld", temperature.integerValue - 273];
        _icon = icon;
//        if (temperature && [temperature isEqualToString:[NSNull null]]) {
//            _temperature = temperature;
//        }
//        if (icon && [icon isEqualToString:[NSNull null]]) {
//            _icon = icon;
//        }
    }
    return self;
}
@end
