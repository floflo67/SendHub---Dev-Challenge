//
//  ContactsViewController.h
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UIViewController

@property (nonatomic) int ID;
@property (strong, nonatomic) NSString* name;
@property (nonatomic) int number;
@property (strong, nonatomic) NSString* resource_uri;

- (id)initWithID:(int)ID name:(NSString*)name number:(int)number uri:(NSString*)resource_uri;

@end
