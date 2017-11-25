//
//  CFMoreView.m
//  talkDome
//
//  Created by thbdsz on 2017/11/25.
//  Copyright © 2017年 chaofan. All rights reserved.
//

#import "CFMoreView.h"

@implementation CFMoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"CFMoreView";
        [self addSubview:label];
    }
    return self;
}

@end
