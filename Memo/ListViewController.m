//
//  ListViewController.m
//  Memo
//
//  Created by chaving on 2017. 1. 12..
//  Copyright © 2017년 chaving. All rights reserved.
//

#import "ListViewController.h"

#import "DataCenter.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>

@property DataCenter *dataCenter;

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property NSArray *memoListArray;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *listCountItem;

@end

@implementation ListViewController

- (void)viewWillAppear:(BOOL)animated{

    [self reloadMemoData];
    [self setListData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCenter = [[DataCenter alloc] init];
}

- (void)setListData{

    NSArray *folderDataArray = [_dataCenter requestFolderData];
    self.navigationItem.title = [NSString stringWithFormat:@"%@", [folderDataArray[_folderIndex] valueForKey:@"title"]];
    
    NSUInteger fontSize = 13;
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
    NSDictionary *attributes = @{NSFontAttributeName: font};

    [self.listCountItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    self.listCountItem.title = [NSString stringWithFormat:@"%ld개의 메모", _memoListArray.count];
}

#pragma mark - Replace Folder Data
- (void)reloadMemoData{
    
    self.memoListArray = [_dataCenter requestMemoData];
    [_listTableView reloadData];
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _memoListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.memoListArray[indexPath.row] valueForKey:@"text"];
    cell.detailTextLabel.text = [self.memoListArray[indexPath.row] valueForKey:@"date"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
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
