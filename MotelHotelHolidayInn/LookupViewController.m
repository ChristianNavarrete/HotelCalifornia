//
//  LookupViewController.m
//  MotelHotelHolidayInn
//
//  Created by HoodsDream on 12/3/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

#import "LookupViewController.h"
#import "Reservation.h"
#import "Hotel.h"
#import "Guest.h"
#import "Room.h"
#import "AppDelegate.h"

@interface LookupViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) NSFetchedResultsController *fetchedController;

@end

@implementation LookupViewController



- (void)loadView {
    
    [super loadView];
    [self.view setBackgroundColor:UIColor.whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
    [self setupLookViewController];
}


- (void)setDatasource:(NSArray *)datasource {
    
    _datasource = datasource;
    
    [self.tableView reloadData];
    
}

- (void) setupTableView {

    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    //Create constraints
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    //activating constraints
    leading.active = YES;
    top.active = YES;
    trailing.active = YES;
    bottom.active = YES;
    
}

-(void) setupLookViewController {
    [self.navigationController setTitle:@"Search"];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Reservation *reservation = self.datasource[indexPath.row];
    
//MARK: May be an issue with core data here.
    cell.textLabel.text = [NSString stringWithFormat:@"Name: %@, Hotel: %@", reservation.guest.name, reservation.room.hotel.name];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 44.0)];
    searchBar.delegate = self;
    return  searchBar;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSString *searchText = searchBar.text;
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"guest.name == %@", searchText];
    
    NSError *error;
    NSArray *results = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    
    
    if (!error) {
        self.datasource = results;
    } else {
        NSLog(@"something bad happened");
    }
    
}

#pragma mark - NSFetchResultsController 


@end
