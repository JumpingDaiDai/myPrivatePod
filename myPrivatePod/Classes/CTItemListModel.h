//
//  CTItemListModel.h
//  CTItemListComponentSample
//
//  Created by Jason on 2017/1/18.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SeparationMode) {
    
    SeparationMode_None = 0, // 無匡線
    SeparationMode_Vertical, // 垂直的匡線
//    SeparationMode_All, // 外匡線以及中央匡線
};

@interface CTItemListModel : NSObject

@end
