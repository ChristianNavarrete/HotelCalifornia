//
//  HotelsViewController.m
//  MotelHotelHolidayInn
//
//  Created by HoodsDream on 11/30/15.
//  Copyright © 2015 HoodsDream. All rights reserved.
//

#import "HotelsViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "RoomsViewController.h"



@interface HotelsViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedController;


@end

@implementation HotelsViewController


- (NSFetchedResultsController *) fetchedController {

    if (!_fetchedController) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:true];
        request.sortDescriptors = @[sortDescriptor];
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];

        _fetchedController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        _fetchedController.delegate = self;
        
        NSError *error;
        [_fetchedController performFetch:&error];
        
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully fetched...");
        }
    }

    return _fetchedController;

}

- (NSArray *)datasource {
    if (!_datasource) {
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = delegate.managedObjectContext;
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        
        NSError *fetchError;
        
        _datasource = [context executeFetchRequest:request error:&fetchError];
        
        if (fetchError) {
            NSLog(@"Error fetching from Core Data.");
        }

        
    }
    
    return _datasource;
}




- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
    [self setupHotelsViewController];
}

- (void)setupHotelsViewController {
    
}

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    leading.active = YES;
    top.active = YES;
    trailing.active = YES;
    bottom.active = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView delegate methods

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.datasource count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    
//    Hotel *hotel = self.datasource[indexPath.row];
//    cell.textLabel.text = hotel.name;
//    
//    return cell;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIImage *headerImage = [UIImage imageNamed:@"hotel"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:headerImage];
    
    imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 150.0);
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    return imageView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Hotel *hotel = self.datasource[indexPath.row];
    RoomsViewController *roomsViewController = [[RoomsViewController alloc]init];
    roomsViewController.hotel = hotel;
    
    [self.navigationController pushViewController:roomsViewController animated:YES];
    
}


#pragma mark-fetched controller 


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ([[self.fetchedController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    Hotel *managedObject = [self.fetchedController objectAtIndexPath:indexPath];
    // Configure the cell with data from the managed object.
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@", managedObject.name];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[self.fetchedController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedController sections] objectAtIndex:section];
        return [sectionInfo name];
    } else
        return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.fetchedController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.fetchedController sectionForSectionIndexTitle:title atIndex:index];
}




@end
