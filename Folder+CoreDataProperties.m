//
//  Folder+CoreDataProperties.m
//  Memo
//
//  Created by chaving on 2017. 1. 16..
//  Copyright © 2017년 chaving. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Folder+CoreDataProperties.h"

@implementation Folder (CoreDataProperties)

+ (NSFetchRequest<Folder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Folder"];
}

@dynamic title;

@end
