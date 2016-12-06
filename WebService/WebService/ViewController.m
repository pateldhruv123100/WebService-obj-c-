//
//  ViewController.m
//  WebService
//
//  Created by i mac meridian on 11/26/16.
//  Copyright © 2016 i mac meridian. All rights reserved.
//

#import "ViewController.h"
#import "SecondVC.h"
#import "ThirdViewController.h"
#import "AFNetworking.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController{
    NSDictionary *dict;
    UILabel *lblTatitude;
    UILabel *lblName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableVC.estimatedRowHeight = 500.0;
    _tableVC.rowHeight= UITableViewAutomaticDimension;
    NSString *URL =[NSString stringWithFormat:@"http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"];
    NSURLSessionConfiguration* sessionConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession* session=[NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *requestURL=[NSURL URLWithString:URL];
    
    NSURLSessionDataTask* sessionTask=[session dataTaskWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                       {
                                           if(data)
                                           {
                                               dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                           }
                                       }];
    
    [sessionTask resume];
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dict[@"actors"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *Cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    lblTatitude = (UILabel * )[Cell viewWithTag:100];
    lblTatitude.text = [NSString stringWithFormat:@"%@",dict[@"actors"][indexPath.row][@"children"]];
    NSLog(@"%@", lblTatitude);
    lblName = (UILabel * )[Cell viewWithTag:200];
    lblName.text = [NSString stringWithFormat:@"%@", dict[@"actors"][indexPath.row][@"description"]];
    NSLog(@"%@", lblName);
  
    //
    UIImageView *imageVC = (UIImageView *)[Cell viewWithTag:300];
    NSString *imageNamed = [NSString stringWithFormat:@"%@",dict[@"actors"][indexPath.row][@"image"]];
   // imageVC.image = [UIImage imageWithContentsOfURL:imageNamed];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageNamed]];
    imageVC.image=[UIImage imageWithData:data];
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *DicData = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",dict[@"actors"][indexPath.row][@"image"]],@"ImageData", nil];
    ThirdViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdViewController"];    VC.Dict=DicData;
    [self.navigationController pushViewController:VC animated:YES];
    NSLog(@"%ld",(long)indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
