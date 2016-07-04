//
//  EqualSpaceFlowLayout.h
//  TagView
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 白玉京. All rights reserved.
//

#import <UIKit/UIKit.h>


@class EqualSpaceFlowLayout;

@protocol EqualSpaceFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@end


@interface EqualSpaceFlowLayout : UICollectionViewFlowLayout


@property (weak , nonatomic) id<EqualSpaceFlowLayoutDelegate>delegate;

@property (strong , nonatomic) NSMutableArray  *itemAttributes;



@end
