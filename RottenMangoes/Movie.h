//
//  Movie.h
//  RottenMangoes
//
//  Created by Benson Huynh on 2015-11-10.
//  Copyright © 2015 Benson Huynh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *synopsis;
@property (nonatomic) NSURL *movieImageURL;
@property (nonatomic) UIImage *movieImage;

- (instancetype)initWithTitle:(NSString *)title synopsis: (NSString *)synopsis movieImageURL:(NSURL*)movieImageURL;

@end
