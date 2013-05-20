//
//  DetailViewController.h
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsViewController.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) ContactsViewController* detailItem;

@property (retain, nonatomic) IBOutlet UITextField *detailPhoneTextField;
@property (retain, nonatomic) IBOutlet UITextField *detailNameTextField;

@end
