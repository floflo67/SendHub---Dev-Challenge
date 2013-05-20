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

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)setID:(long)ID
{
    self.ContactID = ID;
}

- (IBAction)inputReturn:(id)sender
{
    if(self.messageTextField.text.length > 0)
        self.message = self.messageTextField.text;
    
    [self sendMessage];
    
    [sender resignFirstResponder];
}

-(void)sendMessage
{
    // Make a call to the API to pull out the categories
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:linkToMessage, API_NUMBER, API_KEY]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"]; // -X POST
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; // -H "Content-Type: application/json"

    [request setValue:[NSString stringWithFormat:@"'{\"contacts\" : [%d],\"text\" : \"%@\"}'", self.ContactID, self.message]
                       forHTTPHeaderField:@"data"]; // --data '{"contacts" : [1111],"text" : "Testing"}'
    
    NSError* error;
    NSURLResponse* response;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if([response statusCode] == 201) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Success"
                                                          message:@"Your text has successfully been sent."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    else if(error != nil) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:@"There has been an error during the sending."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    
    if(error != nil)
        NSLog(@"nil");
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
    [self.message dealloc];
    [_messageTextField release];
    [super dealloc];
}
@end
