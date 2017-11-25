//
//  CFEmoticonView.m
//  talkDome
//
//  Created by thbdsz on 2017/11/24.
//  Copyright © 2017年 chaofan. All rights reserved.
//

#import "CFEmoticonView.h"

@implementation CFEmoticonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"CFEmoticonView";
        [self addSubview:label];
    }
    return self;
}

@end
