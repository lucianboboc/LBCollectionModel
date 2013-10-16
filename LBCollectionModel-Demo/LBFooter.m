//
//  LBFooter.m
//
//  Created by Lucian Boboc on 10/16/13.
//  Copyright (c) 2013 Lucian Boboc. All rights reserved.
//

#import "LBFooter.h"

@implementation LBFooter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self startSpinner];
    }
    return self;
}



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self startSpinner];
    }
    return self;
}

- (void) startSpinner
{
    [self.spinner startAnimating];
}

@end
