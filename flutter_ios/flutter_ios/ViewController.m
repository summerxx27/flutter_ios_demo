//
//  ViewController.m
//  ios_flutter_demo
//
//  Created by summerxx on 2023/1/28.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <Flutter/Flutter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}

- (void)setupViews
{
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    test.backgroundColor = UIColor.blueColor;
    [test setTitle:@"Test Flutter" forState:UIControlStateNormal];
    [self.view addSubview:test];

    [test mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];

    [[test rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"按钮被点击了");

        FlutterViewController *vc = [[FlutterViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}
@end
