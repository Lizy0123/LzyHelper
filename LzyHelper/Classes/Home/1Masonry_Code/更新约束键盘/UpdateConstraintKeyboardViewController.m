//
//  UpdateConstraintKeyboardViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/27.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "UpdateConstraintKeyboardViewController.h"

@interface UpdateConstraintKeyboardViewController ()
@property(strong, nonatomic)UITextField *textField;
@end

@implementation UpdateConstraintKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _textField = [UITextField new];
    _textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:_textField];

    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];

    // 注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {

    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    // 修改下边距约束
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardHeight);
    }];

    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {

    // 获得键盘动画时长
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    // 修改为以前的约束（距下边距0）
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];

    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

















@end
