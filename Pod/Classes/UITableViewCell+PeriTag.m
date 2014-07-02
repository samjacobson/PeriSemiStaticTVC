//
//  UITableViewCell+PeriTag.m
//  PeriSemiStaticTVC
//
//  Created by Sam Jacobson on 27/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "UITableViewCell+PeriTag.h"

@implementation UITableViewCell (PeriTag)
@dynamic peritag;

- (void)setPeritag:(NSString *)peritag {
	objc_setAssociatedObject(self, @selector(peritag), peritag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)peritag {
    return objc_getAssociatedObject(self, @selector(peritag));
}

@end
