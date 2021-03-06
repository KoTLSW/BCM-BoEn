//
//  LoginWindow.m
//  BCM
//
//  Created by xhkj on 2018/2/7.
//  Copyright © 2018年 macjinlongpiaoxu. All rights reserved.
//

#import "LoginWindow.h"
#import "Common.h"


@interface LoginWindow ()
{
    NSMutableDictionary *m_Dic;
    
    IBOutlet NSButton *singleTestButton;
    
    IBOutlet NSButton *nullTestButton;
    
    IBOutlet NSButton *LoopTestButton;
    
    IBOutlet NSButton *SfcUploadButton;
    
    IBOutlet NSButton *PdcaUploadButton;
    
    IBOutlet NSButton *test_mode_button;  
    IBOutlet NSButton *updata_Button;
    IBOutlet NSButton *config_button;
    
    
    IBOutlet NSButton *AUTO_Button;
    IBOutlet NSButton *Manual_Button;
    IBOutlet NSButton *test_40_Data_button;
    IBOutlet NSTextField *set_times_TF;
    
    
}
@end

@implementation LoginWindow

-(id)init
{
    self = [super initWithWindowNibName:@"LoginWindow"];
    return self;
}


- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}



- (IBAction)choose_TestMode:(id)sender {
    
    
    NSButton   * button = sender;
    
    if ([button.title isEqualToString:@"SingleTest"]) {
        
        if (singleTestButton.state) {
            
            nullTestButton.state = NO;
            LoopTestButton.state = NO;
        }
        
    }
    
    if ([button.title isEqualToString:@"NullTest"]) {
        
        if (nullTestButton.state) {
            
            singleTestButton.state = NO;
            LoopTestButton.state   = NO;
        }
        
    }
    if ([button.title isEqualToString:@"LoopTest"]) {
        
        if (LoopTestButton.state) {
            
            singleTestButton.state = NO;
            nullTestButton.state = NO;
        }
    }
    
    if ([button.title isEqualToString:@"自动扫码"]) {
        
        if (AUTO_Button.state) {
            
            Manual_Button.state = NO;
        }
        
    }
    
    if ([button.title isEqualToString:@"手动扫码"]) {
        
        if (Manual_Button.state) {
            
            AUTO_Button.state = NO;
        }
        
    }
    
    
    
    
}




- (IBAction)clickToLogin:(NSButton *)sender
{
  
    if ([_userName.stringValue isEqualToString:@"admin"]&&[_passWord.stringValue isEqualToString:@"admin123"]) {
        
        if (test_mode_button.state) {
            
            
            if (nullTestButton.state) {  //空测试
                [[NSNotificationCenter defaultCenter] postNotificationName:kNullTestNotice object:@"YES"];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNullTestNotice object:@"NO"];
            }
            if (LoopTestButton.state) {  //循环测试
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoopTestNotice object:@"YES"];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoopTestNotice object:@"NO"];
            }

        }
        
        
        if (updata_Button.state) {
            
            if (SfcUploadButton.state) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kSfcUploadNotice object:@"YES"];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kSfcUploadNotice object:@"NO"];
            }
            if (PdcaUploadButton.state) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kPdcaUploadNotice object:@"YES"];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:kPdcaUploadNotice object:@"NO"];
                
            }
        }

        
        if (config_button.state) {
            
            if (Manual_Button.state) {
             
                [[NSNotificationCenter defaultCenter] postNotificationName:kManualScanQRCode object:nil];
                
            }
            if (AUTO_Button.state) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kAutoScanQRCode object:nil];
            }
            
        }
        
        if (test_40_Data_button.state) {
            
             [[NSNotificationCenter defaultCenter] postNotificationName:kTest40DataNotice object:@"YES"];
        }
        else
        {
             [[NSNotificationCenter defaultCenter] postNotificationName:kTest40DataNotice object:@"NO"];
        }
        
        if ([set_times_TF.stringValue length]>0) {
            
            
            NSString  * numString = [set_times_TF stringValue];
            if (numString.length > 0&&[self isPureNumandCharacters:numString]) {
                
                //将字符串存入本地
                [[NSUserDefaults standardUserDefaults] setValue:numString forKey:kFoamNum];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self.window orderOut:self];
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _logInfo.stringValue = @"请输入纯数字!!";
                    _logInfo.textColor = [NSColor redColor];
                });
            }
           
        }
    
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            _logInfo.stringValue = @"userName or passWord error!!";
            _logInfo.textColor = [NSColor redColor];
        });
    }

}


- (IBAction)show_other_button:(id)sender {
    
    NSButton  *  button = sender;
    
    if ([button.title isEqualToString:@"Mode"]) {
        
        if (button.state) {
            singleTestButton.enabled = YES;
            nullTestButton.enabled = YES;
            LoopTestButton.enabled = YES;
        }
        else
        {
            singleTestButton.enabled = NO;
            nullTestButton.enabled = NO;
            LoopTestButton.enabled = NO;
        }
    }
    
    if ([button.title isEqualToString:@"Data"]) {
        
        if (button.state) {
            SfcUploadButton.enabled = YES;
            PdcaUploadButton.enabled = YES;
        }
        else
        {
            SfcUploadButton.enabled = NO;
            PdcaUploadButton.enabled = NO;
        }
    }
    
    if ([button.title isEqualToString:@"Cfig"]) {
        
        if (button.state) {
            
            Manual_Button.enabled = YES;
            AUTO_Button.enabled   = YES;
        }
        else
        {
            Manual_Button.enabled = NO;
            AUTO_Button.enabled   = NO;
           
        }
    }
    
    if ([button.title isEqualToString:@"Test"]) {
        
        if (button.state) {
            
            test_40_Data_button.enabled = YES;
        }
        else
        {
          
            test_40_Data_button.enabled = NO;
        }
    }
    
}










- (BOOL)isPureNumandCharacters:(NSString *)string
{
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];

    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}



- (IBAction)clockToCancel:(NSButton *)sender
{
    
    [self.window orderOut:self];
}

@end
