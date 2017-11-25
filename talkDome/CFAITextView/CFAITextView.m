//
//  CFAITextView.m
//  CFTextView
//
//  Created by thbdsz on 2017/11/22.
//  Copyright © 2017年 chaofan. All rights reserved.
//

#import "CFAITextView.h"

@interface CFAITextView()

@property (nonatomic,assign) NSInteger maxTextH;//最大高度
@property (nonatomic,strong) UITextView *placeholderTextView;//UITextView的好处 字体重叠显示，方便快捷，解决占位符问题.

@end

@implementation CFAITextView

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupContentView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContentView];
    }
    return self;
}

#pragma mark - 懒加载控件
-(UITextView *)placeholderTextView{
    if (!_placeholderTextView) {
        _placeholderTextView = [[UITextView alloc] initWithFrame:self.bounds];
        //特殊设置
        _placeholderTextView.scrollEnabled = NO;
        _placeholderTextView.showsHorizontalScrollIndicator = NO;
        _placeholderTextView.showsVerticalScrollIndicator = NO;
        _placeholderTextView.userInteractionEnabled = NO;
        _placeholderTextView.font =  self.font;
        _placeholderTextView.textColor = [UIColor lightGrayColor];
        _placeholderTextView.backgroundColor = [UIColor clearColor];
        [self addSubview:_placeholderTextView];
    }
    return _placeholderTextView;
}

#pragma mark - 设置内容
-(void)setupContentView{
    //UITextView 继承自 UIScrollView
    self.scrollsToTop = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChange:) name:UITextViewTextDidChangeNotification object:self];
}

-(void)textViewChange:(NSNotification *)notification{
//    UITextView *textView = notification.object;
    //占位文字
    self.placeholderTextView.hidden = self.text.length > 0;
    //限制文字
    if (self.maxLength != 0) {
        if (self.text.length > self.maxLength) {
            self.text = [self.text substringToIndex:self.maxLength];
        }        
    }
    
    if (!self.isAutoH) return;//不用自适应高度
    
    //计算高度
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (height > _maxTextH) {//大于最大高度
        height = _maxTextH;
        self.scrollEnabled = YES;
    }else{//不大于
        self.scrollEnabled = NO;
    }
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
    self.currentH = self.bounds.size.height;
    if (_textChangedBlock){
        _textChangedBlock(self.text,height);
        self.placeholderTextView.frame = self.bounds;
    }
}

#pragma mark - 限制高度设置
-(void)setMaxNumberOfLines:(NSInteger)maxNumberOfLines{
    _maxNumberOfLines = maxNumberOfLines;
    //计算最大高度 = 每行高度 * 总行数 + 文字上间距 + 文字下间距
    _maxTextH = ceil(self.font.lineHeight * _maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
}

-(void)setCornerRadius:(NSInteger)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
}

#pragma mark - 设置占位文字
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderTextView.text = _placeholder;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderTextView.textColor = _placeholderColor;
}

#pragma mark - 是否滚动
-(void)setIsNotAutoH:(BOOL)isNotAutoH{
    _isAutoH = isNotAutoH;
    self.scrollEnabled = !_isAutoH;
}

@end
