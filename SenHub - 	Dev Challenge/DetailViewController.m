//
//  DetailViewController.m
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"
#import "APIsRequest.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

- (id)init
{
    self = [super init];
    if(self) {
        [self setDetailItem:nil];
    }
    return self;
}

- (void)dealloc
{
    [_detailItem release];
    [self.detailPhoneTextField release];
    [self.detailNameTextField release];
    [_sendMessageButton release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];
        [self configureView];
    }
}

// Disables input if contact exists
- (IBAction)disableInput:(id)sender
{
    if([((UITextField*)sender).text length] > 0) {
        [sender resignFirstResponder];
    }
}

// Loads view for existing contact
- (void)configureView
{    
    self.detailNameTextField.text = [self.detailItem name];
    
    // Converts phone number
    // +12223334444 becomes +1 (222) 333-4444
    // Works only for US numbers
    NSString *tenDigitNumber = [[self.detailItem number] substringFromIndex:1];
    tenDigitNumber = [tenDigitNumber stringByReplacingOccurrencesOfString:@"(\\d{1})(\\d{3})(\\d{3})(\\d{4})"
                                                               withString:@"+$1 ($2) $3-$4"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [tenDigitNumber length])];
    self.detailPhoneTextField.text = tenDigitNumber;
}

// Loads view for empty contact
- (void)configureEmptyView
{
    self.navigationItem.title = @"New";
    [self setDetailItem:[[ContactsViewController alloc] init]];
    self.sendMessageButton.hidden = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"sendMessage"]) {
        NSString* ID = self.detailItem.ID;
        [[segue destinationViewController] setID:ID];
    }
}

- (IBAction)saveContact:(id)sender
{
    UIAlertView* alert;
    if([self.detailNameTextField.text length] > 0 && [self.detailPhoneTextField.text length] > 0) {
        self.detailItem.name = self.detailNameTextField.text;
        self.detailItem.number = self.detailPhoneTextField.text;
        
        [APIsRequest saveContactName:self.detailNameTextField.text andPhone:self.detailPhoneTextField.text]; // call API
        
        // alert only for tests
        
        alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                           message:@"Contact added"
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
    }
    else
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                           message:@"Contact not added"
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailNameTextField.delegate = self;
    self.detailPhoneTextField.delegate = self;
    self.sendMessageButton.hidden = NO;
 
    if(self.detailItem) {
        self.navigationItem.title = [self.detailItem name];
        [self configureView];
    }
    else {
        UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                    target:self
                                                                                    action:@selector(saveContact:)]
                                      autorelease];
        self.navigationItem.rightBarButtonItem = addButton;
        [self configureEmptyView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
