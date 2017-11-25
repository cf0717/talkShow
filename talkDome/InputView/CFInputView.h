//
//  CFInputView.h
//  talkDome
//
//  Created by thbdsz on 2017/11/24.
//  Copyright © 2017年 chaofan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFAITextView.h"

@interface CFInputView : UIView


/** 声音、键盘按钮 */
@property (nonatomic,strong) UIButton *voiceBtn;

/** 按住说话 */
@property (nonatomic,strong) UIButton *holdVoiceBtn;

/** 表情按钮 */
@property (nonatomic,strong) UIButton *emoticonBtn;

/** 更多按钮 */
@property (nonatomic,strong) UIButton *moreBtn;

/** 输入框 */
@property (nonatomic,strong) CFAITextView *aiTextView;

@end
