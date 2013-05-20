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
    [_detailPhoneTextField release];
    [_detailNameTextField release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];

        // Update the view.
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
        long ID = _detailItem.ID;
        [[segue destinationViewController] setID:ID];
    }
}

- (IBAction)changeText:(id)sender {
    
}

- (IBAction)inputReturn:(id)sender
{
    if(((UIButton*)sender).tag == 1) { // Name
        if([_detailItem name] != self.detailNameTextField.text)
            _detailItem.name = self.detailNameTextField.text;
    }
    else if(((UIButton*)sender).tag == 2) { // Phone
        if([_detailItem number] != self.detailPhoneTextField.text)
            _detailItem.number = self.detailPhoneTextField.text;
    }
    
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = [self.detailItem name];
    //UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit                                                                                target:self action:@selector(changeText:)] autorelease];
    //self.navigationItem.rightBarButtonItem = addButton;
    
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
