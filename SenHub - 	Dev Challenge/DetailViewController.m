//
//  DetailViewController.m
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "DetailViewController.h"

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

- (IBAction)disableInput:(id)sender
{
    if(((UITextField*)sender).text && ![((UITextField*)sender).text isEqualToString:@"New"]) {
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

- (void)configureEmptyView
{
    self.navigationItem.title = @"New";
    [self setDetailItem:[[ContactsViewController alloc] init]];
    self.sendMessageButton.hidden = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"sendMessage"]) {
        NSString* ID = self.detailItem.ID;
        [[segue destinationViewController] setID:ID];
    }
}

- (IBAction)inputReturn:(id)sender
{
    if(((UIButton*)sender).tag == 1) { // Name
        if([self.detailItem name] != self.detailNameTextField.text)
            self.detailItem.name = self.detailNameTextField.text;
    }
    else if(((UIButton*)sender).tag == 2) { // Phone
        if([self.detailItem number] != self.detailPhoneTextField.text)
            self.detailItem.number = self.detailPhoneTextField.text;
    }
    
    [sender resignFirstResponder];
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
        UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                    target:self
                                                                                    action:@selector(changeText:)]
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
