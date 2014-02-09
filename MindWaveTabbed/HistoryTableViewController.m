//
//  HistoryTableViewController.m
//  MindWaveTabbed
//
//  Created by tester on 2/7/14.
//  Copyright (c) 2014 Media. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "EntryDetailViewController.h"
#import "BrainDataHistoryDocument.h"
#import "BrainDataEntry.h"

@interface HistoryTableViewController ()

@property (strong, nonatomic) id documentBeganObserver;
@property (strong, nonatomic) id documentInsertedObserver;
@property (strong, nonatomic) id documentDeletedObserver;
@property (strong, nonatomic) id documentChangeCompleteObserver;

@end

@implementation HistoryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [self removeNotifications];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// TODO: Delete This After Testing!
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@ appeared, document = %@",
          [self class], self.brainDataHistoryDocument);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return (NSInteger)self.brainDataHistoryDocument.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"History Cell";
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                    forIndexPath:indexPath];
    
    BrainDataEntry *entry = [self.brainDataHistoryDocument
                          entryAtIndexPath:indexPath];
    
    cell.textLabel.text = [entry description];
    
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Accessor Methods
- (void)setBrainDataHistoryDocument:(BrainDataHistoryDocument *)brainDataHistoryDocument
{
    if (_brainDataHistoryDocument)
    {
        [self removeNotifications];
    }
    
    _brainDataHistoryDocument = brainDataHistoryDocument;
    [self setupNotifications];
}


 #pragma mark - Navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
    if ([segue.identifier isEqualToString:@"Entry Detail Segue"])
    {
    EntryDetailViewController *controller =
    segue.destinationViewController;
 
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    controller.entry =
    [self.brainDataHistoryDocument entryAtIndexPath:indexPath];
    }
 }


- (void)setupNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    BrainDataHistoryDocument *doc = self.brainDataHistoryDocument;
    __weak HistoryTableViewController *_self = self;
    
    self.documentBeganObserver =
    [center
     addObserverForName:BrainDataHistoryDocumentBeginChangesNotification
     object:doc
     queue:mainQueue
     usingBlock:^(NSNotification *note) {
         if ([_self isViewLoaded])
         {
             [_self.tableView beginUpdates];
         }
     }];
    
    self.documentInsertedObserver =
    [center
     addObserverForName:BrainDataHistoryDocumentInsertBrainDataEntryNotification
     object:doc
     queue:mainQueue
     usingBlock:^(NSNotification *note) {
         NSIndexPath *indexPath =
         note.userInfo[BrainDataHistoryDocumentNotificationIndexPathKey];
         NSAssert(indexPath != nil,
                  @"We should have an index path in the "
                  @"notification user info dictionary");
        
         if ([_self isViewLoaded])
         {
             [_self.tableView
              insertRowsAtIndexPaths:@[indexPath]
              withRowAnimation:UITableViewRowAnimationAutomatic];
         }
     }];
    
    self.documentDeletedObserver =
    [center
     addObserverForName:BrainDataHistoryDocumentDeleteBrainDataEntryNotification
     object:doc
     queue:mainQueue
     usingBlock:^(NSNotification *note) {
         NSIndexPath *indexPath =
         note.userInfo[BrainDataHistoryDocumentNotificationIndexPathKey];
         NSAssert(indexPath != nil,
                  @"We should have an index path in the "
                  @"notification's user info dictionary");
         
         if ([_self isViewLoaded])
         {
             [_self.tableView
              deleteRowsAtIndexPaths:@[indexPath]
              withRowAnimation:UITableViewRowAnimationAutomatic];
         }
     }];
    
    self.documentChangeCompleteObserver =
    [center
     addObserverForName:BrainDataHistoryDocumentChangesCompleteNotification
     object:doc
     queue:mainQueue
     usingBlock:^(NSNotification *note) {
         [_self.tableView endUpdates];
     }];
                  
}

- (void)removeNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    if (self.documentBeganObserver)
    {
        [center removeObserver:self.documentBeganObserver];
        self.documentBeganObserver = nil;
    }
    
    if (self.documentInsertedObserver)
    {
        [center removeObserver:self.documentInsertedObserver];
        self.documentInsertedObserver = nil;
    }
    
    if (self.documentDeletedObserver)
    {
        [center removeObserver:self.documentDeletedObserver];
        self.documentDeletedObserver = nil;
    }
    
    if (self.documentChangeCompleteObserver)
    {
        [center removeObserver:self.documentChangeCompleteObserver];
        self.documentChangeCompleteObserver = nil;
    }
}

@end
