//
//  ViewController.m
//  DatePickerTest
//
//  Created by chang on 15/3/3.
//  Copyright (c) 2015年 chang. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize earliestDataPicker;
@synthesize earliestDataSheet;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 代码添加DatePicker
//    earliestDataPicker=[[UIDatePicker alloc]init];
//    // [earliestDataPicker setDatePickerMode:UIDatePickerModeDate];
//    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    [earliestDataPicker setDate:[formatter dateFromString:@"2014-12-25"]];

  
    // Xib自定义DatePicker
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomPickerView" owner:self options:nil];
    //得到第一个UIView
    UIView *tmpCustomView = [nib objectAtIndex:0];
    if ([tmpCustomView isKindOfClass:[UIDatePicker class]]) {
        earliestDataPicker= (UIDatePicker *)tmpCustomView;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark 日期选择
- (IBAction)selectEarliestTime{
    earliestDataSheet = [[SPActionSheet alloc]initWithTitle: @"最早出发日期" delegate:self showCancel:YES showConfirm:YES];
    earliestDataSheet.tag = 1;
    
    [earliestDataPicker setFrame:CGRectMake(0, 0, earliestDataSheet.frame.size.width, SPActionSheetLine_2)];
    NSDate *earliestDateMin=[NSDate dateWithTimeIntervalSinceNow:3600*24*1];
    earliestDataPicker.minimumDate = earliestDateMin;
    NSDate *earliestDateMax=[NSDate dateWithTimeIntervalSinceNow:3600*24*90];//90tian
    earliestDataPicker.maximumDate = earliestDateMax;
    
    [earliestDataSheet addContentView:earliestDataPicker];
    [earliestDataSheet showInView:self.view];

}


//#pragma mark Sheet点击确定，确定日期
- (void)actionSheet:(SPActionSheet *)actionSheet didClickOnButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1){
//        NSDate *earliestDate=[earliestDataPicker date];
//        if(actionSheet.tag==1){
//            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//            [formatter setDateFormat:@"yyyy-MM-dd"];
//            NSString *earliestDateStr=[formatter stringFromDate:earliestDate];
//        }
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 7;
}


@end



























