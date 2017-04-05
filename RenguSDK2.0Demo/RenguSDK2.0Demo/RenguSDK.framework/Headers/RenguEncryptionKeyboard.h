//
//  RenguEncryptionKeyboard.h
//  cpsPay
//
//  Created by hymac on 15/12/26.
//  Copyright © 2015年 rengukeji. All rights reserved.
//

#import <UIKit/UIKit.h>


/* 输入法类型 */
typedef NS_ENUM(NSInteger, CurrentMethodType){
    CurrentMethodTypeEnLower,         // 小写英文
    CurrentMethodTypeEnCapital,       // 大写英文
    CurrentMethodTypeNumberAndSign,   // 数字和符号
    CurrentMethodTypeSign             // 符号
};


/* 键盘初始化时输入法类型 */
typedef NS_ENUM(NSInteger, KeyboardInitMethodType){
    KeyboardInitMethodTypeEnLower,          // 小写英文
    KeyboardInitMethodTypeNumberAndSign,    // 数字和符号
};

typedef void (^MethodChangedBlock)(CurrentMethodType type);

@class RenguEncryptionKeyboard;

/* 人谷安全键盘delegate */
@protocol RenguEncryptionKeyboardDelegate <NSObject>

@optional
/** 点击内容的委托方法 */
- (void)keyboardDidClickedContent:(RenguEncryptionKeyboard *)keyboard content:(NSString *)content;
/** 点击删除的委托方法 */
- (void)keyboardDidClickedDelete:(RenguEncryptionKeyboard *)keyboard;
/** 点击return的委托方法 */
- (void)keyboardDidClickedReturn:(RenguEncryptionKeyboard *)keyboard encryptedContent:(NSString *)content;
/** 键盘隐藏时的委托方法 */
- (void)keyboardDidHidden:(RenguEncryptionKeyboard *)keyboard encryptedContent:(NSString *)content;

@end

@interface RenguEncryptionKeyboard : UIView

/* 设置输入最大字符数 */
@property (assign,nonatomic)NSInteger maxCharacters;
/* 当前输入法状态 */
@property (assign,nonatomic,readonly)CurrentMethodType currentMethod;
/* 本地der证书名 */
@property (nonatomic, copy)NSString *certificateName;

@property (nonatomic, weak) id<RenguEncryptionKeyboardDelegate>delegate;

/* 监听输入法改变的回调 */
- (void)setMethodChangeBlock:(MethodChangedBlock)block;


// 初始化密码键盘
- (instancetype)initWithMethodType:(KeyboardInitMethodType)type textField:(UITextField *)textField;

- (instancetype)initWithMethodType:(KeyboardInitMethodType)type textView:(UITextView *)textView;

@end
