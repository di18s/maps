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
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
//        NSArray *citiesJsonArray = [self arrayFromFileName:@"cities" ofType:@"json"];
//        self.citiesArray = [self createObjectsFromArray:citiesJsonArray withType:DataSourceTypeCity];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kDataManagerLoadDataDidComplete object:nil];
        });
        NSLog(@"Complete");
//    });
}

-(void)load:(NSString*)urlString withCompletion:(void(^)(id _Nullable result))completion{
    NSURLSession* session = [NSURLSession sharedSession];
    
    NSURLSessionTask* task = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id serialization = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completion(serialization);
    }];
    [task resume];
}

    
@end
