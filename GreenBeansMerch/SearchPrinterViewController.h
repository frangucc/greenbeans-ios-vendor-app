//
//  SearchPrinterViewController.h
//  IOS_SDK
//
//  Created by satsuki on 12/08/17.
//
//

#import <UIKit/UIKit.h>
#import "ReturnSelectedCellText.h"

@interface SearchPrinterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
    NSArray *printerArray;
    NSString *lastSelectedPortName;

    IBOutlet UITableView *uitableview_printerList;
}
@property(readonly) NSString *lastSelectedPortName;
@property(nonatomic, assign) id <ReturnSelectedCellTextDelegate> delegate;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
