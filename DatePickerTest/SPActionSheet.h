//
//  SPActionSheet.h
//  Spring3G
//
//  Created by Simon on 14/7/11.
//  Copyright (c) 2014年 SpringAirlines. All rights reserved.
//
enum {
    SPActionSheetLine_1 = 216,
    SPActionSheetLine_2 = 246
};

#import <UIKit/UIKit.h>
@protocol SPActionSheetDelegate;

@interface SPActionSheet : UIView
@property (nonatomic, strong) UIView *backGroundView;

- (id)initWithTitle:(NSString *)title delegate:(id<SPActionSheetDelegate>)delegate showCancel:(BOOL)isShowCancel showConfirm:(BOOL)isShowConfirm;
- (void)showInView:(UIView *)view;
- (void)addContentView:(UIView *)view;
- (void)done;
@end

@protocol SPActionSheetDelegate <NSObject>
- (void)actionSheet:(SPActionSheet *)actionSheet didClickOnButtonIndex:(NSInteger)buttonIndex;
@optional
- (void)didClickOnDestructiveButton;
- (void)didClickOnCancelButton;
@end