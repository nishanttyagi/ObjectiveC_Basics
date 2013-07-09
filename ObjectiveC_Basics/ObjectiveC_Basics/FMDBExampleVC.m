//
//  FMDBExampleVC.m
//  ObjectiveC_Basics
//
//  Created by Nishant Tyagi on 7/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import "FMDBExampleVC.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface FMDBExampleVC ()

@end

@implementation FMDBExampleVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSString *) dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"PATH %@",[documentsDirectory stringByAppendingPathComponent:databasePath]);
	return [documentsDirectory stringByAppendingPathComponent:databasePath];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ///////
    [self checkAndCreateDatabase];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self dataFilePath]];
    [db open];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self dataFilePath]];
    [queue inDatabase:^(FMDatabase *db) {
        NSDate *dob = [NSDate new];
        
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"dd-MM-yyyy"];
        dob = [df dateFromString:@"10-11-1989"];
        
        [db executeUpdate:@"delete from table1"];
        
        [db executeUpdate:@"insert into table1(name, age,dob,about) values(?,?,?,?)",
         @"Nishant Tyagi",[NSNumber numberWithInt:25],dob,@"I am iOS developer",nil];
        
        dob = [df dateFromString:@"10-11-1980"];
        
        [db executeUpdate:@"insert into table1(name,age,dob,about) values(?,?,?,?)",@"Mohan ",[NSNumber numberWithInt:25],dob,@"I am iOS developer",nil];
        
        dob = [df dateFromString:@"10-11-2001"];
        
        [db executeUpdate:@"insert into table1(name,age,dob,about) values(?,?,?,?)",@"Ram'esh ",[NSNumber numberWithInt:25],dob,@"I am iOS developer",nil];
        
        dob = [df dateFromString:@"10-11-1947"];
        
        [db executeUpdate:@"insert into table1(name,age,dob,about) values(?,?,?,?)",@"Soha'n Shukl\"\a brother",[NSNumber numberWithInt:25],dob,@"I am iOS developer",nil];
        
        dob = [df dateFromString:@"10-01-1989"];
        
        [db executeUpdate:@"insert into table1(name,age,dob,about) values(?,?,?,?)",@"Rakesh Tiwari",[NSNumber numberWithInt:25],dob,@"I am iOS developer",nil];
        
        FMResultSet *rs = [db executeQuery:@"select * from table1 order by dob desc"];
        NSMutableArray *allData = [NSMutableArray new];
        
        while ([rs next]) {
            
            NSString *name = [[rs stringForColumnIndex:1] stringByReplacingOccurrencesOfString:@"" withString:@""];
            NSInteger age = [rs intForColumnIndex:2];
            NSDate *date = [rs dateForColumnIndex:3];
            NSString *about = [rs stringForColumnIndex:4];
            
            [df setDateFormat:@"dd-MM-yyyy"];
            NSString *birthdate = [df stringFromDate:date];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:name,[NSNumber numberWithInt:age],birthdate,about,nil] forKeys:[NSArray arrayWithObjects:@"name",@"age",@"date",@"about",nil]];
            [allData addObject:dict];
        }
        NSLog(@"alldata : %@",allData);
        if ([allData count] != 0) {
            NSAssert(true, @"array contains data");
        }
        [db close];
    }];
    
    
    //[db open];
    FMResultSet *rs = [db executeQuery:@"select count(*) from table1"];
    while ([rs next]) {
        int count = [rs intForColumnIndex:0];
        NSLog(@"count  : %d",count);
    }
    

}

-(void) checkAndCreateDatabase{
	// check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"TestDB.sqlite"]];
	
	// If the database already exists then return without doing anything
	if(success)
	{
		NSLog(@"Existed");
		return;
	}
	else
		NSLog(@"Not Existed");
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestDB.sqlite"];
	
	// Copy the database from the package to the users filesystem
    NSLog(@"databasePathFromApp %@",databasePathFromApp);
    
    NSLog(@"PATH %@",[documentsDirectory stringByAppendingPathComponent:@"TestDB.sqlite"]);
	[fileManager copyItemAtPath:databasePathFromApp toPath:[documentsDirectory stringByAppendingPathComponent:@"TestDB.sqlite"] error:nil];
	
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
