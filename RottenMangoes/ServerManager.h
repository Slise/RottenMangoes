//
//  ServerManager.h
//  RottenMangoes
//
//  Created by Benson Huynh on 2016-02-01.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

+ (void)getData:(void (^)(NSArray *movies))completion;

@end
