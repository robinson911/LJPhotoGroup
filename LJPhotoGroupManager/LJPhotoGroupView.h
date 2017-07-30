//
//  LJImageScrollView.h
//  CommonDemo
//
//  Created by 孙伟伟 on 2017/7/23.
//  Copyright © 2017年 孙伟伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJPhotoView.h"
#import "LJPhotoInfo.h"

@interface LJPhotoGroupView : UIScrollView

- (instancetype)initByArray:(LJPhotoInfo*)info frame:(CGRect)frame;

- (void)showView;

@end
