//
//  ViewController.m
//  LYYInfiniteScrollView
//
//  Created by lieyunye on 2017/2/15.
//  Copyright © 2017年 lieyunye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int currentIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 5;
    [self addSubViewWithName:[NSString stringWithFormat:@"%d",3] atPosition:0];
    for (int i = 0; i < self.count - 1; i++) {
        [self addSubViewWithName:[NSString stringWithFormat:@"%d",i] atPosition:i+1];
    }
    [self addSubViewWithName:[NSString stringWithFormat:@"%d",0] atPosition:5];
    self.scrollView.contentSize = CGSizeMake((self.count + 1) * CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.scrollView.bounds));
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.bounds), 0) animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSubViewWithName:(NSString *)name atPosition:(int)position {
    // add image to scroll view
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:50];
    label.text = name;
    label.frame = CGRectMake(position*CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.scrollView.bounds));
    [self.scrollView addSubview:label];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger newIndex = floor((scrollView.contentOffset.x) / CGRectGetWidth([UIScreen mainScreen].bounds))- 1;
    if (newIndex < 0) {
        newIndex = self.count - 2;
    }
    if (newIndex > self.count - 2) {
        newIndex = self.count - 2;
    }
    self.currentIndex = newIndex;
    
    CGFloat spliteX =(scrollView.contentOffset.x / CGRectGetWidth([UIScreen mainScreen].bounds) - 1) ;
    
    if (spliteX >= 0) {
        spliteX -= self.currentIndex;
        spliteX = 1 - spliteX;
    }else {
        spliteX = fabs(spliteX);
    }
    NSInteger rightIndex = newIndex + 1;

    if (rightIndex > self.count - 2) {
        rightIndex = 0;
    }
    NSLog(@"offsetX  %f, %f currentIndex %d %d",scrollView.contentOffset.x,spliteX,self.currentIndex, rightIndex);

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    // The key is repositioning without animation
    if (scrollView.contentOffset.x == 0) {
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.bounds) * (self.count - 1), 0) animated:NO];
    }
    else if (scrollView.contentOffset.x == CGRectGetWidth(self.view.bounds) * (self.count)) {
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.bounds), 0) animated:NO];
        
    }
    
//    NSLog(@"currentIndex %d",self.currentIndex);

    
}

@end
