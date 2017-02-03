//
//  WriteViewController.m
//  Memo
//
//  Created by chaving on 2017. 1. 12..
//  Copyright © 2017년 chaving. All rights reserved.
//

#import "WriteViewController.h"
#import "DataCenter.h"

@interface WriteViewController () <UITextViewDelegate>

@property DataCenter *dataCenter;

@property (weak, nonatomic) IBOutlet UITextView *memoTextView;

@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCenter = [[DataCenter alloc] init];
    
    self.memoTextView.delegate =  self;
    [_memoTextView becomeFirstResponder];
    
    [self keyboardShowEvent];
}


#pragma mark - Keyboard Event
- (void)keyboardShowEvent{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardStatus:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)keyboardHideEvent{

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardStatus:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)keyboardStatus:(NSNotification *)notification{
    
    if(notification.name == UIKeyboardWillShowNotification) {
        
        [self rightBarButtonItemStatus];
        [self keyboardHideEvent];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        
    } else if(notification.name == UIKeyboardWillHideNotification) {
    
        self.navigationItem.rightBarButtonItem = nil;
        [self keyboardShowEvent];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}


#pragma mark - Right BarButton Item
- (void)rightBarButtonItemStatus{
    
    UIBarButtonItem *completeButton = [[UIBarButtonItem alloc] initWithTitle:@"완료"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(touchUpCompleteButton:)];
    self.navigationItem.rightBarButtonItem = completeButton;
}

- (void)touchUpCompleteButton:(UIBarButtonItem *)sender {
    
    [_memoTextView resignFirstResponder];
    [_dataCenter addNewMemo:_memoTextView];
}


#pragma mark - UITextView delegate


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
