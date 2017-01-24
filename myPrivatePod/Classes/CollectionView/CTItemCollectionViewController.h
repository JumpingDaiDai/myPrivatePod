//
//  CTItemCollectionViewController.h
//  CTItemListComponentSample
//
//  Created by Jason on 2017/1/19.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTItemListModel.h"

@interface CTItemCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSArray *itemModelList;
@property (nonatomic, assign) NSInteger numberOfRow;
// 目前不支援匡線
//@property (nonatomic, assign) SeparationMode separationMode;
//@property (nonatomic, strong) UIColor *separationColor;

@end
