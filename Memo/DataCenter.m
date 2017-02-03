//
//  DataCenter.m
//  Memo
//
//  Created by chaving on 2017. 1. 16..
//  Copyright © 2017년 chaving. All rights reserved.
//

#import "DataCenter.h"

#import "AppDelegate.h"
#import "Folder+CoreDataProperties.h"
#import "Content+CoreDataProperties.h"

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
    
    Folder *folderEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Folder"
                                                         inManagedObjectContext:_context];
    
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
    
    NSFetchRequest *request = [Folder fetchRequest];
    
    NSArray *folderListArray = [[_context executeFetchRequest:request error:&error] mutableCopy];
    
    NSLog(@"Folder Data Array : %@", folderListArray);
    
    NSLog(@"Folder Data Array Title : %@", [folderListArray valueForKey:@"title"]);
    
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

//-----------------------------------------------------------------------


#pragma mark - Add New Memo
- (void)addNewMemo:(UITextView *)textView{
    
    NSLog(@"Add Memo");
    
    Content *contentEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Content"
                                                         inManagedObjectContext:_context];
    
    NSDateFormatter *nowDate = [[NSDateFormatter alloc] init];
    nowDate.dateFormat = @"yyyy년 MM월 dd일 hh:mm a";
    
    contentEntity.text = textView.text;
    contentEntity.date = [nowDate stringFromDate:[NSDate date]];
    
    NSError *error;
    if (![_context save:&error]) {
        NSLog(@"Error : %@", [error description]);
    }
    
    [self requestMemoData];
}


#pragma mark - Request Memo Data
- (NSArray *)requestMemoData{
    
    NSLog(@"Request Memo Data");
    
    NSError *error;
    
    NSFetchRequest *request = [Content fetchRequest];
    
    NSArray *memoListArray = [[_context executeFetchRequest:request error:&error] mutableCopy];
    
    NSLog(@"Memo Data Array : %@", memoListArray);
    
    if (error) {
        NSLog(@"Error : %@", [error description]);
    }
    
    return memoListArray;
}































@end



