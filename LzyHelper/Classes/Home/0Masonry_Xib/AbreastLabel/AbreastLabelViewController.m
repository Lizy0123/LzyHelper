//
//  AbreastLabelViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "AbreastLabelViewController.h"

@interface AbreastLabelViewController ()
@property(strong, nonatomic)UILabel *labelLeft;
@property(strong, nonatomic)UILabel *labelRight;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation AbreastLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
#pragma mark - UI
-(void)configUI{
    self.labelLeft = [UILabel new];
    self.labelLeft.backgroundColor = [UIColor yellowColor];
    self.labelLeft.text = @"Label+";
    [self.contentView addSubview:self.labelLeft];

    self.labelRight = [UILabel new];
    self.labelRight.backgroundColor = [UIColor redColor];
    self.labelRight.text = @"Label+";
    [self.contentView addSubview:self.labelRight];

    //添加约束
    [self.labelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.height.equalTo(@50);
    }];

    [self.labelRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelLeft.mas_right).offset(2);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        //右边的间隔保持大于等于2，注意是lessThanOrEqual
        //这里的“lessThanOrEqualTo”放在从左往右的X轴上考虑会更好理解。
        //即：labelRight的右边界的X坐标值“小于等于”containView的右边界的X坐标值。
        make.right.lessThanOrEqualTo(self.contentView.mas_right).with.offset(-2);
        make.height.equalTo(@50);
    }];

    //设置labelLeft的content的Hugging和Compression为1000
    [self.labelLeft setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.labelLeft setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    //设置labelRight的content的Hugging为1000和Compression为250
    [self.labelRight setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.labelRight setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}


#pragma mark - Action

- (IBAction)addLabelContent:(UIStepper *)sender {
    switch (sender.tag) {
        case 0:
            self.labelLeft.text = [self configContentWithCount:(NSUInteger)sender.value];
            break;
        case 1:
            self.labelRight.text = [self configContentWithCount:(NSUInteger)sender.value];
            break;
        default:
            break;
    }

}
-(NSString *)configContentWithCount:(NSInteger)count{
    NSMutableString *str = [NSMutableString new];
    for (NSInteger i = 0; i<= count; i++) {
        [str appendString:@"Label+"];
    }return str.copy;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
