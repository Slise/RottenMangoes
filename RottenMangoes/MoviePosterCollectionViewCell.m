//
//  MoviePosterCollectionViewCell.m
//  RottenMangoes
//
//  Created by Benson Huynh on 2015-11-10.
//  Copyright © 2015 Benson Huynh. All rights reserved.
//

#import "MoviePosterCollectionViewCell.h"
#import "Movie.h"


@interface MoviePosterCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;

@property (nonatomic) NSURLSessionTask *cellTask;

@end

@implementation MoviePosterCollectionViewCell

- (void)setMovie:(Movie *)movie {
    _movie = movie;
    
    [self configure];
}

- (void)configure {
    self.posterImage.image = self.movie.movieImage;
    
    //clear image before cell is reused
    self.posterImage.image = nil;
    
    //get rid of race condition
    if (self.cellTask) {
        [self.cellTask cancel];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    self.cellTask = [session dataTaskWithURL:self.movie.movieImageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //use cached image
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *img = [UIImage imageWithData:data];
                self.movie.movieImage = img;
                self.posterImage.image = img;
            });
        }
    }];
    [self.cellTask resume];
}

@end
