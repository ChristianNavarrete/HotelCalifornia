//
//  DateViewController.m
//  MotelHotelHolidayInn
//
//  Created by HoodsDream on 12/1/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

#import "DateViewController.h"
#import "AvailabilityViewController.h"

@interface DateViewController ()

@property (strong, nonatomic) UIDatePicker *startPicker;
@property (strong, nonatomic) UIDatePicker *endPicker;

@end

@implementation DateViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupDateViewController];
    [self setupDatePickers];
}


-(void) setupDateViewController {
    
    [self.navigationItem setTitle:@"Select End Date"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)]];

    
}



-(void) setupDatePickers {
    
    
    self.startPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 90.0, CGRectGetWidth(self.view.frame), 200.0)];
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.startPicker];
    
    self.endPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 300.0, CGRectGetWidth(self.view.frame), 200.0)];
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:self.endPicker];
    
    
}

- (void)doneButtonPressed:(UIBarButtonItem *)sender{
    
    NSDate *startDate = [self.startPicker date];
    NSDate *endDate = [self.endPicker date];
    
    if ([startDate timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Hmm..." message:@"Please make sure end date is in the future." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.endPicker.date = [NSDate date];
        }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    AvailabilityViewController *availabilityViewController = [[AvailabilityViewController alloc]init];
    
    availabilityViewController.startDate = startDate;
    availabilityViewController.endDate = endDate;

    
    [self.navigationController pushViewController:availabilityViewController animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
