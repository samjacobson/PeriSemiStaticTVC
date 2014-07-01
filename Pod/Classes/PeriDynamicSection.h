//
//  PeriDynamicSection.h
//  SemiStaticExample
//
//  Created by Sam Jacobson on 28/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeriDynamicSection : NSObject

@property (weak, nonatomic) id<UITableViewDataSource> dataSource;
@property (nonatomic) NSInteger dataSection;
@property (strong, nonatomic) NSString * cellNib;
@property (nonatomic) CGFloat cellHeight;

@end
