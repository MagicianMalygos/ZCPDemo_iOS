//
//  LocationViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/6/21.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LocationViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

// 定位
@property (weak, nonatomic) IBOutlet UIButton *locationButton;          // 定位按钮
@property (nonatomic, strong) CLLocationManager *locationManager;       // 定位管理器

// 地理信息反编码
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;   // 经度
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;    // 纬度
@property (weak, nonatomic) IBOutlet UITextField *altitudeTextField;    // 高度
@property (weak, nonatomic) IBOutlet UIButton *reverseGeocodeButton;    // 地理信息反编码按钮
@property (weak, nonatomic) IBOutlet UILabel *reverseGeocodeInfoLabel;  // 反编码得到的地理信息
@property (weak, nonatomic) IBOutlet UILabel *mapLocationReverseGeocodeInfoLabel;

// 地理信息编码查询
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;     // 地理信息
@property (weak, nonatomic) IBOutlet UIButton *geocodeButton;           // 编码查询按钮
@property (weak, nonatomic) IBOutlet UILabel *geocodeInfoLabel;         // 编码查询结果

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reverseGeocodeInfoLabel.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
    self.reverseGeocodeInfoLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    self.mapLocationReverseGeocodeInfoLabel.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    self.mapLocationReverseGeocodeInfoLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    self.geocodeInfoLabel.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
    self.geocodeInfoLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    
    [self.view addSubview:self.mapView];
}

#pragma mark - action

- (IBAction)clickLocationButton:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"定位"]) {
        // 开始定位
        [self.locationManager startUpdatingLocation];
        self.mapView.showsUserLocation = YES;
        [sender setTitle:@"取消" forState:UIControlStateNormal];
    } else if ([sender.titleLabel.text isEqualToString:@"取消"]) {
        // 停止定位
        [self.locationManager stopUpdatingLocation];
        self.mapView.showsUserLocation = YES;
        [sender setTitle:@"定位" forState:UIControlStateNormal];
    }
}

- (IBAction)clickReverseGeocodeButton:(UIButton *)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.latitudeTextField.text doubleValue] longitude:[self.longitudeTextField.text doubleValue]];
    
    WEAK_SELF;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error || placemarks.count <= 0) {
            weakSelf.reverseGeocodeInfoLabel.text = @"Reverse Geocode Error!";
            NSLog(@"Reverse Geocode Error!");
            return;
        }
        
        CLPlacemark *placemark          = [placemarks firstObject];
        NSDictionary *addressDictionary = placemark.addressDictionary;
        
        NSString *country   = addressDictionary[@"Country"];
        NSString *state     = addressDictionary[@"State"];
        NSString *city      = addressDictionary[@"City"];
        NSString *street    = addressDictionary[@"Street"];
        NSString *name      = addressDictionary[@"Name"];
        
        NSString *address   = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", country, state, city, street, name];
        
        if (sender == nil) {
            weakSelf.mapLocationReverseGeocodeInfoLabel.text = address;
        } else {
            weakSelf.reverseGeocodeInfoLabel.text = address;
        }
        NSLog(@"%@ %@ %@ %@ %@", country, state, city, street, name);
    }];
}

- (IBAction)clickGeocodeButton:(UIButton *)sender {
    NSString *address       = self.addressTextField.text;
    CLGeocoder *geocoder    = [[CLGeocoder alloc] init];
    
    WEAK_SELF;
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error || placemarks.count <= 0) {
            weakSelf.geocodeInfoLabel.text = @"Geocode Address Error!";
            NSLog(@"Geocode Address Error!");
            return;
        }
        
        CLPlacemark *placemark  = [placemarks firstObject];
        NSString *geocodeInfo   = [NSString stringWithFormat:@"经度：%lf 纬度：%lf 高度：%lf", placemark.location.coordinate.longitude, placemark.location.coordinate.latitude, placemark.location.altitude];
        weakSelf.geocodeInfoLabel.text = geocodeInfo;
        NSLog(@"%@", geocodeInfo);
    }];
}

#pragma mark - CLLocationManagerDelegate

// 定位成功回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count <= 0) {
        return;
    }
    
    CLLocation *location = [locations firstObject];
    
    self.longitudeTextField.text = [NSString stringWithFormat:@"%lf", location.coordinate.longitude];
    self.latitudeTextField.text = [NSString stringWithFormat:@"%lf", location.coordinate.latitude];
    self.altitudeTextField.text = [NSString stringWithFormat:@"%lf", location.altitude];
    
    [self clickReverseGeocodeButton:self.reverseGeocodeButton];
    
    NSLog(@"%lf %lf %lf", location.coordinate.longitude, location.coordinate.latitude, location.altitude);
}

// 定位失败回调
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.longitudeTextField.text = @"Location Error!!";
    self.latitudeTextField.text = @"Location Error!!";
    self.altitudeTextField.text = @"Location Error!!";
    NSLog(@"Location Error!!");
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"总是授权");
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        NSLog(@"应用试用期间授权");
    } else if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"拒绝");
    } else if (status == kCLAuthorizationStatusRestricted) {
        NSLog(@"受限");
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"用户还没有确定");
    }
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocation *location    = userLocation.location;
    
    self.longitudeTextField.text = [NSString stringWithFormat:@"%lf", location.coordinate.longitude];
    self.latitudeTextField.text = [NSString stringWithFormat:@"%lf", location.coordinate.latitude];
    self.altitudeTextField.text = [NSString stringWithFormat:@"%lf", location.altitude];
    
    [self clickReverseGeocodeButton:nil];
    
    NSLog(@"%lf %lf %lf", location.coordinate.longitude, location.coordinate.latitude, location.altitude);
}

#pragma mark - getter / setter

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 精度
        _locationManager.distanceFilter = 10.0f;  // 移动超过该距离后更新定位
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
            [_locationManager requestAlwaysAuthorization];
        }
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    return _locationManager;
}

@end
