//
//  MotelHotelHolidayInnTests.m
//  MotelHotelHolidayInnTests
//
//  Created by HoodsDream on 12/3/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface MotelHotelHolidayInnTests : XCTestCase


@end

@implementation MotelHotelHolidayInnTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testSomething {
    
    int number = 3;
    
    XCTAssertTrue(number == 3);
    
}


- (void) testCoreDataSave {
    
   AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    request.resultType = NSCountResultType;
    
    NSError *error;
    NSArray *result = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    NSNumber *count = [result firstObject];
    
    XCTAssertNil(error, @"Error should be nil.");
    XCTAssertNotNil(result, @"Result array should NOT be nil.");
    XCTAssertTrue([count intValue] > 0, @"Number of objects in the database after seeding should be greater that 0.");
    
}

- (void) testContextOnMainQ {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    XCTAssertTrue(delegate.managedObjectContext.concurrencyType == NSMainQueueConcurrencyType,@"managed object context should be created on main Q");
    
    
}


- (void) testContextCreation {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    XCTAssertNotNil(delegate.managedObjectContext, @"Context should only not be nil.");
    
}



@end
