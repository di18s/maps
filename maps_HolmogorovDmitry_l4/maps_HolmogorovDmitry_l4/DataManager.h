//
//  DataManager.h
//  Tickets
//
//  Created by Maxim Prigozhenkov on 14/03/2019.
//  Copyright © 2019 Maxim Prigozhenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

#define kDataManagerLoadDataDidComplete @"kDataManagerLoadDataDidComplete"

typedef enum DataSourceType {
    DataSourceTypeCity,
} DataSourceType;

@interface DataManager : NSObject

@property (nonatomic, strong, readonly) NSArray *cities;

+ (instancetype)sharedInstance;
- (void)loadData;

- (City*)cityForIATA:(NSString*)iata;
- (City*)cityForLocation:(CLLocation*)location;

@end

