//
//  Movie.m
//  RottenMangoes
//
//  Created by Benson Huynh on 2015-11-10.
//  Copyright © 2015 Benson Huynh. All rights reserved.
//

#import "Movie.h"
#import "TheatreCollectionViewController.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)title synopsis: (NSString *)synopsis movieImageURL:(NSURL *)movieImageURL {
    self = [super init];
    if (self) {
        _title = title;
        _synopsis = synopsis;
        _movieImageURL = movieImageURL;
    }
    return self;
}

@end
