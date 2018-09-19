//
//  ViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/23.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "ViewController.h"
#import "Helper_Device.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//    [[DeviceHelper sharedInstance] location:^(CLPlacemark *location, NSString *desc) {
//        if (location) {
//            NSLog(@"%@", [NSString stringWithFormat:@"%@\n%@",location.name,location.thoroughfare]);
//            NSLog(@"成功%@",desc);
//        }else {
//            NSLog(@"失败%@",desc);
//
//        }
//    }];

}

-(void)configHtmlLabel{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    NSString * htmlStr = @"<span style=\"color:#666666\">项目类型：本项目属于债权转让类型。</span></p ><p style=\"line-height:25px\"><span style=\"color:#666666\"><br/></span></p ><p style=\"line-height:25px\"><span style=\"color:#666666\">项目介绍：公司短期资金周转。</span></p ><p><span style=\"color:#666666\">本次借款主要用于企业资金周转，原借款金额为180万人民币，借款期限6个月。</span></p ><p><span style=\"color:#666666\">本项目金额180万元，分多期上线，本期3万元。</span></p ><p><span style=\"color:#666666\">还款来源：</span></p ><p><span style=\"color:#666666\">第一还款来源：公司项目回款</span></p ><p><span style=\"color:#666666\">第二还款来源：企业应收账款</span></p ><p><span style=\"color:#666666\">第三还款来源：兆坤集团无限连带责任担保本息</span></p ><p><span style=\"color:#666666\">第四还款来源：余易贷使用风险备用金垫付</span></p ><p><span style=\"color:#666666\"><br/></span></p ><p><strong><span style=\"font-family:宋体;color:#666666\">风控意见：</span></strong></p ><p><span style=\"color:#666666\"><span style=\"font-family: 宋体, SimSun; line-height: 24px;\">本项目属优质、低风险项目，予以上线通过。本项目计划分多次转让，本次转让为第一次转让，期限为7天。</span></span></p ><p><br/></p ><p><br/>";
    NSAttributedString  * attStr = [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    label.attributedText = attStr;
    label.numberOfLines = 0;
    [self.view addSubview:label];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    MasonryViewController * vc = [[MasonryViewController alloc] init];
//    [self presentViewController: vc animated:YES completion:^{
//
//    }];
}
@end
