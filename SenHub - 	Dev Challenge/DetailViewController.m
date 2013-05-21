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

- (void)dealloc
{
    [_detailItem release];
    [self.detailPhoneTextField release];
    [self.detailNameTextField release];
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
    if(((UITextField*)sender).text) {
        [sender resignFirstResponder];
    }
}

- (void)configureView
{
    self.detailNameTextField.delegate = self;
    self.detailPhoneTextField.delegate = self;
    
    if (self.detailItem) {
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
    self.navigationItem.title = [self.detailItem name];
    //UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit                                                                                target:self action:@selector(changeText:)] autorelease];
    //self.navigationItem.rightBarButtonItem = addButton;
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
