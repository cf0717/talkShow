//
//  CFAITextView.h
//  CFTextView
//
//  Created by thbdsz on 2017/11/22.
//  Copyright © 2017年 chaofan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CF_textHeightChangedBlock)(NSString *text,CGFloat textHeight);

@interface CFAITextView : UITextView

/**
 是否自适应高度 
 */
@property (nonatomic,assign) BOOL isAutoH;

/**
 占位文字
 */
@property (nonatomic,copy) NSString *placeholder;

/**
 占位文字颜色
 */
@property (nonatomic,strong) UIColor *placeholderColor;

/**
 设置最大行数 改变字号大小要写在这个前面
 */
@property (nonatomic,assign) NSInteger maxNumberOfLines;

/**
 限制输入长度
 */
@property (nonatomic,assign) NSInteger maxLength;

/**
 设置倒圆角
 */
@property (nonatomic,assign) NSInteger cornerRadius;


/**
 当前的高度
 */
@property (nonatomic,assign) NSInteger currentH;

/**
 *  文字高度改变block 文字高度改变会自动调用
 *  block参数(text) 文字内容
 *  block参数(textHeight) 文字高度
 */
@property (nonatomic, strong) CF_textHeightChangedBlock textChangedBlock;

@end
