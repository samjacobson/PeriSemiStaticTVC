//
//  PeriSectionArrayDataSource.h
//  Pods
//
//  Created by Sam Jacobson on 3/07/14.
//
//

#import "PeriDynamicSection.h"

@interface PeriSectionArrayDataSource : PeriDynamicSection

- (id)initWithItems:(NSArray *)items configureCellBlock:(PeriConfigureCell)configureCell;
- (id)objectAtIndexPath:(NSIndexPath*)indexPath;

@end
