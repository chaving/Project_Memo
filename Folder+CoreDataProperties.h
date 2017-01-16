//
//  Folder+CoreDataProperties.h
//  Memo
//
//  Created by chaving on 2017. 1. 16..
//  Copyright © 2017년 chaving. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Folder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Folder (CoreDataProperties)

+ (NSFetchRequest<Folder *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
