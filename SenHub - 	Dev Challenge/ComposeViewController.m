//
//  ComposeViewController.m
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ComposeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)inputReturn:(id)sender
{
    if(self.messageTextField.text.length > 0)
        self.message = self.messageTextField.text;
    
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.messageTextField.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_messageTextField release];
    [super dealloc];
}
@end
