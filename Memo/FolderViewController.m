//
//  FolderViewController.m
//  Memo
//
//  Created by chaving on 2017. 1. 12..
//  Copyright © 2017년 chaving. All rights reserved.
//

#import "FolderViewController.h"
#import "ListViewController.h"

#import "DataCenter.h"

typedef NS_ENUM(NSInteger, TableViewType) {
    TableViewEditingType,
    TableViewDefultType,
};

@interface FolderViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property DataCenter *dataCenter;

@property (weak, nonatomic) IBOutlet UITableView *folderTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editingButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editingFolderButton;

@property NSArray *folderListArray;
@property(nonatomic, strong)UIAlertAction *okAction;

@end

@implementation FolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCenter = [[DataCenter alloc] init];
    
    [self reloadFolderData];
}

#pragma mark - Replace Folder Data
- (void)reloadFolderData{
    
    self.folderListArray = [_dataCenter requestFolderData];
    [self.folderTableView reloadData];
}

#pragma mark - Add New Folder Action
- (IBAction)addNewFolderButtonAction:(UIBarButtonItem *)sender {
    
    if ([self.editingFolderButton.title isEqualToString:@"새로운 폴더"]) {
        
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"새로운 폴더"
                                            message:[NSString stringWithFormat:@"새로운 폴더의 이름을 입력하십시오."]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            textField.placeholder = @"이름";
            
            [textField addTarget:self
                          action:@selector(alertTextFieldDidChange:)
                forControlEvents:UIControlEventEditingChanged];
        }];
        
        id makeFolderHandler = ^(UIAlertAction * _Nonnull action) {

            [_dataCenter addNewFolder:alertController];
            [self reloadFolderData];
        };
        
        self.okAction = [UIAlertAction actionWithTitle:@"저장"
                                                           style:UIAlertActionStyleDefault
                                                         handler:makeFolderHandler];
        _okAction.enabled = NO;
        
        [alertController addAction:_okAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        [_dataCenter deleteFolderData:_folderTableView];
        [self setTheTableViewType:TableViewDefultType];
        [self reloadFolderData];
    }
}

// 폴더 이름이 한글자 이상 있을때 버튼 활성화
- (void)alertTextFieldDidChange:(UITextField *)sender
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController)
    {
        UITextField *login = alertController.textFields.firstObject;
        
        _okAction.enabled = login.text.length > 0;
    }
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.folderListArray.count == 0) {
        return 1;
    }else{
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section != 0) {
        return self.folderListArray.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FolderCell" forIndexPath:indexPath];
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectionColor;
    
    if (indexPath.section == 1) {
        cell.textLabel.text = [self.folderListArray[indexPath.row] valueForKey:@"title"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.folderTableView.editing == NO) {
        
        [self performSegueWithIdentifier:@"moveToListSegue" sender:self];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return NO;
    }
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [_dataCenter deleteOneFolder:indexPath];
        [self setTheTableViewType:TableViewDefultType];
        [self reloadFolderData];
    }
}

#pragma mark - Set the Tableview Type
- (void)setTheTableViewType:(TableViewType)type{
    
    switch (type) {
        case TableViewEditingType:
            
            self.folderTableView.allowsMultipleSelectionDuringEditing = YES;
            
            [self.folderTableView setEditing:YES animated:YES];
            
            self.editingButton.title = @"완료";
            self.editingFolderButton.title = @"삭제";
            
            break;
        case TableViewDefultType:
            
            self.folderTableView.allowsMultipleSelectionDuringEditing = NO;
            
            self.editingButton.title = @"편집";
            self.editingFolderButton.title = @"새로운 폴더";
            
            [self.folderTableView setEditing:NO animated:YES];
            
            break;
    }
}

#pragma mark - TableView Editing
- (IBAction)tableViewEditing:(id)sender {
    
    if ([self.editingButton.title isEqualToString:@"편집"]) {
        
        [self setTheTableViewType:TableViewEditingType];
        
    } else {
        
        [self setTheTableViewType:TableViewDefultType];
    }
}

#pragma mark - Segue Method
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"moveToListSegue"]) {
        
    }
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
