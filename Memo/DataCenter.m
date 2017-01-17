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

#pragma mark - Add Folder
- (void)addNewFolder:(UIAlertController *)alertController{

    NSLog(@"Add Folder");
    
    Folder *folderEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Folder" inManagedObjectContext:_context];
    folderEntity.title = alertController.textFields.firstObject.text;
    
    NSError *error;
    
    if (![_context save:&error]) {
        NSLog(@"Error : %@", [error description]);
    }
}

#pragma mark - Request Folder Data
- (NSArray *)requestFolderData{
    
    NSLog(@"Request Folder Data");
    
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Folder" inManagedObjectContext:_context];
    NSArray *folderListArray = [[_context executeFetchRequest:request error:&error] mutableCopy];
    
    if (error) {
        NSLog(@"Error : %@", [error description]);
    }
    
    return folderListArray;
}

#pragma mark - Delete Folder
- (void)deleteFolderData:(UITableView *)tableview{
    
    NSLog(@"Delete Data");

    NSArray *selectedRows = [tableview indexPathsForSelectedRows];
    
    NSArray *folderListArray = [self requestFolderData];
    
    NSError *error;
    
    for (NSInteger i = 0; i < selectedRows.count; i ++) {
    
        NSIndexPath *firstIndexPath = [selectedRows objectAtIndex:i];
        
        Folder *deleteIndex = [folderListArray objectAtIndex:firstIndexPath.row];
        
        [_context deleteObject:deleteIndex];
        [_context save:&error];
    }
    
    [tableview reloadData];
}

#pragma mark - Delete One Data
- (void)deleteOneFolder:(NSIndexPath *)indexPath{

    NSLog(@"Delete One");
    
    NSError *error;
    
    NSArray *folderListArray = [self requestFolderData];
    
    Folder *deleteIndex = [folderListArray objectAtIndex:indexPath.row];
    
    [_context deleteObject:deleteIndex];
    [_context save:&error];
}































@end
