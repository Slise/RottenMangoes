//
//  ServerManager.m
//  RottenMangoes
//
//  Created by Benson Huynh on 2016-02-01.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import "ServerManager.h"
#import "Config.h"
#import "Movie.h"

@implementation ServerManager

+ (void)getData:(void (^)(NSArray *movies))completion {
    NSString *urlString = apikey;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            NSError *jsonError = nil;
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSMutableArray *moviesArray = [NSMutableArray array];
            NSArray *movies = results[@"movies"];
            
            for (NSDictionary *eachMovie in movies ){
                NSString *title = eachMovie[@"title"];
                NSDictionary* posters = eachMovie[@"posters"];
                NSString *thumbnailString = posters[@"thumbnail"];
                NSString *synopsis = eachMovie[@"synopsis"];
                //resize image to hi-res
                //                NSRange thumbnailRange = [thumbnailString rangeOfString:@"dkpu1ddg7pbsk."];
                //                thumbnailString = [thumbnailString substringFromIndex:thumbnailRange.location];
                //                thumbnailString = [@"http://" stringByAppendingString:thumbnailString];
                NSURL *url = [NSURL URLWithString:thumbnailString];
                NSLog(@"movie url is: %@", url);
                Movie *aMovie = [[Movie alloc] initWithTitle:title synopsis:synopsis movieImageURL:url];
                [moviesArray addObject:aMovie];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(moviesArray);
            });
        }
    }];
    [dataTask resume];
}

@end
