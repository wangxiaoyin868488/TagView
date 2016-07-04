//
//  BtnCollectionViewCell.h
//  TagView
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 白玉京. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BtnCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

- (void)setBtnCollectionViewCellWithDict:(NSDictionary *)dict;

- (void)setBtnCollectionViewCellWithStr:(NSString *)str;

@end
