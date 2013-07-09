//
//  ViewController.m
//  ObjectiveC_Basics
//
//  Created by Nishant Tyagi on 7/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import "ViewController.h"
#import "GCDExampleVC.h"
#import "AssociatingDataWithObject.h"
#import "BlockExampleVC.h"
#import "FMDBExampleVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    allFunctionsArray = [[NSArray alloc] initWithObjects:@"GCD Exapmle + SDWebImage Usage",@"Associating Data To Objects",@"Custom Block",@"FMDB" , nil];
 
    [[self table] reloadData];
}

#pragma mark -
#pragma mark UITableView Delegates -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [allFunctionsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    cell.textLabel.text = [allFunctionsArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Courier" size:14.0f];
    cell.textLabel.textColor = [UIColor blueColor];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            GCDExampleVC *tempVC = [[GCDExampleVC alloc] init];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
            break;
        case 1:
        {
            AssociatingDataWithObject *tempVC = [AssociatingDataWithObject new];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
            break;
        case 2:
        {
            BlockExampleVC *tempVC = [BlockExampleVC new];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
            break;
        case 3:
        {
            FMDBExampleVC *tempVC = [FMDBExampleVC new];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
