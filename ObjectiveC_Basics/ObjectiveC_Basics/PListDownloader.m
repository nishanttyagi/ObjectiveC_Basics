//
//  PListDownloader.m
//  BlockTest
//
//  Created by Brandon Trebitowski on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PListDownloader.h"

@implementation PListDownloader

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) downloadPlistForURL:(NSURL *) url completionBlock:(void (^)(NSArray *data, NSError *error)) block
{
#pragma mark -
#pragma mark Using by creating own queue -
    // Using by creating own queue
    dispatch_queue_t my_queue  = dispatch_queue_create("my_queue", nil);
    
    dispatch_async(my_queue, ^{
        NSArray *returnArray = [NSArray arrayWithContentsOfURL:url];
        if(returnArray) {
            block(returnArray, nil);
        } else {
            NSError *error = [NSError errorWithDomain:@"plist_download_error" code:1
                                             userInfo:[NSDictionary dictionaryWithObject:@"Can't fetch data" forKey:NSLocalizedDescriptionKey]];
            block(nil, error);
        }
    });
    
#pragma mark -
#pragma mark Using Default Global__queue -
    // Using Default Global__queue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
        NSArray *returnArray = [NSArray arrayWithContentsOfURL:url];
        if(returnArray) {
            block(returnArray, nil);
        } else {
            NSError *error = [NSError errorWithDomain:@"plist_download_error" code:1 
                                             userInfo:[NSDictionary dictionaryWithObject:@"Can't fetch data" forKey:NSLocalizedDescriptionKey]];
            block(nil, error);
        }
        
    });
}

@end
