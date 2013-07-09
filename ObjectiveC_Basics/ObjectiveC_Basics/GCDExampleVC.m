//
//  GCDExampleVC.m
//  ObjectiveC_Basics
//
//  Created by Nishant Tyagi on 7/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import "GCDExampleVC.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDWebImageManagerDelegate.h"


@interface GCDExampleVC ()

@end

@implementation GCDExampleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *images = [[NSArray alloc] initWithObjects:@"http://www.hdwallpapersarena.com/wp-content/uploads/2013/05/apple-mac-high-resolution-wallpaper-11.png",@"http://www.hdwallpapersarena.com/wp-content/uploads/2013/05/apple-mac-high-resolution-wallpaper-11.png",@"http://www.hdwallpapersarena.com/wp-content/uploads/2013/05/apple-mac-high-resolution-wallpaper-11.png",@"http://cpcireland.farnell.com/productimages/farnell/standard/IN0521107-40.jpg",@"http://cpcireland.farnell.com/productimages/farnell/standard/IN0521107-40.jpg",@"http://cpcireland.farnell.com/productimages/farnell/standard/IN0521107-40.jpg", nil];
    
    CGPoint cgPoint = CGPointMake(10,30);
    NSLog(@"%@",[NSValue valueWithCGPoint:cgPoint]);
    
    int index = 0;
    
    for (NSString *urlString in images) {
        NSURL *url = [NSURL URLWithString:urlString];
        UIImageView *imv = (UIImageView *)[self.view viewWithTag:index];
        
        index++;
        
        if (!imv)  return ;
        
        [imv setImageWithURL:url placeholderImage:[UIImage imageNamed:@"thumbnail.png"] success:^(UIImage *image) {
            //Image Failed
            
        } failure:^(NSError *error) {
            // image succedded
            
        }];
    }
    
    
    return;
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // USING GCD(Grand Central Dispatch)
    dispatch_queue_t imageQueue = dispatch_queue_create("Image Queue",NULL);
    dispatch_async(imageQueue, ^{
        int index = 0;
        
        for (NSString *urlString in images) {
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            
            UIImageView *imv = (UIImageView *)[self.view viewWithTag:index];
            
            index++;
            
            if (!imv)  return ;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [imv setImage:image];
            });
        }
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
