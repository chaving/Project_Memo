//
//  DataCenter.h
//  Memo
//
//  Created by chaving on 2017. 1. 16..
//  Copyright © 2017년 chaving. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataCenter : NSObject

- (void)addNewFolder:(UIAlertController *)alertController;
- (NSArray *)requestFolderData;
- (void)deleteFolderData:(UITableView *)tableview;
- (void)deleteOneFolder:(NSIndexPath *)indexPath;

- (void)addNewMemo:(UITextView *)textView;
- (NSArray *)requestMemoData;

@end
