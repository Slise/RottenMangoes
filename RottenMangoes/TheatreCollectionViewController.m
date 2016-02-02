//
//  ViewController.m
//  RottenMangoes
//
//  Created by Benson Huynh on 2015-11-09.
//  Copyright © 2015 Benson Huynh. All rights reserved.
//

#import "TheatreCollectionViewController.h"
#import "Movie.h"
#import "MoviePosterCollectionViewCell.h"
#import "DetailedViewController.h"
#import "ServerManager.h"


@interface TheatreCollectionViewController ()

@property (nonatomic) NSArray *movieList;

@end

@implementation TheatreCollectionViewController

#pragma mark - View Controller Life Cycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
}

#pragma mark - Collection View Data Source -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoviePosterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.movie = self.movieList[indexPath.item];
    return cell;
}

- (void)getData {
    [ServerManager getData:^(NSArray *movies) {
        self.movieList = movies;
        [self.collectionView reloadData];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segueToDetails"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems]lastObject];
        Movie *movie = self.movieList[indexPath.item];
        DetailedViewController *detailView = [segue destinationViewController];
        detailView.movie = movie;
    }
}

@end
