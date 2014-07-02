//
//  PeriLargeTableViewCell.m
//  SemiStaticExample
//
//  Created by Sam Jacobson on 28/05/14.
//  Copyright (c) 2014 PeriSentient Ltd. All rights reserved.
//

#import "PeriLargeTableViewCell.h"

@interface PeriLargeTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel * lblContent;

@end

@implementation PeriLargeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(NSString *)content {
	_lblContent.text = content;
}

@end
