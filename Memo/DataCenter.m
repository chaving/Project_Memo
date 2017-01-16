//
//  DataCenter.m
//  Memo
//
//  Created by chaving on 2017. 1. 16..
//  Copyright © 2017년 chaving. All rights reserved.
//

#import "DataCenter.h"

#import "AppDelegate.h"
#import "Folder+CoreDataClass.h"
#import "Content+CoreDataClass.h"

@interface DataCenter ()

@property (strong,nonatomic) AppDelegate *appDelegate;
@property (strong,nonatomic) NSManagedObjectContext *context;

@end

@implementation DataCenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _context = _appDelegate.persistentContainer.viewContext;
    }
    return self;
}

+ (void)testDataCenter{

    NSLog(@"들어오냐!!!!");
}

- (void)addNewFolder:(UIAlertController *)alertController{

    NSLog(@"Add Folder");
    
    Folder *folderEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Folder" inManagedObjectContext:_context];
    folderEntity.title = alertController.textFields.firstObject.text;
    
    NSError *error;
    
    if (![_context save:&error]) {
        NSLog(@"Error : %@", [error description]);
    }
    
//    [self requestFolderData];
}

- (NSArray *)requestFolderData{
    
    NSLog(@"request");
    
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Folder" inManagedObjectContext:_context];
    NSArray *folderArray = [[_context executeFetchRequest:request error:&error] mutableCopy];
    
    if (error) {
        NSLog(@"Error : %@", [error description]);
    }
    
    NSLog(@"Array : %@", [folderArray valueForKey:@"title"]);
    NSLog(@"title : %@", [folderArray[0] valueForKey:@"title"]);
    
    return folderArray;
}

@end
