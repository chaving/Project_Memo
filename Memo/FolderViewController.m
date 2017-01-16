//
//  FolderViewController.m
//  Memo
//
//  Created by chaving on 2017. 1. 12..
//  Copyright © 2017년 chaving. All rights reserved.
//

#import "FolderViewController.h"
#import "ListViewController.h"

#import "AppDelegate.h"
#import "Folder+CoreDataClass.h"

@interface FolderViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) AppDelegate *appDelegate;
@property (strong,nonatomic) NSManagedObjectContext *context;

@property (weak, nonatomic) IBOutlet UITableView *folderTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editingButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editingFolderButton;

@property NSArray *folderListArray;


@end

@implementation FolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _context = _appDelegate.persistentContainer.viewContext;
    
    self.folderTableView.allowsMultipleSelectionDuringEditing = YES;
    
    [self requestFolderData];
}

- (void)requestFolderData{

    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Folder" inManagedObjectContext:_context];
    self.folderListArray = [[_context executeFetchRequest:request error:&error] mutableCopy];
    
    if (error) {
        NSLog(@"Error : %@", [error description]);
    }
    
    [self.folderTableView reloadData];
}

#pragma mark - Add New Folder Action
- (IBAction)addNewFolderButtonAction:(UIBarButtonItem *)sender {
    
    NSLog(@"Name : %@", self.editingFolderButton.title);
    
    if ([self.editingFolderButton.title isEqualToString:@"새로운 폴더"]) {
        
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"새로운 폴더"
                                            message:[NSString stringWithFormat:@"새로운 폴더의 이름을 입력하십시오."]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            textField.placeholder = @"이름";
        }];
        
        id makeFolderHandler = ^(UIAlertAction * _Nonnull action) {
            
            Folder *folderEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Folder" inManagedObjectContext:_context];
            folderEntity.title = alertController.textFields.firstObject.text;
            
            NSError *error;
            
            if (![_context save:&error]) {
                NSLog(@"Error : %@", [error description]);
            }
            
            [self requestFolderData];
        };
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인"
                                                           style:UIAlertActionStyleDefault
                                                         handler:makeFolderHandler];
        
        [alertController addAction:okAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                             }];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
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

#pragma mark - TableView Editing
- (IBAction)tableViewEditing:(id)sender {
    
    if ([self.editingButton.title isEqualToString:@"편집"]) {
        
        [self.folderTableView setEditing:YES animated:YES];
        
        self.editingButton.title = @"완료";
        self.editingFolderButton.title = @"삭제";
        
    } else {
        
        self.editingButton.title = @"편집";
        self.editingFolderButton.title = @"새로운 폴더";
        
        [self.folderTableView setEditing:NO animated:YES];
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
