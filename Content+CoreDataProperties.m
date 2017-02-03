//
//  Content+CoreDataProperties.m
//  Memo
//
//  Created by chaving on 2017. 1. 16..
//  Copyright © 2017년 chaving. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Content+CoreDataProperties.h"

@implementation Content (CoreDataProperties)

+ (NSFetchRequest<Content *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Content"];
}

@dynamic text;
@dynamic date;

@end
