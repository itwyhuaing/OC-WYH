//
//  RSAController.m
//  SafetyDemo
//
//  Created by hnbwyh on 2020/7/22.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "RSAController.h"
#import "RSA.h"

@interface RSAController ()

@end

@implementation RSAController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *publickKey    = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyAzETDh6Cm19z/3HcFohhhjLAV/+3RfTlnW0PZj/84/kfVC1EVUrEI/FYdsXyBmftetL6D/I6y2lojuy09SoUvpO5ONWiO2+dK+ekdjoP4lq4NBUy4+mNiuHxida6RGUR3STXMjBm3BaCzYe98Nu2tZ/AqDM3YlJNFTJIqVbDGQIDAQAB";
    NSString *privateKey    = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALIDMRMOHoKbX3P/cdwWiGGGMsBX/7dF9OWdbQ9mP/zj+R9ULURVSsQj8Vh2xfIGZ+160voP8jrLaWiO7LT1KhS+k7k41aI7b50r56R2Og/iWrg0FTLj6Y2K4fGJ1rpEZRHdJNcyMGbcFoLNh73w27a1n8CoMzdiUk0VMkipVsMZAgMBAAECgYAkk5dPzQTj3Tz9vq0Mhey77TEcaHh4lf09+Nzh3yaitc0IbOloMwZLyv7aKH1/v2U3XJdhHkmtXwJno4ZroDxm8povnRWkbL9aelCGgn838NapiuObUVYQO5ndvmMgaCGLImYR3aeBPwMAQzHhfTvMY5StgUdDltKJeaW+amCyKQJBAOxxjO4FHDeEVDJ58QZipWx1IKC6jCtzFX/YqCu0AMIbGp7q8MjyYSkU9UixR5pOa4HPnwBExxBB/yYEi+MH4IMCQQDAvGxCMqD3HChbqFCPofyw22UhHXhuJGNnWd3zns/0snad52NRTPKaP87f2+LoJodAHJxG2PCkYNQlt3Nj9oMzAkAh41BwmNjneBbdOS77XE4bUlo/zxzh6VeugC3yPZVSPLI/Dqs+EcctLSzOo2IA0raD328JidICGYNpPoOSIYHjAkAHtgImy9vAxzGeKSe/910ivkRXhNRSo8YOVnwYyRvM0G8Kdj10/T0firn+Hs//Nbtnhz2BYCCQkwcp0yMctrodAkByAVhfNcKADtRsAGubMNBVsxdQeX8o2ReRyzFpa7bXuEf+QvM6TZ+Nm+DMXLO4bh15xdDEA/hYcTKLpLKAyt5s";
    
    NSString *originalData  = @"iOS端RSA加密原始数据";
    // 公钥加密
    NSString *encryptString = [RSA encryptString:originalData publicKey:publickKey];
    // 私钥解密
    NSString *decrypeString = [RSA decryptString:encryptString privateKey:privateKey];
    NSLog(@"\n 【原始数据】:\n%@\n\n【公钥加密私钥解密之后数据】：\n%@\n",originalData,decrypeString);
    
}

@end
