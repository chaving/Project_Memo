//
//  Content+CoreDataProperties.h
//  Memo
//
//  Created by chaving on 2017. 1. 16..
//  Copyright © 2017년 chaving. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Content+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Content (CoreDataProperties)

+ (NSFetchRequest<Content *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSString *date;

@end

NS_ASSUME_NONNULL_END
