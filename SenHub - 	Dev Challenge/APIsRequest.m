//
//  APIsRequest.m
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "APIsRequest.h"
#import "ContactsViewController.h"

@implementation APIsRequest

+ (NSArray*)getListContacts
{
    NSArray* arr;
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:linkForContacts, API_NUMBER, API_KEY]]];
    
    if(data) { // if data exists eg. no error
        arr = [NSArray arrayWithArray:[APIsRequest fetchedData:data]];
    }
    else {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:@"There has been an error during the retrieving of contacts."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [message release];
        
        ContactsViewController* cvc = [[ContactsViewController alloc] initWithID:@"6855952"
                                                                            name:@"Florian Reiss"
                                                                          number:@"+14156236374"
                                                                             uri:@"/v1/contacts/6855952/"];
        arr = [NSArray arrayWithObject:cvc];
    }
    return arr;
}

+ (NSArray*)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSArray* contacts = [json objectForKey:@"objects"]; // contacts = all json as one item
    
    NSMutableArray* array = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSDictionary* contact in contacts) { // transforms one json for one contact as a dict
        ContactsViewController* cvc = [[ContactsViewController alloc] initWithID:[contact objectForKey:@"id"]
                                                                            name:[contact objectForKey:@"name"]
                                                                          number:[contact objectForKey:@"number"]
                                                                             uri:[contact objectForKey:@"resource_uri"]];
        [array addObject:cvc];
    }
    
    return array;
}

+ (void)sendText:(NSString*)text toContactID:(NSString*)contactID
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
    [request setValue:[NSString stringWithFormat:@"'{\"contacts\" : [%@],\"text\" : \"%@\"}'", contactID, text]
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
@end
