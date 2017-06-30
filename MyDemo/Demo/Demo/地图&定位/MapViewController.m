//
//  MapViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/6/23.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"

#define ID_PIN_ANNOTATION  @"PIN_ANNOTTATION"

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *standardMapView;
@property (weak, nonatomic) IBOutlet MKMapView *satelliteMapView;
@property (weak, nonatomic) IBOutlet MKMapView *hybridMapView;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UISwitch *usingThirdMapsSwitch;

@property (nonatomic, assign, getter=isLocating) BOOL locating;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - MKMapViewDelegate

// 标注数据源
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID_PIN_ANNOTATION];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID_PIN_ANNOTATION];
    }
    annotationView.pinColor = MKPinAnnotationColorPurple;
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    annotationView.selected = YES;
    annotationView.opaque = NO;
    annotationView.draggable = YES;
    
    return annotationView;
}

// 点击标注
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
}

// 定位回调
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.standardMapView.centerCoordinate = userLocation.coordinate;
    self.satelliteMapView.centerCoordinate = userLocation.coordinate;
    self.hybridMapView.centerCoordinate = userLocation.coordinate;
}

#pragma mark - action

// 点击搜索按钮
- (IBAction)clickSearchButton:(UIButton *)sender {
    NSString *address = self.addressTextField.text;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    WEAK_SELF;
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count <= 0) {
            NSLog(@"Search None!");
        }
        
        [weakSelf.standardMapView removeAnnotations:self.standardMapView.annotations];
        [weakSelf.satelliteMapView removeAnnotations:self.satelliteMapView.annotations];
        [weakSelf.hybridMapView removeAnnotations:self.hybridMapView.annotations];
        
        if (self.usingThirdMapsSwitch.isEnabled) {
            NSMutableArray *mapItems = [NSMutableArray array];
            for (CLPlacemark *placemark in placemarks) {
                CLLocationCoordinate2D coordinate   = placemark.location.coordinate;
                NSDictionary *addressDict           = placemark.addressDictionary;
                MKPlacemark *place                  = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:addressDict];
                MKMapItem *mapItem                  = [[MKMapItem alloc] initWithPlacemark:place];
                [mapItems addObject:mapItem];
            }
            [MKMapItem openMapsWithItems:mapItems launchOptions:nil];
        } else {
            for (CLPlacemark *placemark in placemarks) {
                // region
                MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 1000, 1000);
                [weakSelf.standardMapView setRegion:region animated:YES];
                [weakSelf.satelliteMapView setRegion:region animated:YES];
                [weakSelf.hybridMapView setRegion:region animated:YES];
                
                // annotation
                MyAnnotation *annotation    = [[MyAnnotation alloc] init];
                annotation.streetAddress    = placemark.thoroughfare;
                annotation.city             = placemark.locality;
                annotation.state            = placemark.administrativeArea;
                annotation.zip              = placemark.postalCode;
                annotation.coordinate       = placemark.location.coordinate;
                annotation.title            = [NSString stringWithFormat:@"%@ %@", annotation.streetAddress, annotation.city];
                annotation.subtitle         = [NSString stringWithFormat:@"%@ %@", annotation.state, annotation.zip];
                
                [weakSelf.standardMapView addAnnotation:annotation];
                [weakSelf.satelliteMapView addAnnotation:annotation];
                [weakSelf.hybridMapView addAnnotation:annotation];
            }
        }
        [weakSelf.addressTextField resignFirstResponder];
    }];
}

// 点击定位按钮
- (IBAction)clickLocationButton:(UIButton *)sender {
    
    if (self.locating) {
        self.standardMapView.showsUserLocation = NO;
        self.satelliteMapView.showsUserLocation = NO;
        self.hybridMapView.showsUserLocation = NO;
        
        self.locating = NO;
        [self.locationButton setTitle:@"开始定位" forState:UIControlStateNormal];
    } else {
        // 开启定位
        self.standardMapView.showsUserLocation = YES;
        self.satelliteMapView.showsUserLocation = YES;
        self.hybridMapView.showsUserLocation = YES;
        
        // 设置region
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(0, 0), 10, 10);
        [self.standardMapView setRegion:region animated:YES];
        [self.satelliteMapView setRegion:region animated:YES];
        [self.hybridMapView setRegion:region animated:YES];
        
        // 跟踪用户位置和方向的变化（地图不能缩放和移动）
        [self.standardMapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
        [self.satelliteMapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
        [self.hybridMapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
        
        // 授权
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
        
        self.locating = YES;
        [self.locationButton setTitle:@"停止定位" forState:UIControlStateNormal];
    }
}

@end
