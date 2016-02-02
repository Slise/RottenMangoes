//
//  Theatre.m
//  RottenMangoes
//
//  Created by Benson Huynh on 2016-02-02.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import "Theatre.h"

@interface Theatre ()

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *subtitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation Theatre

- (instancetype)initWith:(NSString *)title address:(NSString*)subtitle location:(CLLocationCoordinate2D) coordinate
{
    self = [super init];
    if (self) {
        _title = title;
        _subtitle = subtitle;
        _coordinate = coordinate;
    }
    return self;
}

@end
