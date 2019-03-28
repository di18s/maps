//mapsss
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
@property (nonatomic, assign) CLLocationCoordinate2D origin;
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
    
    _annotation = [[MKPointAnnotation alloc] init];
}
//MARK: - работа с кнопками
-(void)info{
   [self loadTempWithLat:self.coordinate.latitude lon: self.coordinate.longitude];
    NSString* urlstring = @"https://openweathermap.org/img/w/";
    NSString* ext = @"png";
    NSString* dotUrl = @".";

    [self.iconWeather yy_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@", urlstring, self.temp.icon, dotUrl, ext]] options:YYWebImageOptionSetImageWithFadeAnimation];
    [self.temperatureCity setText:[NSString stringWithFormat:@"%@°", self.temp.temperature]];
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    [self addressFromLocation:location];
    
    [self.temperatureCity setHidden:NO];
    [self.iconWeather setHidden:NO];

    self.annotation.title = self.titleCity;
    self.annotation.coordinate = self.coordinate;
    [self.mapView addAnnotation:self.annotation];
    NSLog(@"info");
}
-(void)reduce{
    [self.mapView removeAnnotation:self.annotation];
    self.iconWeather.image = nil;
    [self.iconWeather setHidden:YES];
    self.temperatureCity.text = nil;
    [self.temperatureCity setHidden:YES];
    NSLog(@"disinfo");
}

- (void)dataLoadedSuccessfully {
    _service = [[LocationService alloc] init];
}

- (void)updateCurrentLocation:(NSNotification*)notification {
    CLLocation *currentLocation = notification.object;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 100000, 100000);
    [_mapView setRegion:region];
    
    if (currentLocation) {
        self.coordinate = currentLocation.coordinate;
        self.origin = currentLocation.coordinate;
        [self addressFromLocation:currentLocation];
        [self loadTempWithLat:self.coordinate.latitude lon: self.coordinate.longitude];
        self.annotation.title = self.titleCity;
        self.annotation.coordinate = self.coordinate;
    }
}
//MARK: - geocoder
- (void)addressFromLocation:(CLLocation *)location {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if ([placemarks count] > 0) {
            self.titleCity = [placemarks firstObject].name;

            
        }
    }];
}
- (void)locationFromAddress:(NSString *)address {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
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
    [self loadTempWithLat:self.coordinate.latitude lon:self.coordinate.longitude];
    self.annotation.title = self.titleCity;
    self.annotation.coordinate = self.coordinate;
    if ([searchText isEqualToString:@""]) {
        self.coordinate = self.origin;
        [self reduce];
    }
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.coordinate, 100000, 100000);
    [_mapView setRegion:region];
}

//MARK: - datamanager
-(void)loadTempWithLat:(double)lat lon:(double)lon{
    NSString* api = @"openweathermap.org/data/2.5/weather?";
    NSString* appid = @"e536bca24d49be2dbc098d36b5e41a74";
    NSString* url = [NSString stringWithFormat:@"https://api.%@lat=%f&lon=%f&appid=%@", api, lat, lon, appid];
    [[DataManager sharedInstance] load:url withCompletion:^(id  _Nullable result) {
        NSDictionary* json = result;
        self.temp = [[Temperature alloc] initWithTemperature:[[json valueForKey:@"main"] valueForKey:@"temp"] icon:[[json valueForKey:@"weather"][0] valueForKey:@"icon"]];
    }];
}
@end
