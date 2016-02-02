//
//  MapViewController.m
//  RottenMangoes
//
//  Created by Benson Huynh on 2016-02-02.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import "MapViewController.h"
#import "Theatre.h"
#import "LocationManager.h"
#import "MapKit/MapKit.h"
#import <AddressBookUI/AddressBookUI.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>

#define zoominMapArea 2100

@interface MapViewController () <MKMapViewDelegate>

@property (strong, nonatomic) LocationManager *locationManager;
@property (strong,nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSMutableArray *theatres;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.locationManager = [LocationManager locationManager];
    
    [self.locationManager startLocationManager];
    self.mapView.showsUserLocation = true;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdate) name:@"updatedLocation" object:nil];
    
}

-(void)locationUpdate {
    
    NSLog(@"CURRENT LOCATION: %f, %f", [self.locationManager.currentLocation coordinate].latitude, [self.locationManager.currentLocation coordinate].longitude);
    
    _currentLocation = _locationManager.currentLocation;
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake([_currentLocation coordinate].latitude, [_currentLocation coordinate].longitude);
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoominMapArea, zoominMapArea);
    [_mapView setRegion:adjustedRegion animated:YES];
    
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:_currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            CLPlacemark* placemark = [placemarks firstObject];
            if (placemark) {
                NSString *zipCode = [placemark postalCode];
                [self downloadTheatreInfo:zipCode];
            }
        }
    }];
    
}

-(void)downloadTheatreInfo:(NSString *)zipCode {
    NSString *urlString = @"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=";
    urlString = [urlString stringByAppendingString:zipCode];
    urlString = [urlString stringByAppendingString:@"&movie="];
    urlString = [urlString stringByAppendingString:self.movie.title];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSError *jsonError = nil;
            NSDictionary *dictFromJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSArray *theatresFromJSONDict = [dictFromJSON objectForKey:@"theatres"];
            self.theatres = [NSMutableArray new];
            
            for (NSDictionary *theatre in theatresFromJSONDict) {
                NSString *name = [theatre objectForKey:@"name"];
                NSString *address = [theatre objectForKey:@"address"];
                NSNumber *lat = [theatre objectForKey:@"lat"];
                NSNumber *lng = [theatre objectForKey:@"lng"];
                
                CLLocationCoordinate2D theatreLocation = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
                
                Theatre *newTheatre = [[Theatre alloc] initWith:name address:address location:theatreLocation];
        
                dispatch_async(dispatch_get_main_queue(), ^(){

                    [self.mapView addAnnotation:newTheatre];
                });
            }
        }
    }];
    [dataTask resume];
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [view setCanShowCallout:YES];
}

@end
