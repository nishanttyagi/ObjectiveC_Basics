//
//  ViewController.h
//  ObjectiveC_Basics
//
//  Created by Nishant Tyagi on 7/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>
{
    NSArray *allFunctionsArray;
}

@property (nonatomic , strong)IBOutlet UITableView *table;
@end
