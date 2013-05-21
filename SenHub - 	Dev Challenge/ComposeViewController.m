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

- (void)setID:(NSString*)ID
{
    self.ContactID = ID;
}

- (IBAction)inputReturn:(id)sender
{
    if(self.messageTextField.text.length > 0) // checks if message exists
        self.message = self.messageTextField.text;
    
    [self sendMessage];
    [sender resignFirstResponder]; // gets rid of virtual keyboard
}

-(void)sendMessage
{
    // Make a call to the API to send the message
    // Should end like this:
    /* curl -H "Content-Type: application/json" 
            -X POST 
            --data '{"contacts" : [1111],"text" : "Testing"}' 
            https://api.sendhub.com/v1/messages/?username=NUMBER\&api_key=APIKEY 
     */
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:linkToMessage, API_NUMBER, API_KEY]]; // URL
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"]; // -X POST
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; // -H "Content-Type: application/json"

    // --data '{"contacts" : [1111],"text" : "Testing"}'
    // should be like this. Not working (yet)
    [request setValue:[NSString stringWithFormat:@"'{\"contacts\" : [%@],\"text\" : \"%@\"}'", self.ContactID, self.message]
                       forHTTPHeaderField:@"data"]; 
    
    NSError* error;
    NSURLResponse* response;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    UIAlertView *message;
    
    if([(NSHTTPURLResponse*)response statusCode] == 201) {
        message = [[UIAlertView alloc] initWithTitle:@"Success"
                                                          message:@"Your text has successfully been sent."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
    }
    else {
        message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:@"There has been an error during the sending."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
    }
    
    [message show];
    [message release];
    
    [request release];
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
    [self.message release];
    [self.ContactID release];
    [self.messageTextField release];
    [super dealloc];
}
@end
