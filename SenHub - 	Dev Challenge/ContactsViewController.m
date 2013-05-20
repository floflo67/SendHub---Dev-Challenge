//
//  ContactsViewController.m
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (void)dealloc {
    [self.name release];
    [self.resource_uri release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        [self initWithID:(int)[dict objectForKey:@"ID"]
                    name:[dict objectForKey:@"name"]
                  number:(int)[dict objectForKey:@"number"]
                     uri:[dict objectForKey:@"uri"]];
    }
    return self;
}

- (id)initWithID:(int)ID name:(NSString*)name number:(int)number uri:(NSString*)uri
{
    if (!self) {
        self = [super init];
    }
    
    self.ID = ID;
    self.name = name;
    self.number = number;
    self.resource_uri = uri;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
