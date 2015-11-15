//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Peter Molnar on 14/03/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"


@interface BNRItemsViewController ()
//@property (nonatomic, strong) IBOutlet UIView *headerView;
@end

@implementation BNRItemsViewController



-(instancetype)init{
    // Call the superclass's designated initalizer
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        // Create a new bar button item that
        // will send addNewItem to this view controller
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addNewItem:)];
        // Set this bar button item as the right item in the navitem
        navItem.rightBarButtonItem = bbi;
        
        // Automagically calling setEditing:animated, no need for a target-action pair
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    
    return [self init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // To fire up the automatic cell reuse mechanism
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
//    UIView *header = self.headerView;
//    [self.tableView setTableHeaderView:header];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[BNRItemStore sharedStore] allItems] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    // Create an instance of UITableViewCell, with default appereance
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault                                             reuseIdentifier:@"UITableViewCell"];
    
//    Get a new or recycled cell
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                    forIndexPath:indexPath];
    
    // Set te text text on the cell with the escription of the item
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    return cell;
}

#pragma mark - IBOUtlet

- (IBAction)addNewItem:(id)sender
{
    // Make a new indexpath for tge 0th section, last row
//    NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
// Add an item before
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // Insert this new row into the table
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}


//- (IBAction)toggleEditingMode:(id)sender
//{
//    if (self.isEditing) {
//        //Change the text of the button
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        
//        //Turn off editing mode
//        [self setEditing:NO animated:YES];
//    } else {
//        //Change the text button
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        
//        // enter Editing mode
//        [self setEditing:YES animated:YES];
//    }
//}
//
//-(UIView *) headerView
//{
//    //if you have not loaded the headerView yet...
//    if (!_headerView) {
//        // Load HeaderView.xib
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
//                                      owner:self
//                                    options:nil];
//    }
//    return _headerView;
//}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If the tableview is asking ti commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items =[[BNRItemStore sharedStore]allItems];
        BNRItem *item = items[indexPath.row];
        
        [[BNRItemStore sharedStore] removeItem:item];
        
        //Also remove from the table view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark - Editing items

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    
    BNRItem *item = items[indexPath.row];
    
    detailViewController.item = item;
    //Push onto the top of the navigation controller stack
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}


@end
