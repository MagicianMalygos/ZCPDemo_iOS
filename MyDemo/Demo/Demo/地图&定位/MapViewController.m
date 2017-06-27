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

@property (weak, nonatomic) IBOutlet MKMapView *StandardMapView;
@property (weak, nonatomic) IBOutlet MKMapView *SatelliteMapView;
@property (weak, nonatomic) IBOutlet MKMapView *HybridMapView;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID_PIN_ANNOTATION];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID_PIN_ANNOTATION];
    }
    annotationView.pinColor = MKPinAnnotationColorPurple;
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    
    return annotationView;
}

#pragma mark - action

- (IBAction)clickSearchButton:(UIButton *)sender {
    NSString *address = self.addressTextField.text;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    WEAK_SELF;
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count <= 0) {
            NSLog(@"Search None!");
        }
        
        [weakSelf.StandardMapView removeAnnotations:self.StandardMapView.annotations];
        [weakSelf.SatelliteMapView removeAnnotations:self.SatelliteMapView.annotations];
        [weakSelf.HybridMapView removeAnnotations:self.HybridMapView.annotations];
        
        for (CLPlacemark *placemark in placemarks) {
            
            // region
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 1000, 1000);
            [weakSelf.StandardMapView setRegion:region animated:YES];
            [weakSelf.SatelliteMapView setRegion:region animated:YES];
            [weakSelf.HybridMapView setRegion:region animated:YES];
            
            // annotation
            MyAnnotation *annotation = [[MyAnnotation alloc] init];
            annotation.streetAddress = placemark.thoroughfare;
            annotation.city = placemark.locality;
            annotation.state = placemark.administrativeArea;
            annotation.zip = placemark.postalCode;
            annotation.coordinate = placemark.location.coordinate;
            
            [weakSelf.StandardMapView addAnnotation:annotation];
            [weakSelf.SatelliteMapView addAnnotation:annotation];
            [weakSelf.HybridMapView addAnnotation:annotation];
        }
        [weakSelf.addressTextField resignFirstResponder];
    }];
}

@end
