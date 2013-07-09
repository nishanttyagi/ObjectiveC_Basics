//
//  AssociatingDataWithObject.m
//  ObjectiveC_Basics
//
//  Created by Nishant Tyagi on 7/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import "AssociatingDataWithObject.h"
#import <objc/runtime.h>

static char * kIndexPathAssociationKeyMA = "associated_mutablearray_key";
static char * kIndexPathAssociationKeySTR = "associated_string_key";

@interface AssociatingDataWithObject ()

@end

@implementation AssociatingDataWithObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *myAttachedValue = @"This is the info I am associating with button";
    objc_setAssociatedObject(self.testBtn,
                             kIndexPathAssociationKeySTR,
                             myAttachedValue,
                             OBJC_ASSOCIATION_RETAIN);
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithObjects:@"object1",@"object 2", nil];
    objc_setAssociatedObject(self.testBtn,
                             kIndexPathAssociationKeyMA,
                             tempArr,
                             OBJC_ASSOCIATION_RETAIN);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnTouched:(UIButton *)sender
{
    NSString *valueIs = (NSString *)objc_getAssociatedObject(self.testBtn, kIndexPathAssociationKeySTR);
    NSLog(@"value is : %@",valueIs);
    
    NSMutableArray *tempArr = (NSMutableArray *)objc_getAssociatedObject(self.testBtn, kIndexPathAssociationKeyMA);
    NSLog(@"tempArr is : %@",tempArr);
}
@end
