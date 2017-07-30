//
//  LJPhotoGroupView.m
//  CommonDemo
//
//  Created by 孙伟伟 on 2017/7/23.
//  Copyright © 2017年 孙伟伟. All rights reserved.
//

#import "LJPhotoGroupView.h"
#import "LJPhotoView.h"

#define baseIndex 1000

@interface LJPhotoGroupView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *ljScrollView;
@property (nonatomic, strong) UIPageControl *ljPageControl;
@property (nonatomic, strong) UILabel *currentPhotoLabel;
//暂存储当前展示图片的源frame的frame；
@property (nonatomic, assign) CGRect originFrame;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
@property (nonatomic, strong) LJPhotoInfo *photoInfo;

@end

@implementation LJPhotoGroupView

- (instancetype)initByArray:(LJPhotoInfo*)info frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.photoInfo = info;
        self.currentPhotoIndex = info.currentSelectIndex;

        [self addSubview:self.ljScrollView];
        [self addSubview:self.ljPageControl];
        [self addSubview:self.currentPhotoLabel];
        [self setTopCurrentPhoto:0];
    }
    return self;
}

- (UIScrollView*)ljScrollView
{
    if (!_ljScrollView)
    {
        _ljScrollView = UIScrollView.new;
        _ljScrollView.frame = CGRectMake(0, 0, kDEVICEWIDTH, kDEVICEHEIGHT);
        _ljScrollView.delegate = self;
        //_scrollView.scrollsToTop = NO;
        _ljScrollView.pagingEnabled = YES;
        _ljScrollView.contentSize = CGSizeMake(_ljScrollView.bounds.size.width * self.photoInfo.totalCount, kDEVICEHEIGHT);
        //_scrollView.alwaysBounceHorizontal = groupItems.count > 1;
       // _scrollView.showsHorizontalScrollIndicator = NO;
        //_scrollView.showsVerticalScrollIndicator = NO;
        //_scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //_scrollView.delaysContentTouches = NO;
        //_scrollView.canCancelContentTouches = YES;
    }
    return _ljScrollView;
}

- (UIPageControl *)ljPageControl
{
    if (_ljPageControl == nil)
    {
        // 分页控件，本质上和scrollView没有任何关系，是两个独立的控件
        _ljPageControl = [[UIPageControl alloc] init];
        // 总页数
        _ljPageControl.numberOfPages = self.photoInfo.totalCount;
        CGSize size = [_ljPageControl sizeForNumberOfPages:self.photoInfo.totalCount];
        
        _ljPageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _ljPageControl.center = CGPointMake(self.center.x, 564);
        
        // 设置颜色
        _ljPageControl.pageIndicatorTintColor = [UIColor redColor];
        //当前页面的颜色
        _ljPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [_ljPageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _ljPageControl;
}

- (UILabel*)currentPhotoLabel
{
    if (!_currentPhotoLabel) {
        _currentPhotoLabel = UILabel.new;
        _currentPhotoLabel.frame = CGRectMake(0, 22, kDEVICEWIDTH, 20);
        _currentPhotoLabel.textColor = [UIColor whiteColor];
        _currentPhotoLabel.font = loadFont(20);
        _currentPhotoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentPhotoLabel;
}

// 分页控件的监听方法
- (void)pageChanged:(UIPageControl *)page
{
    NSLog(@"%ld", (long)page.currentPage);
    
    // 根据页数，调整滚动视图中的图片位置 contentOffset self.scrollView.bounds.size.width
    CGFloat x = page.currentPage * (kDEVICEWIDTH);
    [self.ljScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark - ScrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = self.ljScrollView.contentOffset.x / self.ljScrollView.width;
    self.currentPhotoIndex = page;
    self.ljPageControl.currentPage = page;
    
    CHDebugLog(@"当前页数------%ld",(long)page);
    LJPhotoView *cell = [self dequeueReusableCell];
    cell.tag = page + baseIndex;
    [cell setCurrentImageview:[self getCurrentInfo]];
    [self.ljScrollView addSubview:cell];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
    }
}

// 滚动视图停下来，修改页面控件的小点（页数）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 停下来的当前页数
    //NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    CHDebugLog(@"当前页数------%ld",(long)page);
    
    self.currentPhotoIndex = page;
    self.ljPageControl.currentPage = page;
    [self setTopCurrentPhoto:page];
}

#pragma mark - Zoom methods
- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
{
    NSLog(@"handleDoubleTap");
}

#pragma mark -- 设置顶部的标题
- (void)setTopCurrentPhoto:(NSInteger)page
{
    if (self.photoInfo.totalCount == 1) {
        [_currentPhotoLabel setText:@""];
        self.ljPageControl.hidden = YES;
    }
    else
    {
        self.ljPageControl.hidden = NO;
        [_currentPhotoLabel setText:[NSString stringWithFormat:@"%ld/%ld",page+1,self.photoInfo.totalCount]];
    }
}

#pragma mark -- 生成展示用的Cell
- (LJPhotoView *)dequeueReusableCell {
    UIImageView *_tempImageView = self.photoInfo.ljImageviewArray[self.currentPhotoIndex];
    LJPhotoView *cell = [self viewWithTag:baseIndex + self.currentPhotoIndex];
    if (cell) {
        //保存转换前图片的frame
        self.originFrame = [_tempImageView convertRect:_tempImageView.bounds toView:self];
        return cell;
    }
    
    cell = [[LJPhotoView alloc]initWithFrame:CGRectMake((kDEVICEWIDTH)*self.currentPhotoIndex, 0, kDEVICEWIDTH, kDEVICEHEIGHT)];
    
   //保存转换前图片的frame
   self.originFrame = [_tempImageView convertRect:_tempImageView.bounds toView:self];
   return cell;
}

- (LJPhotoInfo*)getCurrentInfo
{
    LJPhotoInfo *_info =  [[LJPhotoInfo alloc]init];
    _info.ljImageview = self.photoInfo.ljImageviewArray[self.currentPhotoIndex];
    _info.ljUrlStr = self.photoInfo.ljUrlArray[self.currentPhotoIndex];
    _info.ljimage = _info.ljImageview.image;
    _info.currentSelectIndex = self.currentPhotoIndex;
    
    return _info;
}

#pragma mark -- 显示图片
- (void)showView
{
    self.ljPageControl.currentPage = self.currentPhotoIndex;
    //设置顶部的数字
    [self setTopCurrentPhoto:self.ljPageControl.currentPage];

    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    self.backgroundColor = [UIColor blackColor];

    //获取self.originFrame
    LJPhotoView *cell1 = [self dequeueReusableCell];
    cell1.tag = self.currentPhotoIndex + baseIndex;
    
    UIImage *_ljImage = [self getCurrentInfo].ljimage;

    //用于放大图片，展示效果用，图片放大后，会自动移除掉
    UIImageView *_ljImageViews = [[UIImageView alloc]init];
    _ljImageViews.image = _ljImage;
    _ljImageViews.frame = self.originFrame;
    _ljImageViews.tag = 1024;
    _ljImageViews.clipsToBounds = YES;
    _ljImageViews.contentMode  = UIViewContentModeScaleAspectFit;
    [self addSubview:_ljImageViews];

    //添加点击事件同样是类方法 -> 作用是再次点击回到初始大小
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView)];
    [self addGestureRecognizer:tapGestureRecognizer];

    self.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        CGFloat y,width,height;
        y = ([UIScreen mainScreen].bounds.size.height - _ljImage.size.height * [UIScreen mainScreen].bounds.size.width / _ljImage.size.width) * 0.5;
        //宽度为屏幕宽度
        width = kDEVICEWIDTH;
        //高度 根据图片宽高比设置
        height = _ljImage.size.height * [UIScreen mainScreen].bounds.size.width / _ljImage.size.width;
        [_ljImageViews setFrame:CGRectMake(0, y, width, height)];
    } completion:^(BOOL finished)
     {
         //选择第一张图片的时候，setContentOffset不会被调用，因为默认就是第一张图片。
         //所以此处需要手动将cell的图片添加到ljScrollView
         if (!self.currentPhotoIndex) {
             LJPhotoView *cell1 = [self dequeueReusableCell];
             cell1.tag = self.currentPhotoIndex + baseIndex;
             [cell1 setCurrentImageview:[self getCurrentInfo]];
             [self.ljScrollView addSubview:cell1];
         }
         else{
             //根据选中第几张图片直接展示出来
             CGFloat x = self.currentPhotoIndex* (kDEVICEWIDTH);
             [self.ljScrollView setContentOffset:CGPointMake(x, 0) animated:NO];
         }
         [_ljImageViews removeFromSuperview];
    }];
}

#pragma mark -- 隐藏图片
- (void)hideImageView
{
    LJPhotoView *cell = [self viewWithTag:baseIndex + self.currentPhotoIndex];
    [UIView animateWithDuration:0.3 animations:^{
        [cell.ljImageview setFrame:self.originFrame];
    } completion:^(BOOL finished) {
        self.backgroundColor = [UIColor whiteColor];
        [self removeFromSuperview];
    }];
}
@end
