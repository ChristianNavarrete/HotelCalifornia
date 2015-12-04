//
//  BookViewController.h
//  MotelHotelHolidayInn
//
//  Created by HoodsDream on 12/1/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"


@interface BookViewController : UIViewController

@property (strong, nonatomic) Room *room;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end
