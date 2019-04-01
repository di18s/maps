//
//  DataManager.h
//  Tickets
//
//  Created by Maxim Prigozhenkov on 14/03/2019.
//  Copyright © 2019 Maxim Prigozhenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDataManagerLoadDataDidComplete @"kDataManagerLoadDataDidComplete"

typedef enum DataSourceType {
    DataSourceTypeCity,
} DataSourceType;

@interface DataManager : NSObject


+ (instancetype _Nonnull )sharedInstance;
- (void)loadData;
-(void)load:(NSString*_Nonnull)urlString withCompletion:(void(^_Nonnull)(id _Nullable result))completion;


@end

