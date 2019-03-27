//
//  DataManager.m
//  Tickets
//
//  Created by Maxim Prigozhenkov on 14/03/2019.
//  Copyright © 2019 Maxim Prigozhenkov. All rights reserved.
//

#import "DataManager.h"

@interface DataManager()

@property (nonatomic, strong) NSMutableArray *citiesArray;

@end

@implementation DataManager

+ (instancetype)sharedInstance {
    static DataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] init];
    });
    return instance;
}

- (void)loadData {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        NSArray *citiesJsonArray = [self arrayFromFileName:@"cities" ofType:@"json"];
        self.citiesArray = [self createObjectsFromArray:citiesJsonArray withType:DataSourceTypeCity];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kDataManagerLoadDataDidComplete object:nil];
        });
        NSLog(@"Complete");
    });
}

- (NSMutableArray *)createObjectsFromArray:(NSArray *)array withType:(DataSourceType)type {
    NSMutableArray *results = [NSMutableArray new];
    
    for (NSDictionary *json in array) {
        if (type == DataSourceTypeCity) {
            City *city = [[City alloc] initWithDictionary:json];
            [results addObject:city];
        }
        
    }
    
    return results;
}

- (City*)cityForLocation:(CLLocation*)location {
    for (City *city in _citiesArray) {
        if (ceilf(city.coordinate.latitude) == ceilf(location.coordinate.latitude) && ceilf(city.coordinate.longitude) == ceilf(location.coordinate.longitude)) {
            return city;
        }
    }
    return nil;
}

- (NSArray *)arrayFromFileName:(NSString*)fileName ofType:(NSString*)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}
    
- (NSArray*)cities {
    return _citiesArray;
}

- (City*)cityForIATA:(NSString*)iata {
    if (iata) {
        for (City *city in _citiesArray) {
            if ([city.code isEqualToString:iata]) {
                return city;
            }
        }
    }
    return nil;
}
    
@end
