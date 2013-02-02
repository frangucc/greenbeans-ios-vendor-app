#import "IncentivesViewController.h"
#import <QuartzCore/QuartzCore.h>

#define start_color [UIColor colorWithHex:0xEEEEEE]
#define end_color [UIColor colorWithHex:0xDEDEDE]

@implementation IncentivesViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self drawRootToolbar];
    [self alloc];
    [self drawIncentivesTableview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotate:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL) alloc
{
    headers = [[NSArray alloc] initWithObjects:@"Add Game or Gift",
               @"Active Raffles", @"Active Gifts", @"Raffles Claimed",
               @"Gifts Claimed", @"Raffles Redeemed", @"Gifts Redeemed",@"Add Game or Gift",
               @"Active Raffles", @"Active Gifts", @"Raffles Claimed",
               @"Gifts Claimed", @"Raffles Redeemed", @"Gifts Redeemed", nil];
    
    return (headers != nil);
}

- (void) drawIncentivesTableview
{
    incentivesTableview = [[UITableView alloc] initWithFrame:
                           CGRectMake(0, 35, self.view.bounds.size.width, self.view.bounds.size.height - 35*2/*Toolbar*/ - self.tabBarController.tabBar.bounds.size.height - 33/*Padding*/) style:UITableViewStylePlain];

    [incentivesTableview setDelegate:self];
    [incentivesTableview setDataSource:self];
    [self.view addSubview:incentivesTableview];
    incentivesTableview.rowHeight = 48;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) { incentivesTableview.rowHeight = 55; }
    incentivesTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [incentivesTableview dropShadows];
    
    [incentivesTableview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-hatched-texture"]]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-hatched-texture"]]];
}

- (void) getCellContentView:(UITableViewCell *)cell :(NSString *)title :(NSString *)value {
    
    UILabel *mainCellTitle = [[UILabel alloc] initWithFrame:CGRectMake(9, 12, 165, 20)];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) { [mainCellTitle setFrame:CGRectMake(16, 16, 165, 20)]; }
    mainCellTitle.textColor = [UIColor blackColor];
    mainCellTitle.backgroundColor = [UIColor clearColor];
    mainCellTitle.textAlignment = NSTextAlignmentLeft;
    mainCellTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    mainCellTitle.text = title;
    [cell.contentView addSubview:mainCellTitle];
    
    UILabel *cellTitleValue = [[UILabel alloc] initWithFrame:CGRectMake(175, 12, 118, 20)];
    cellTitleValue.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    cellTitleValue.backgroundColor = [UIColor clearColor];
    cellTitleValue.textAlignment = NSTextAlignmentRight;
    cellTitleValue.text = value;
    cellTitleValue.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [cell.contentView addSubview:cellTitleValue];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

/* Display Root Toolbar at Bottom of View */
- (BOOL)drawRootToolbar
{
    /*    Remove previously instantiated toolbar to prevent an overabundance of UIToolbars */
    SVSegmentedControl *segmentedControl = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"members", @"games/gifts", @"actions", nil]];
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
	[segmentedControl setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 35)];
	segmentedControl.crossFadeLabelsOnDrag = YES;
	segmentedControl.thumb.tintColor = [UIColor colorWithRed:107.0f/255.0f green:216.0f/255.0f blue:77.0f/255.0f alpha:1.0f];//107	216	77
	segmentedControl.selectedIndex = 0;
    [self.view addSubview:segmentedControl];
    
    return (segmentedControl != nil);
}

#pragma mark SPSegmentedControl

- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl {
	NSLog(@"segmentedControl %i did select index %i (via UIControl method)", segmentedControl.tag, segmentedControl.selectedIndex);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return headers.count;
}

- (UITableViewCell *) tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    TableViewCell *cell = [incentivesTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.tableViewBackgroundColor = incentivesTableview.backgroundColor;
        cell.gradientStartColor = start_color;
        cell.gradientEndColor = end_color;
        
        if ([indexPath row] == 0)
        {
            [self getCellContentView:cell :[headers objectAtIndex:[indexPath row]] :@""];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else
        {
            [self getCellContentView:cell :[headers objectAtIndex:[indexPath row]] :@""];
            UILabel *ovalCount = [[UILabel alloc] initWithFrame:CGRectMake(265, 12, 39, 25)];
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) { [ovalCount setFrame:CGRectMake(self.view.bounds.size.width - 105, 17, 39, 25)]; }
            [ovalCount setBackgroundColor:[UIColor whiteColor]];
            [ovalCount setTextColor:[UIColor blackColor]];
            [ovalCount setText:[NSString stringWithFormat:@"%ld", (random() % 12)]];
            [ovalCount setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
            [ovalCount setTextAlignment:NSTextAlignmentCenter];
            [ovalCount.layer setCornerRadius:10.0f];
            [ovalCount.layer setShadowColor:[UIColor lightGrayColor].CGColor];
            [ovalCount.layer setShadowOffset:CGSizeMake(0, 0)];
            [ovalCount.layer setShadowRadius:4.0f];
            [ovalCount.layer setBorderColor:[UIColor colorWithRed:189.0f/255.0f green:189.0f/255.0f blue:189.0f/255.0f alpha:.5f].CGColor];
            [cell.backgroundView addSubview:ovalCount];
        }
    }
    [cell prepareForTableView:incentivesTableview indexPath:indexPath];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
} /* tableView */


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
