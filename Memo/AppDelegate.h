//
//  AppDelegate.h
//  Memo
//
//  Created by chaving on 2017. 1. 11..
//  Copyright © 2017년 chaving. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

