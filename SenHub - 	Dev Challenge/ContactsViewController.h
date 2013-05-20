//
//  ContactsViewController.h
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UIViewController

@property (nonatomic) long ID;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* number;
@property (strong, nonatomic) NSString* resource_uri;

- (id)initWithID:(long)ID name:(NSString*)name number:(NSString*)number uri:(NSString*)resource_uri;
- (id)initWithDict:(NSDictionary*)dict;

@end
