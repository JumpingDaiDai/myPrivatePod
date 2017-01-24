//
//  CTItemModel.m
//  CTItemListComponentSample
//
//  Created by Jason on 2017/1/16.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "CTItemModel.h"

@implementation CTItemModel

#pragma mark -
#pragma mark - Life-cycle methods
#pragma mark -
//================================================================================
//
//================================================================================
- (instancetype)initWithStyleType:(StyleType)styleType contentType:(ContentType)contentType {
    
    if (self = [super init]) {
        
        self.styleType = styleType;
        self.contentType = contentType;
    }
    
    return self;
}

@end
