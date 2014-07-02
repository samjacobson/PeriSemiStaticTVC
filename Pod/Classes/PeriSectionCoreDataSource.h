//
//  PeriSectionCoreDataSource.h
//  PeriSemiStaticTVC
//
//  Created by Sam Jacobson on 2/07/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PeriDynamicSection.h"

@class NSFetchedResultsController, NSFetchRequest;

@interface PeriSectionCoreDataSource : PeriDynamicSection

- (id)initWithFetchRequest:(NSFetchRequest *)fetch managedObjectContext:(NSManagedObjectContext *)context configureCell:(PeriConfigureCell)configureCell;

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@end
