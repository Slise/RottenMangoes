//
//  Theatre.h
//  RottenMangoes
//
//  Created by Benson Huynh on 2016-02-02.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MapKit/MapKit.h"

@interface Theatre : NSObject <MKAnnotation>

- (instancetype)initWith:(NSString *)title address:(NSString*)subtitle location:(CLLocationCoordinate2D) coordinate;

@end
