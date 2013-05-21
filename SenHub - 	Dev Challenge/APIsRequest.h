//
//  APIsRequest.h
//  SenHub - 	Dev Challenge
//
//  Created by Florian Reiss on 20/05/13.
//  Copyright (c) 2013 Florian Reiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIsRequest : NSObject

+ (NSArray*)getListContacts;
+ (void)sendText:(NSString*)text toContactID:(NSString*)contactID;

@end
