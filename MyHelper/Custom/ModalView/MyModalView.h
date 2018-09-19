//
//  MyModalView.h
//  LzyHelper
//
//  Created by Lzy on 2017/10/30.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol MyModalViewDelegate
- (void)myModalViewBtnAction:(id)modalView clickedBtnAtIndex:(NSInteger)btnIndex;
@end

@interface MyModalView : UIView<MyModalViewDelegate>
@property (nonatomic, retain) UIView *parentView;    // The parent view this 'dialog' is attached to
@property (nonatomic, retain) UIView *dialogView;    // Dialog's container view
@property (nonatomic, retain) UIView *containerView; // Container within the dialog (place your ui elements here)

@property (nonatomic, assign) id<MyModalViewDelegate> delegate;
@property (nonatomic, retain) NSArray *buttonTitles;
@property (nonatomic, assign) BOOL useMotionEffects;
@property (nonatomic, assign) BOOL closeOnTouchUpOutside;       // Closes the AlertView when finger is lifted outside the bounds.

@property (copy) void (^buttonAction)(MyModalView *modalView, int buttonIndex) ;

- (id)init;

/*!
 DEPRECATED: Use the [CustomIOSAlertView init] method without passing a parent view.
 */
- (id)initWithParentView: (UIView *)_parentView __attribute__ ((deprecated));

- (void)show;
- (void)close;

- (IBAction)myModalViewBtnAction:(id)sender;
- (void)setButtonAction:(void (^)(MyModalView *modalView, int buttonIndex))buttonAction;

- (void)deviceOrientationDidChange: (NSNotification *)notification;
- (void)dealloc;

@end
