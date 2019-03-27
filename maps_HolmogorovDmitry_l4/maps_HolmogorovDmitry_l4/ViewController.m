//
//  ViewController.m
//  maps_HolmogorovDmitry_l4
//
//  Created by Дмитрий on 26/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "LocationService.h"
#import "City.h"
#import "Temperature.h"
#import "DataManager.h"
#import <CoreLocation/CoreLocation.h>
#import <YYWebImage/YYWebImage.h>

@interface ViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) LocationService *service;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) City *origin;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) MKPointAnnotation* annotation;
@property (nonatomic, strong) UIImageView* iconWeather;
@property (nonatomic, strong) UILabel* temperatureCity;
@property (nonatomic, strong) Temperature* temp;
@property (nonatomic, strong) NSString* titleCity;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.orangeColor];
    
    [self searchBarSetup];
    
    _mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _mapView.showsUserLocation = true;
    MKScaleView* scale = [[MKScaleView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, self.view.bounds.size.width - 290, 30, 30)];
    [scale scaleVisibility];
    [scale mapView];
    self.mapView.showsScale = YES;
    [self.view addSubview:scale];
    [self.view addSubview:_mapView];
    [self addUI];
    [[DataManager sharedInstance] loadData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
}

-(void)addUI{
    UIButton* btnZoom = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 87.5, self.view.bounds.size.width - 250, 45, 45)];
    [btnZoom setTitle:@"℃" forState:UIControlStateNormal];
    [btnZoom setTintColor:UIColor.blackColor];
    [btnZoom setBackgroundColor:UIColor.lightGrayColor];
    btnZoom.layer.cornerRadius = 22.5;
    btnZoom.clipsToBounds = YES;
    [btnZoom addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZoom];
    
    UIButton* btnReduce = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, self.view.bounds.size.width - 290, 30, 30)];
    [btnReduce setTitle:@"✖️" forState:UIControlStateNormal];
    [btnReduce setBackgroundColor:UIColor.whiteColor];
    btnReduce.layer.cornerRadius = 15;
    btnReduce.clipsToBounds = YES;
    [btnReduce addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReduce];
    
    _iconWeather = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 120, 200, 90, 90)];
    self.iconWeather.contentMode = UIViewContentModeScaleAspectFill;
    [self.iconWeather setHidden:YES];
    [self.view addSubview:self.iconWeather];
    
    _temperatureCity = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 50, 240, 100, 50)];
    [self.temperatureCity setTextColor:UIColor.blueColor];
    UIFont* font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [self.temperatureCity setFont:font];
    [self.temperatureCity setHidden:YES];
    [self.view addSubview:self.temperatureCity];
}
-(void)info{
   [self loadTempWithLat:self.coordinate.latitude lon: self.coordinate.longitude];
    NSString* urlstring = @"https://openweathermap.org/img/w/";
    NSString* dotUrl = @"png";
    NSString* dotUrl1 = @".";

    [self.iconWeather yy_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@", urlstring, self.temp.icon, dotUrl1, dotUrl]] options:YYWebImageOptionSetImageWithFadeAnimation];
    NSLog(@"%@%@%@%@", urlstring, self.temp.icon, dotUrl1, dotUrl);
    [self.temperatureCity setText:[NSString stringWithFormat:@"%@°", self.temp.temperature]];
    CLLocation* location = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    [self addressFromLocation:location];
    [self.temperatureCity setHidden:NO];
    [self.iconWeather setHidden:NO];

    _annotation = [[MKPointAnnotation alloc] init];
    self.annotation.title = self.titleCity;
    self.annotation.subtitle =  self.titleCity;;
    self.annotation.coordinate = self.coordinate;
    [self.mapView addAnnotation:self.annotation];
    NSLog(@"info");
}
-(void)reduce{
    [self.mapView removeAnnotation:self.annotation];
    [self.iconWeather setHidden:YES];
    [self.temperatureCity setHidden:YES];
    NSLog(@"disinfo");
}
-(void)loadTempWithLat:(double)lat lon:(double)lon{
    NSString* api = @"openweathermap.org/data/2.5/weather?";
    NSString* appid = @"e536bca24d49be2dbc098d36b5e41a74";
    NSString* url = [NSString stringWithFormat:@"https://api.%@lat=%f&lon=%f&appid=%@", api, lat, lon, appid];

    [self load:url withCompletion:^(id  _Nullable result) {
        NSDictionary* json = result;
        self.temp = [[Temperature alloc] initWithTemperature:[[json valueForKey:@"main"] valueForKey:@"temp"] icon:[[json valueForKey:@"weather"][0] valueForKey:@"icon"]];
        NSLog(@"temperature - %@", self.temp.temperature);
        NSLog(@"%d",(int)[[json valueForKey:@"main"] valueForKey:@"temp"]);
        NSLog(@"icon - %@", self.temp.icon);

    }];
}
- (void)dataLoadedSuccessfully {
    _service = [[LocationService alloc] init];
}

- (void)updateCurrentLocation:(NSNotification*)notification {
    CLLocation *currentLocation = notification.object;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 100000, 100000);
    [_mapView setRegion:region];
    
    if (currentLocation) {
        _origin = [[DataManager sharedInstance]cityForLocation:currentLocation];
        [self loadTempWithLat:self.origin.coordinate.latitude lon: self.origin.coordinate.longitude];
    }
}
//MARK: - geocoder
- (void)addressFromLocation:(CLLocation *)location {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if ([placemarks count] > 0) {
            self.titleCity = [placemarks lastObject].name;
        }
    }];
}
- (void)locationFromAddress:(NSString *)address {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            self.coordinate = placemark.location.coordinate;
        }
    }];
}
//MARK: - SearchBar
-(void)searchBarSetup{
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.barStyle = UIBarStyleDefault;
    self.navigationItem.titleView = _searchBar;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self locationFromAddress:searchText];
    if ([searchText isEqualToString:@""]) {
        self.coordinate = self.origin.coordinate;
    }
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.coordinate, 100000, 100000);
    
    [_mapView setRegion:region];
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
