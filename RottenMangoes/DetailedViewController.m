//
//  DetailedViewController.m
//  RottenMangoes
//
//  Created by Benson Huynh on 2015-11-10.
//  Copyright © 2015 Benson Huynh. All rights reserved.
//

#import "DetailedViewController.h"
#import "Movie.h"
#import "TheatreCollectionViewController.h"
#import "MoviePosterCollectionViewCell.h"

@interface DetailedViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *detailedMoviePoster;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailSynopsis;

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailTitle.text = self.movie.title;
    self.detailSynopsis.text = self.movie.synopsis;
    self.detailedMoviePoster.image = self.movie.movieImage;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:self.movie.movieImageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *img = [UIImage imageWithData:data];
                self.detailedMoviePoster.image = img;
            });
        }
    }];
    [dataTask resume];
}

@end
