//
//  FileTXT.h
//  HowToWorks
//
//  Created by h on 17/3/16.
//  Copyright © 2017年 bill. All rights reserved.
//

#import <Foundation/Foundation.h>


// 指定的检查类型
enum Log_Path_Type
{
    TestMessage_Log_Type,
    Upload_Data_Type,
};

@interface FileTXT : NSObject
@property(nonatomic,assign)enum Log_Path_Type pathType;

+(instancetype) shareInstance;
-(BOOL)TXT_Open:(NSString*)name ;
-(void)TXT_Write:(NSString*)line;
-(NSString*)TXT_Read;
@end
