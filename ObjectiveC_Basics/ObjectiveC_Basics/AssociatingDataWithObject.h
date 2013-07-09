//
//  AssociatingDataWithObject.h
//  ObjectiveC_Basics
//
//  Created by Nishant Tyagi on 7/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssociatingDataWithObject : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
- (IBAction)btnTouched:(UIButton *)sender;

@end
