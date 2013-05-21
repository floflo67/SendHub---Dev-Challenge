//
//  AppDelegate.m
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "AppDelegate.h"
#import "ContactsViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (NSArray*)getListContacts
{
    NSArray* arr;    
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:linkForContacts, API_NUMBER, API_KEY]]];
    data = nil;
    
    if(data) { // if data exists eg. no error
        arr = [NSArray arrayWithArray:[AppDelegate fetchedData:data]];
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

@end
