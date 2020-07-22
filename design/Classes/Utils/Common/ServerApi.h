//
//  ServerApi.h
//
//
//  Created by William on 15/3/23.
//
//

#import <Foundation/Foundation.h>

extern NSString *Base_URL_Project;
extern NSString *Base_URL_H5;

/**登录*/
extern NSString *const Api_Login;
/**退出登录*/
extern NSString *const Api_Signout;
/**我的项目*/
extern NSString *const Api_MyProject;
/**文件列表*/
extern NSString *const Api_FileList;
/**文件历史列表*/
extern NSString *const Api_FileHistoryList;
/**批量下载*/
extern NSString *const Api_FileBatchLoading;
/**历史文件批量下载*/
extern NSString *const Api_FileHistoryBatchLoading;
/**软装及材料列表*/
extern NSString *const Api_DecorationList;
/**一键下载*/
extern NSString *const Api_DownLoadAll;
/**进度百分比*/
extern NSString *const Api_PercentageOfProgress;
/**进度日历列表*/
extern NSString *const Api_ScheduleList;
/**进度日历详情*/
extern NSString *const Api_ScheduleDetail;
/**新提醒状态列表*/
extern NSString *const Api_RemindStatusList;
/**变更提醒状态*/
extern NSString *const Api_UpdateRemindStatus;
/**查询概念，平面，效果图的pdf文件列表*/
extern NSString *const Api_PreviewList;
/**变更日程列表*/
extern NSString *const Api_ChangeScheduleList;
/**变更日程详情*/
extern NSString *const Api_ChangeScheduleDetail;
/**变更日程文件*/
extern NSString *const Api_ChangeScheduleFileList;

@interface ServerApi : NSObject

/**设置服务器环境*/
- (void)setupBaseUrl;

@end

