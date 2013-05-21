//
//  ComposeViewController.m
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIsRequest.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)setID:(NSString*)ID
{
    self.ContactID = ID;
}

- (IBAction)inputReturn:(id)sender
{
    if(self.messageTextField.text.length > 0) { // checks if message exists
        [self sendMessage];
        [sender resignFirstResponder]; // gets rid of virtual keyboard
    }
}

-(void)sendMessage
{
    [APIsRequest sendText:self.messageTextField.text toContactID:self.contactID];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.messageTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [self.contactID release];
    [self.messageTextField release];
    [super dealloc];
}
@end
