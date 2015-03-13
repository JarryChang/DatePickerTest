//
//  SPActionSheet.m
//  Spring3G
//
//  Created by Simon on 14/7/11.
//  Copyright (c) 2014年 SpringAirlines. All rights reserved.
//

#import "SPActionSheet.h"
#import "ImageUtil.h"

#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor clearColor]
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]

#define HEADER_VIEW_HEIGHT                      44
#define BUTTON_INTERVAL_HEIGHT                  0
#define BUTTON_HEIGHT                           44
#define BUTTON_INTERVAL_WIDTH                   0
#define BUTTON_WIDTH                            80
#define BUTTONTITLE_FONT                        [UIFont fontWithName:@"Arial" size:18]


#define TITLE_INTERVAL_HEIGHT                   0
#define TITLE_INTERVAL_WIDTH                    0
#define TITLE_FONT                              [UIFont fontWithName:@"Arial" size:18]

#define ANIMATE_DURATION                        0.25f

@interface SPActionSheet ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *bodyView;
@property (nonatomic) NSInteger postionIndexNumber;
@property (nonatomic) BOOL isHadTitle;
@property (nonatomic) BOOL isHadDestructionButton;
@property (nonatomic) BOOL isHadCancelButton;
@property (nonatomic) CGFloat spActionSheetHeight;
@property (nonatomic, weak) id<SPActionSheetDelegate>delegate;

@end

@implementation SPActionSheet

#pragma mark - Public method
- (id)initWithTitle:(NSString *)title delegate:(id<SPActionSheetDelegate>)delegate showCancel:(BOOL)isShowCancel showConfirm:(BOOL)isShowConfirm
{
    self = [super init];
    if (self) {
        
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        
        if (delegate) {
            self.delegate = delegate;
        }
        
        [self createHeaderViewWithTitle:title showCancel:isShowCancel showConfirm:isShowConfirm];
    }
    return self;
}

- (void)showInView:(UIView *)view
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.spActionSheetHeight, [UIScreen mainScreen].bounds.size.width, self.spActionSheetHeight)];
    } completion:^(BOOL finished) {
    }];
}

- (void)addContentView:(UIView *)view {
    if (!view) {
        return;
    }
    if (!self.bodyView) {
        float offsetY = 0;
        if (self.headerView) {
            offsetY = self.headerView.frame.origin.y + self.headerView.frame.size.height;
        }
        self.bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, self.backGroundView.bounds.size.width, 0)];
        self.bodyView.backgroundColor = [UIColor whiteColor];
        [self.backGroundView addSubview:self.bodyView];
    }
    [self.bodyView addSubview:view];
    CGRect bodyFrame = self.bodyView.frame;
    bodyFrame.size.height = view.frame.size.height + view.frame.origin.y;
    self.bodyView.frame = bodyFrame;
    
    self.spActionSheetHeight = self.bodyView.frame.origin.y + self.bodyView.frame.size.height;
    [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.spActionSheetHeight)];
}
#pragma mark - CreatButtonAndTitle method
- (void)createHeaderViewWithTitle:(NSString *)title showCancel:(BOOL)isShowCancel showConfirm:(BOOL)isShowConfirm {
    //初始化
    self.isHadTitle = NO;
    self.isHadDestructionButton = NO;
    self.isHadCancelButton = NO;
    
    //初始化LXACtionView的高度为0
    self.spActionSheetHeight = 0;
    
    //初始化IndexNumber为0;
    self.postionIndexNumber = 0;
    
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backGroundView.backgroundColor = ACTIONSHEET_BACKGROUNDCOLOR;
    
    [self addSubview:self.backGroundView];
    //生成头部视图
    if (title.length > 0 || isShowCancel || isShowConfirm) {
        //设置背景图片
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HEADER_VIEW_HEIGHT)];
        self.headerView.backgroundColor = [UIColor clearColor];

        self.headerView.backgroundColor=[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0];

        
        [self.backGroundView addSubview:self.headerView];
        self.spActionSheetHeight = self.spActionSheetHeight + self.headerView.bounds.size.height;
        
        if (title.length > 0) {
            self.isHadTitle = YES;
            UILabel *titleLabel = [self creatTitleLabelWith:title andSuperview:self.headerView];
            [self.headerView addSubview:titleLabel];
        }
        
        //显示取消按钮
        if (isShowCancel) {
            self.isHadCancelButton = YES;
            
            UIButton *cancelButton = [self creatCancelButtonWith:@"取消"];
            
            cancelButton.tag = self.postionIndexNumber;
            [cancelButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.headerView addSubview:cancelButton];
            
            self.postionIndexNumber++;
        }
    }
    
    
    if (isShowConfirm) {
        self.isHadDestructionButton = YES;
        UIButton *destructiveButton = [self creatDestructiveButtonWith:@"確定" andSuperview:self.headerView];
        destructiveButton.tag = self.postionIndexNumber;
        [destructiveButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:destructiveButton];
        
        self.postionIndexNumber++;
    }
    [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.spActionSheetHeight)];
}

- (UILabel *)creatTitleLabelWith:(NSString *)title andSuperview:(UIView *)tempSuperView
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH + BUTTON_WIDTH + TITLE_INTERVAL_WIDTH, TITLE_INTERVAL_HEIGHT, tempSuperView.bounds.size.width -  2 * (BUTTON_INTERVAL_WIDTH + BUTTON_WIDTH + TITLE_INTERVAL_WIDTH), tempSuperView.bounds.size.height -  2 * TITLE_INTERVAL_HEIGHT)];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = TITLE_FONT;
    titlelabel.minimumScaleFactor = 10.0 / 18.0;

    titlelabel.adjustsFontSizeToFitWidth = YES;
    titlelabel.text = title;
    titlelabel.textColor = [UIColor colorWithRed:0.0/255.0 green:108.0/255.0 blue:216.0/255.0 alpha:1.0];

    return titlelabel;
}

- (UIButton *)creatDestructiveButtonWith:(NSString *)destructiveButtonTitle andSuperview:(UIView *)tempSuperView
{
    UIButton *destructiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    destructiveButton.frame = CGRectMake(tempSuperView.bounds.size.width -  BUTTON_INTERVAL_WIDTH - BUTTON_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);
    [destructiveButton setTitle:destructiveButtonTitle forState:UIControlStateNormal];
    destructiveButton.titleLabel.font = BUTTONTITLE_FONT;
    
    [destructiveButton setTitleColor:[UIColor colorWithRed:0.0/255.0 green:108.0/255.0 blue:216.0/255.0 alpha:1.0] forState:UIControlStateNormal];
   
    return destructiveButton;
}

- (UIButton *)creatCancelButtonWith:(NSString *)cancelButtonTitle
{
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = BUTTONTITLE_FONT;
   
    [cancelButton setTitleColor:[UIColor colorWithRed:0.0/255.0 green:108.0/255.0 blue:216.0/255.0 alpha:1.0] forState:UIControlStateNormal];
 
    return cancelButton;
}

- (void)clickOnButtonWith:(UIButton *)button
{
    if (self.isHadDestructionButton == YES) {
        if (self.delegate) {
            if (button.tag == 1) {
                if ([self.delegate respondsToSelector:@selector(didClickOnDestructiveButton)] == YES){
                    [self.delegate didClickOnDestructiveButton];
                }
            }
        }
    }
    
    if (self.isHadCancelButton == YES) {
        if (self.delegate) {
            if (button.tag == 0) {
                if ([self.delegate respondsToSelector:@selector(didClickOnCancelButton)] == YES) {
                    [self.delegate didClickOnCancelButton];
                }
            }
        }
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(actionSheet:didClickOnButtonIndex:)] == YES) {
            [self.delegate actionSheet:self didClickOnButtonIndex:(NSInteger)button.tag];
        }
    }
    
    [self hideMe];
}

- (void)hideMe
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)done {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(actionSheet:didClickOnButtonIndex:)] == YES) {
            [self.delegate actionSheet:self didClickOnButtonIndex:1];
        }
    }
    [self hideMe];
}
@end
