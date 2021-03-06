//
//  FileTXT.m
//  HowToWorks
//
//  Created by h on 17/3/16.
//  Copyright © 2017年 bill. All rights reserved.
//

#import "FileTXT.h"
#import "Lock.h"
@interface FileTXT(){

    NSString * txtpath;
    NSString * upload_data_path;
    Lock   *_lock;
      
}
@end

@implementation FileTXT

static FileTXT * _instance = nil;

+(instancetype) shareInstance;
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance;
}

- (id)init
{
    
    self = [super init];
    
    if (self)
    {
        txtpath = nil;
        upload_data_path = nil;
        _lock = [Lock shareInstance];
    }
    
    return self;
}

-(BOOL)TXT_Open:(NSString*)name
{
    @synchronized (_lock) {
        
        NSFileManager *fm = [NSFileManager defaultManager];
//        if (self.pathType == Upload_Data_Type ) {
//            upload_data_path = name;
//        }
//        else
//        {
            txtpath = name;
//        }
//        
        if(![fm fileExistsAtPath:name])
        {
            [fm createFileAtPath:name contents:nil attributes:nil];
            return YES;
        }
        return NO;
    }
}
-(void)TXT_Write:(NSString*)line
{
    @synchronized (_lock) {
        
//        if (self.pathType == Upload_Data_Type ) {
//            if (upload_data_path!=nil) {
//                NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:upload_data_path];
//                [file seekToEndOfFile];
//                [file writeData:[line dataUsingEncoding:NSUTF8StringEncoding]];
//                [file closeFile];
//            }
//        }
//        else{
            if (txtpath!=nil) {
                NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:txtpath];
                [file seekToEndOfFile];
                [file writeData:[line dataUsingEncoding:NSUTF8StringEncoding]];
                [file closeFile];
            }
//        }
//       
    }
}


-(NSString*)TXT_Read
{
    NSString *str = nil;
    
//    if (self.pathType == Upload_Data_Type ) {
//       
//        if(upload_data_path!=nil)
//        {
//            NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:upload_data_path];
//            [file seekToFileOffset:0];
//            NSData *data = [file readDataToEndOfFile];
//            str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            [file closeFile];
//        }
//    }
//    else{
        if(txtpath!=nil)
        {
            NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:txtpath];
            [file seekToFileOffset:0];
            NSData *data = [file readDataToEndOfFile];
            str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [file closeFile];
        }
//    }
    
    return str;
}



@end
