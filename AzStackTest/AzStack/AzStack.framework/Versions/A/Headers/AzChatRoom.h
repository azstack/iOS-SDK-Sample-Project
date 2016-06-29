//
//  StackUser.h
//  AzStack
//
//  Created by Nguyen Van Phu on 10/29/15.
//
//

#import <Foundation/Foundation.h>

@interface AzChatRoom : NSObject

@property (nonatomic, assign) int roomId;
@property (nonatomic, strong) NSString* roomTitle;
@property (nonatomic, strong) NSString* roomDescription;
@property (nonatomic, strong) NSString* roomImage;

@end
