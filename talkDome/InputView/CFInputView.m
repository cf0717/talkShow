//
//  CFInputView.m
//  talkDome
//
//  Created by thbdsz on 2017/11/24.
//  Copyright © 2017年 chaofan. All rights reserved.
//

#import "CFInputView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@implementation CFInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContentView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.voiceBtn.frame = CGRectMake(0, self.bounds.size.height-45, 45, 45);
    self.emoticonBtn.frame = CGRectMake(kScreenW-90, self.bounds.size.height-45, 45, 45);
    self.moreBtn.frame = CGRectMake(kScreenW-45, self.bounds.size.height-45, 45, 45);
    
    self.holdVoiceBtn.frame = CGRectMake(50, 5, kScreenW-150, 35);
}

-(void)setupContentView{
    //顶部线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    UIButton *holdVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    holdVoiceBtn.backgroundColor = [UIColor whiteColor];
    holdVoiceBtn.layer.cornerRadius = 5;
    holdVoiceBtn.layer.borderWidth = 0.5;
    holdVoiceBtn.layer.borderColor = [UIColor grayColor].CGColor;
    
    holdVoiceBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [holdVoiceBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [holdVoiceBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
    [holdVoiceBtn setTitle:@"松开 结束" forState:UIControlStateDisabled];
    [self addSubview:holdVoiceBtn];
    holdVoiceBtn.hidden = YES;
    self.holdVoiceBtn = holdVoiceBtn;
    
    //声音按钮
    UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceBtn setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [voiceBtn setImage:[UIImage imageNamed:@"keyBorad"] forState:UIControlStateSelected];
    [self addSubview:voiceBtn];
    self.voiceBtn = voiceBtn;
    
    //表情按钮
    UIButton *emoticonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [emoticonBtn setImage:[UIImage imageNamed:@"emoticon"] forState:UIControlStateNormal];
    [self addSubview:emoticonBtn];
    self.emoticonBtn = emoticonBtn;
    
    //更多按钮
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    //输入框
    CFAITextView *aiTextView = [[CFAITextView alloc] init];
    aiTextView.frame = CGRectMake(50, 5, kScreenW-150, 35);
    aiTextView.font = [UIFont systemFontOfSize:15];
    aiTextView.cornerRadius = 5;
    aiTextView.layer.borderWidth = 0.5;
    aiTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    aiTextView.isAutoH = YES;
    aiTextView.maxNumberOfLines = 4;
    aiTextView.placeholder = @"请输入内容";
    [self addSubview:aiTextView];
    self.aiTextView = aiTextView;
    
    //一进来赋值一个高度
    self.aiTextView.currentH = 35;
}

@end
