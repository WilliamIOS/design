//
//  ServerApi.m
//
//
//  Created by William on 15/3/23.
//
//

#import "ServerApi.h"

NSString * Base_URL_Project = @"";
NSString *Base_URL_H5 = @"";


/**登录*/
NSString *const Api_Login = @"loginAPP";
NSString *const Api_Signout = @"logoutWX";
/**我的项目*/
NSString *const Api_MyProject = @"project/projectTask/getListByTel";
/**文件列表*/
NSString *const Api_FileList = @"project/projectFiles/getFileListByProId";
/**文件历史列表*/
NSString *const Api_FileHistoryList = @"project/oldFiles/getOldFile";
/**批量下载*/
NSString *const Api_FileBatchLoading = @"project/projectFiles/reduceAndDownLoad";
/**历史文件批量下载*/
NSString *const Api_FileHistoryBatchLoading = @"project/oldFiles/reduceAndDownLoad";
/**软装及材料列表*/
NSString *const Api_DecorationList = @"project/projectFiles/getDecorationList";
/**一键下载*/
NSString *const Api_DownLoadAll = @"project/projectFiles/reduceAndDownLoadAll";
/**进度百分比*/
NSString *const Api_PercentageOfProgress = @"project/nodeState/getPercentage";
/**进度日历列表*/
NSString *const Api_ScheduleList = @"project/projectSchedule/getProById";
/**进度日历详情*/
NSString *const Api_ScheduleDetail= @"project/projectSchedule/getBodyById";
/**新提醒状态列表*/
NSString *const Api_RemindStatusList = @"project/updatename/getListByProIdAndStatus";
/**变更提醒状态*/
NSString *const Api_UpdateRemindStatus = @"project/updatestatus";
/**查询概念，平面，效果图的pdf文件列表*/
NSString *const Api_PreviewList = @"project/projectFiles/getpdfFilesList";
/**变更日程列表*/
NSString *const Api_ChangeScheduleList = @"project/changeschedule/getProById";
/**变更日程详情*/
NSString *const Api_ChangeScheduleDetail = @"project/changeschedule/getChangeById";
/**变更日程文件*/
NSString *const Api_ChangeScheduleFileList = @"project/files/getChangeFiles";
/**项目通讯录*/
NSString *const Api_CommunicationList = @"project/communication/getProById";
/**上传变更日程的图片文件*/
NSString *const Api_UploadImgFile = @"project/changeschedule/uploadImgFile";
/**新增变更日程*/
NSString *const Api_ScheduleInsert = @"project/changeschedule/saveNew";

@implementation ServerApi

/**设置服务器:上线IP*/
- (void)setupBaseUrl{
    Base_URL_Project = @"http://wx.banyua.com/";
    Base_URL_H5 = @"http://wx.banyua.com/";
}

@end

