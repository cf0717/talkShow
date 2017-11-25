//
//  ViewController.m
//  talkDome
//
//  Created by thbdsz on 2017/11/24.
//  Copyright © 2017年 chaofan. All rights reserved.
//

#import "ViewController.h"
#import "CFInputView.h"
#import "CFEmoticonView.h"
#import "CFMoreView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

//当前的类型
typedef enum : NSUInteger {
    noneType,
    keyBoradType,
    voiceBoradType,
    emtoiconType,
    moreType,
} ShowType;

@interface ViewController ()

@property (nonatomic,strong) CFInputView *inputView;
@property (nonatomic,assign) NSInteger keyboradY;//记录键盘的Y值
@property (nonatomic,assign) ShowType showType;
@property (nonatomic,strong) CFEmoticonView *emoticonView;
@property (nonatomic,strong) CFMoreView *moreView;

@end

@implementation ViewController

#pragma mark - 更多键盘
-(CFMoreView *)moreView{
    if (!_moreView) {
        _moreView = [[CFMoreView alloc] initWithFrame:CGRectMake( 0, kScreenH, kScreenW, 200)];
        _moreView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_moreView];
    }
    return _moreView;
}

-(void)moreViewShow{
    [UIView animateWithDuration:0.25 animations:^{
        //重新布局
        CGRect bottomViewFrame = self.inputView.frame;
        bottomViewFrame.size.height = self.inputView.aiTextView.currentH+10;
        bottomViewFrame.origin.y = self.keyboradY-bottomViewFrame.size.height;
        self.inputView.frame = bottomViewFrame;
        
        self.moreView.frame = CGRectMake(0, kScreenH-200, kScreenW, 200);
    }];
}

-(void)moreViewHide{
    [UIView animateWithDuration:0.25 animations:^{
        //重新布局
        CGRect bottomViewFrame = self.inputView.frame;
        bottomViewFrame.size.height = self.inputView.aiTextView.currentH+10;
        bottomViewFrame.origin.y = self.keyboradY-bottomViewFrame.size.height;
        self.inputView.frame = bottomViewFrame;
        
        self.moreView.frame = CGRectMake(0, kScreenH, kScreenW, 200);
    }];
}

#pragma mark - 表情键盘
-(CFEmoticonView *)emoticonView{
    if (!_emoticonView) {
        _emoticonView = [[CFEmoticonView alloc] initWithFrame:CGRectMake( 0, kScreenH, kScreenW, 200)];
        _emoticonView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_emoticonView];
    }
    return _emoticonView;
}

-(void)emoticonViewShow{
    [UIView animateWithDuration:0.25 animations:^{
        //重新布局
        CGRect bottomViewFrame = self.inputView.frame;
        bottomViewFrame.size.height = self.inputView.aiTextView.currentH+10;
        bottomViewFrame.origin.y = self.keyboradY-bottomViewFrame.size.height;
        self.inputView.frame = bottomViewFrame;
        
        self.emoticonView.frame = CGRectMake(0, kScreenH-200, kScreenW, 200);
    }];
}

-(void)emoticonViewHide{
    [UIView animateWithDuration:0.25 animations:^{
        //重新布局
        CGRect bottomViewFrame = self.inputView.frame;
        bottomViewFrame.size.height = self.inputView.aiTextView.currentH+10;
        bottomViewFrame.origin.y = self.keyboradY-bottomViewFrame.size.height;
        self.inputView.frame = bottomViewFrame;
        
        self.emoticonView.frame = CGRectMake(0, kScreenH, kScreenW, 200);
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.keyboradY = kScreenH;
    self.showType = noneType;
    
    [self initInputView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillShowKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillHideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.keyboradY = kScreenH;
    self.showType = noneType;
    
    [self.view endEditing:YES];
    [self emoticonViewHide];
    [self moreViewHide];
}


/** 输入框 */
-(void)initInputView{
    self.inputView = [[CFInputView alloc] initWithFrame:CGRectMake(0, kScreenH-50, kScreenW, 45)];
    self.inputView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    [self.view addSubview:self.inputView];
    
    [self.inputView.voiceBtn addTarget:self action:@selector(voiceBtnClike:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputView.holdVoiceBtn addTarget:self action:@selector(holdVoiceBtnClike:) forControlEvents:UIControlEventTouchDragInside];
    [self.inputView.holdVoiceBtn addTarget:self action:@selector(holdVoiceBtnCancel:) forControlEvents:UIControlEventTouchDragOutside];
    [self.inputView.emoticonBtn addTarget:self action:@selector(emoticonBtnClike:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputView.moreBtn addTarget:self action:@selector(moreBtnClike:) forControlEvents:UIControlEventTouchUpInside];
    
    //要写在VC中
    __weak typeof(self) wSelf = self;
    [self.inputView.aiTextView setTextChangedBlock:^(NSString *text, CGFloat textHeight) {
        //重新布局
        CGRect bottomViewFrame = wSelf.inputView.frame;
        bottomViewFrame.size.height = textHeight+10;
        bottomViewFrame.origin.y = wSelf.keyboradY-bottomViewFrame.size.height;
        wSelf.inputView.frame = bottomViewFrame;
    }];
}

#pragma mark - 键盘通知事件
/** 键盘显示 */
-(void)handleWillShowKeyboard:(NSNotification *)notification{
    //其他要隐藏
    [self emoticonViewHide];
    [self moreViewHide];
    
    //拿到键盘的Y值
    CGRect keyboardRect = [(notification.userInfo)[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboradY = keyboardRect.origin.y;
    self.showType = keyBoradType;
    //键盘弹出
    [UIView animateWithDuration:0.25 animations:^{
        [self.inputView setFrame:CGRectMake(0, self.keyboradY-self.inputView.bounds.size.height, kScreenW, self.inputView.bounds.size.height)];
    }];
}

/** 键盘隐藏 */
-(void)handleWillHideKeyboard:(NSNotification *)notification{
    //拿到键盘的Y值
    CGRect keyboardRect = [(notification.userInfo)[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboradY = keyboardRect.origin.y;
    self.showType = noneType;
    
    //键盘隐藏
    [UIView animateWithDuration:0.25 animations:^{
        [self.inputView setFrame:CGRectMake(0, self.keyboradY-self.inputView.bounds.size.height, kScreenW, self.inputView.bounds.size.height)];
    }];
}

#pragma mark - voiceBtn点击事件
-(void)voiceBtnClike:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {//语音
        //1.全部消失
        [self.view endEditing:YES];
        [self emoticonViewHide];
        [self moreViewHide];
        
        //2.确定键盘Y值
        self.keyboradY = kScreenH;
        self.showType = voiceBoradType;
        
        //3.按钮状态更改
        self.inputView.holdVoiceBtn.hidden = NO;
        self.inputView.aiTextView.hidden = YES;
        
        //4.重新布局
        self.inputView.frame = CGRectMake(0, self.keyboradY-45, kScreenW, 45);
        
    }else{//键盘
        //1.隐藏其他
        [self emoticonViewHide];
        [self moreViewHide];
        
        //2.弹出键盘
        [self.inputView.aiTextView becomeFirstResponder];
        
        //3.按钮状态更改
        self.inputView.holdVoiceBtn.hidden = YES;
        self.inputView.aiTextView.hidden = NO;
        
        //4.重新布局
        CGRect bottomViewFrame = self.inputView.frame;
        bottomViewFrame.size.height = self.inputView.aiTextView.currentH+10;
        bottomViewFrame.origin.y = self.keyboradY-bottomViewFrame.size.height;
        self.inputView.frame = bottomViewFrame;
    }
}

#pragma mark - 按住说话
-(void)holdVoiceBtnClike:(UIButton *)btn{
    NSLog(@"按住在说话");
}

-(void)holdVoiceBtnCancel:(UIButton *)btn{
    NSLog(@"离开了");
}

#pragma mark - 表情键盘
-(void)emoticonBtnClike:(UIButton *)btn{
    //判断是键盘还是表情 目的是为了防止重复点击
    if (self.showType == emtoiconType) {
        //弹出键盘
        [self.inputView.aiTextView becomeFirstResponder];
        
    }else{
        //1.VoiceBtn要是键盘
        self.inputView.voiceBtn.selected = YES;
        [self voiceBtnClike:self.inputView.voiceBtn];
        //2.保证其他的消失
        [self.view endEditing:YES];
        [self moreViewHide];
        
        //3.确定键盘Y值
        self.keyboradY = kScreenH-200;
        self.showType = emtoiconType;
        
        //4.展示键盘
        [self emoticonViewShow];
    }
}


#pragma mark - 更多功能
-(void)moreBtnClike:(UIButton *)btn{
    //判断是键盘还是表情 目的是为了防止重复点击
    if (self.showType == moreType) {
        //弹出键盘
        [self.inputView.aiTextView becomeFirstResponder];
        
    }else{
        //1.VoiceBtn要是键盘
        self.inputView.voiceBtn.selected = YES;
        [self voiceBtnClike:self.inputView.voiceBtn];
        //2.保证其他的消失
        [self.view endEditing:YES];
        [self emoticonViewHide];
        
        //3.确定键盘Y值
        self.keyboradY = kScreenH-200;
        self.showType = moreType;
        
        //4.展示键盘
        [self moreViewShow];
    }
}

@end
