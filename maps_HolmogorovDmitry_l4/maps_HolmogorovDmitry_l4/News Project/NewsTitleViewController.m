//
//  ViewController.m
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "PhotoTitleViewController.h"
#import "NewsDescriptionViewController.h"
#import "Photo.h"
#import "NewsTableViewCell.h"
#import <YYWebImage/YYWebImage.h>
#define NewsImage(iata) [NSURL URLWithString: iata];

@interface PhotoTitleViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray* businessArray;
@property (nonatomic, strong) NSMutableArray* sportsArray;
@property (nonatomic, strong) NSMutableArray* scienceArray;
@property (nonatomic, strong) NSMutableArray* technologyArray;
@property (nonatomic, strong) NSMutableArray* healthArray;
@property (nonatomic, strong) NSMutableArray* entertainment;
@property (nonatomic, strong) NSMutableArray* newsArray;

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UISegmentedControl* theme;
@property (nonatomic, strong) NSArray* urlNews;
@end

@implementation PhotoTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.magentaColor];
    self.urlNews = @[@"https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=07967613987b407298c77142b50151f9",
                     @"https://newsapi.org/v2/top-headlines?country=ru&category=entertainment&apiKey=07967613987b407298c77142b50151f9",
                     @"https://newsapi.org/v2/top-headlines?country=ru&category=sport&apiKey=07967613987b407298c77142b50151f9",
                     @"https://newsapi.org/v2/top-headlines?country=ru&category=science&apiKey=07967613987b407298c77142b50151f9",
                     @"https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=07967613987b407298c77142b50151f9",
                     @"https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=07967613987b407298c77142b50151f9",
                     @"https://newsapi.org/v2/top-headlines?country=ru&apiKey=07967613987b407298c77142b50151f9"];
    
    [self loadContent];
    [self themeSelection];
    
    _tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 150;
    [_tableView setBackgroundColor:UIColor.whiteColor];
    [self.view addSubview:_tableView];
    
}

//MARK: segment controll
-(void)themeSelection{
    _theme =[[UISegmentedControl alloc] initWithItems:@[@"Бизнес", @"Развлечения", @"Спорт", @"Наука", @"Здоровье", @"Технологии"]];
    _theme.tintColor = [UIColor blackColor];
    [_theme addTarget:self action:@selector(selectSegment) forControlEvents:UIControlEventValueChanged];
    _theme.selectedSegmentIndex = 0;
    self.navigationItem.titleView = _theme;
}


-(void)selectSegment{
    if (self.theme.selectedSegmentIndex == 0 && self.businessArray.count == 0) {
        [self alert];
        self.theme.selectedSegmentIndex = 1;
    } else if (self.theme.selectedSegmentIndex == 1 && self.entertainment.count == 0){
        [self alert];
        self.theme.selectedSegmentIndex = 2;
    } else if (self.theme.selectedSegmentIndex == 2 && self.sportsArray.count == 0){
        [self alert];
        self.theme.selectedSegmentIndex = 3;
    } else if (self.theme.selectedSegmentIndex == 3 && self.scienceArray.count == 0){
        [self alert];
        self.theme.selectedSegmentIndex = 4;
    } else if (self.theme.selectedSegmentIndex == 4 && self.healthArray.count == 0){
        [self alert];
        self.theme.selectedSegmentIndex = 5;
    } else if (self.theme.selectedSegmentIndex == 5 && self.technologyArray.count == 0){
        [self alert];
        self.theme.selectedSegmentIndex = 0;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
-(void)alert{
    UIAlertController *alert = [UIAlertController new];
    alert = [UIAlertController alertControllerWithTitle:@"Ой, что-то пошло не так.." message:@"Возможно в этой теме нет новостей" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
//                                                              self.theme.selectedSegmentIndex = 0;
//                                                              [self.tableView reloadData];
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion: nil];
}

-(void)loadContent{
    [self load:self.urlNews[0] withCompletion:^(id _Nullable result) {
        NSDictionary* json = result;
        self.businessArray = [NSMutableArray new];
        for (NSDictionary *i in [json objectForKey:@"articles"]){
            Photo* news = [[Photo alloc] initWithDictionary:i];
            [self.businessArray addObject:news];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [self load:self.urlNews[1] withCompletion:^(id _Nullable result) {
        NSDictionary* json = result;
        self.entertainment = [NSMutableArray new];
        for (NSDictionary *i in [json objectForKey:@"articles"]){
            Photo* news = [[Photo alloc] initWithDictionary:i];
            [self.entertainment addObject:news];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [self load:self.urlNews[2] withCompletion:^(id _Nullable result) {
        NSDictionary* json = result;
        self.sportsArray = [NSMutableArray new];
        for (NSDictionary *i in [json objectForKey:@"articles"]){
            Photo* news = [[Photo alloc] initWithDictionary:i];
            [self.sportsArray addObject:news];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [self load:self.urlNews[3] withCompletion:^(id _Nullable result) {
        NSDictionary* json = result;
        self.scienceArray = [NSMutableArray new];
        for (NSDictionary *i in [json objectForKey:@"articles"]){
            Photo* news = [[Photo alloc] initWithDictionary:i];
            [self.scienceArray addObject:news];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [self load:self.urlNews[4] withCompletion:^(id _Nullable result) {
        NSDictionary* json = result;
        self.healthArray = [NSMutableArray new];
        for (NSDictionary *i in [json objectForKey:@"articles"]){
            Photo* news = [[Photo alloc] initWithDictionary:i];
            [self.healthArray addObject:news];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [self load:self.urlNews[5] withCompletion:^(id _Nullable result) {
        NSDictionary* json = result;
        self.technologyArray = [NSMutableArray new];
        for (NSDictionary *i in [json objectForKey:@"articles"]){
            Photo* news = [[Photo alloc] initWithDictionary:i];
            [self.technologyArray addObject:news];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [self load:self.urlNews[6] withCompletion:^(id _Nullable result) {
        NSDictionary* json = result;
        self.newsArray = [NSMutableArray new];
        for (NSDictionary *i in [json objectForKey:@"articles"]){
            Photo* news = [[Photo alloc] initWithDictionary:i];
            [self.newsArray addObject:news];
        }
    }];
}

//MARK: - TVCdataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.theme.selectedSegmentIndex) {
        case 0:
            return self.businessArray.count;
            break;
        case 1:
            return self.entertainment.count;
            break;
        case 2:
            return self.sportsArray.count;
            break;
        case 3:
            return self.scienceArray.count;
            break;
        case 4:
            return self.healthArray.count;
            break;
        case 5:
            return self.technologyArray.count;
            break;
        default:
            return self.newsArray.count;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] init];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (self.theme.selectedSegmentIndex) {
        case 0:
            [cell.imageNews yy_setImageWithURL:[NSURL URLWithString:[self.businessArray[indexPath.row]imageNews]] options:YYWebImageOptionSetImageWithFadeAnimation];
            cell.titleNews.text = [self.businessArray[indexPath.row] titleNews];
            break;
        case 1:
            [cell.imageNews yy_setImageWithURL:[NSURL URLWithString:[self.entertainment[indexPath.row]imageNews]] options:YYWebImageOptionSetImageWithFadeAnimation];
            cell.titleNews.text = [self.entertainment[indexPath.row] titleNews];
            break;
        case 2:
            [cell.imageNews yy_setImageWithURL:[NSURL URLWithString:[self.sportsArray[indexPath.row]imageNews]] options:YYWebImageOptionSetImageWithFadeAnimation];
            cell.titleNews.text = [self.sportsArray[indexPath.row] titleNews];
            break;
        case 3:
            [cell.imageNews yy_setImageWithURL:[NSURL URLWithString:[self.scienceArray[indexPath.row]imageNews]] options:YYWebImageOptionSetImageWithFadeAnimation];
            cell.titleNews.text = [self.scienceArray[indexPath.row] titleNews];
            break;
        case 4:
            [cell.imageNews yy_setImageWithURL:[NSURL URLWithString:[self.healthArray[indexPath.row]imageNews]] options:YYWebImageOptionSetImageWithFadeAnimation];
            cell.titleNews.text = [self.healthArray[indexPath.row] titleNews];
            break;
        case 5:
            [cell.imageNews yy_setImageWithURL:[NSURL URLWithString:[self.technologyArray[indexPath.row]imageNews]] options:YYWebImageOptionSetImageWithFadeAnimation];
            cell.titleNews.text = [self.technologyArray[indexPath.row] titleNews];
            break;
        default:
            [cell.imageNews yy_setImageWithURL:[NSURL URLWithString:[self.newsArray[indexPath.row]imageNews]] options:YYWebImageOptionSetImageWithFadeAnimation];
            cell.titleNews.text = [self.newsArray[indexPath.row] titleNews];
            break;
    }
    return cell;
}
//MARK: - TVCdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDescriptionViewController* vc = [NewsDescriptionViewController new];
    switch (self.theme.selectedSegmentIndex) {
        case 0:
            vc.desc_news_ST = [self.businessArray[indexPath.row]descNews];
            vc.title_News_ST = [self.businessArray[indexPath.row]titleNews];
            vc.image_News_ST = [self.businessArray[indexPath.row]imageNews];
            break;
        case 1:
            vc.desc_news_ST = [self.entertainment[indexPath.row]descNews];
            vc.title_News_ST = [self.entertainment[indexPath.row]titleNews];
            vc.image_News_ST = [self.entertainment[indexPath.row]imageNews];
            break;
        case 2:
            vc.desc_news_ST = [self.sportsArray[indexPath.row]descNews];
            vc.title_News_ST = [self.sportsArray[indexPath.row]titleNews];
            vc.image_News_ST = [self.sportsArray[indexPath.row]imageNews];
            break;
        case 3:
            vc.desc_news_ST = [self.scienceArray[indexPath.row]descNews];
            vc.title_News_ST = [self.scienceArray[indexPath.row]titleNews];
            vc.image_News_ST = [self.scienceArray[indexPath.row]imageNews];
            break;
        case 4:
            vc.desc_news_ST = [self.healthArray[indexPath.row]descNews];
            vc.title_News_ST = [self.healthArray[indexPath.row]titleNews];
            vc.image_News_ST = [self.healthArray[indexPath.row]imageNews];
            break;
        case 5:
            vc.desc_news_ST = [self.technologyArray[indexPath.row]descNews];
            vc.title_News_ST = [self.technologyArray[indexPath.row]titleNews];
            vc.image_News_ST = [self.technologyArray[indexPath.row]imageNews];
            break;
        default:
            vc.desc_news_ST = [self.newsArray[indexPath.row]descNews];
            vc.title_News_ST = [self.newsArray[indexPath.row]titleNews];
            vc.image_News_ST = [self.newsArray[indexPath.row]imageNews];
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK: - DataManager
-(void)load:(NSString*)urlString withCompletion:(void(^)(id _Nullable result))completion{
    NSURLSession* session = [NSURLSession sharedSession];
    
    NSURLSessionTask* task = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id serialization = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completion(serialization);
    }];
    [task resume];
}
@end
