//
//  PListDownloader.h
//  BlockTest
//
//  Created by Brandon Trebitowski on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PListDownloader : NSObject

- (void) downloadPlistForURL:(NSURL *) url completionBlock:(void (^)(NSArray *data, NSError *error)) block;

@end
