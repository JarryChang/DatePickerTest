//
//  ViewController.h
//  DatePickerTest
//
//  Created by chang on 15/3/3.
//  Copyright (c) 2015年 chang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPActionSheet.h"

@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,SPActionSheetDelegate>

@property (nonatomic,strong) UIDatePicker *earliestDataPicker;//最早出发时间picker
@property (nonatomic,strong) SPActionSheet *earliestDataSheet;//最早出发时间sheet

- (IBAction)selectEarliestTime;
@end

