//
//  ServerApi.h
//
//
//  Created by William on 15/3/23.
//
//

#import <Foundation/Foundation.h>

/**本地服务器路径*/
//extern NSString *const Base_URL_Project;
//extern NSString *const Base_URL_H5;

extern NSString *Base_URL_Project;
extern NSString *Base_URL_H5;

/***************************个人相关**********************************/
/**版本、审核*/
extern NSString *const Api_CheckVersions;
/**登录*/
extern NSString *const Api_Login;
/**手机验证码登录*/
extern NSString *const Api_LoginMsgCode;
/**获取图形验证码*/
extern NSString *const Api_Captcha;
/**获取短信验证码*/
extern NSString *const Api_VerifyCode;
/**检验短信验证码*/
extern NSString *const Api_CheckVerifyCode;
/**注册手机号码*/
extern NSString *const Api_registerPhone;
/**忘记密码*/
extern NSString *const Api_ResetUserPassword;
/**获取用户基础信息*/
extern NSString *const Api_UserBaseInfo;
/**重设手机号*/
extern NSString *const Api_ModifyUserMobile;
/**修改手机号码*/
extern NSString *const Api_ModifyPassword;
/**上传图片*/
extern NSString *const Api_UploadImage;
/**根据关键字搜索医院列表*/
extern NSString *const Api_HospitalList;
/**根据科室列表*/
extern NSString *const Api_departmentList;
/**修改用户信息*/
extern NSString *const Api_UpdateUserBaseInfo;
/**在线反馈*/
extern NSString *const Api_Feedback;
/**修改邮箱*/
extern NSString *const Api_UpdateEmail;
/**修改姓名*/
extern NSString *const Api_UpdateUserCompellation;
/**修改机构名称*/
extern NSString *const Api_UpdateCompayName;
/**修改部门名称*/
extern NSString *const Api_UpdateDepartmentName;
/**查看用户信息*/
extern NSString *const Api_SelectUserBaseInfoByUserId;
/**修改身份类型*/
extern NSString *const Api_UserIdentityType;
/**升级版上传图片*/
extern NSString *const Api_UploadImageSingle;
/**上传附件*/
extern NSString *const Api_UploadFiles;
/**查询图片*/
extern NSString *const Api_CheckImageSingle;
/**更换手机号*/
extern NSString *const Api_UpdatePhone;
/**验证密码的准确性*/
extern NSString *const Api_CheckPwd;
/**检查手机号是否存在*/
extern NSString *const Api_CheckPhoneExist;
/**获取用户订阅学科疾病*/
extern NSString *const Api_SubjectDiseaseSubscribe;
/**获取用户订阅学科疾病*/
extern NSString *const Api_InsertSubjectDiseaseSubscribe;


/***************************项目相关**********************************/
/**项目列表*/
extern NSString *const Api_ProjectList;
/**关联项目列表*/
extern NSString *const Api_ListMyProject;
/**疾病树形结构*/
extern NSString *const Api_DiseaseTree;

/**查询用户研究中心角色*/
extern NSString *const Api_ResearchCenterRole;
/**查询用户研究中心列表*/
extern NSString *const Api_ResearchCenterList;
/**获取城市列表*/
extern NSString *const Api_CityList;
/**获取项目、合作*/
extern NSString *const Api_ProjectAndCooperationList;
/**我的项目*/
extern NSString *const Api_MyProjectList;
/**删除我的项目*/
extern NSString *const Api_DeleteMyProjectList;
/**修改我的合作详情中的项目阶段*/
extern NSString *const Api_UpdateProjectStatus;
/**我的发布*/
extern NSString *const Api_MyCooperationList;
/**删除我的发布*/
extern NSString *const Api_DeleteMyCooperation;
/**项目详情*/
extern NSString *const Api_ProjectDetailInfo;
/**申请加入项目：通过资料*/
extern NSString *const Api_ApplyProjectByInfo;
/**申请加入项目：是否已经收到限制*/
extern NSString *const Api_CheckVerifySnLimitedByCode;
/**申请加入项目：通过邀请码*/
extern NSString *const Api_ApplyProjectByCode;
/**查询项目合作列表（根据外链项目ID查询）*/
extern NSString *const Api_SearchProjectByRelateProjectId;
/**创建合作意向*/
extern NSString *const Api_CreateCooperationRequirement;
/**发布合作*/
extern NSString *const Api_CreateCooperation;
/**上传附件*/
extern NSString *const Api_AddFeedback;
/**是否可以关联项目权限判断*/
extern NSString *const Api_RelateJurisdiction;
/**收藏*/
extern NSString *const Api_AddFavorite;
/**取消收藏*/
extern NSString *const Api_CancelFavorite;
/**查询我的收藏*/
extern NSString *const Api_MyFavoriteList;
/**删除收藏*/
extern NSString *const Api_DeleteProjectFavorite;
/**置顶*/
extern NSString *const Api_StickMyProject;
/**取消置顶*/
extern NSString *const Api_CancelStickMyProject;
/**添加项目默认登录*/
extern NSString *const Api_AddProjectDefaultLogin;
/**删除项目默认登录*/
extern NSString *const Api_DeleteProjectDefaultLogin;
/**查询项目默认登录*/
extern NSString *const Api_SearchProjectDefaultLogin;
/**获取计划入组数、实际入组数*/
extern NSString *const Api_SelectInvestigationByProjectName;

/***************************病例相关**********************************/
/**查看配置字段*/
extern NSString *const Api_CaseConfigurationField;
/**病例列表*/
extern NSString *const Api_CaseList;
/**提交病例*/
extern NSString *const Api_CaseSubmit;
/**删除病例*/
extern NSString *const Api_CaseDelete;
/**打回病例*/
extern NSString *const Api_CaseBack;
/**获取病例基本信息*/
extern NSString *const Api_BaseCase;
/**新建病例*/
extern NSString *const Api_InsertCase;
/**编辑病例*/
extern NSString *const Api_EditCase;

/***************************权限相关**********************************/
/**查询权限*/
extern NSString *const Api_SearchRight;

/***************************访视相关**********************************/
/**访视列表*/
extern NSString *const Api_InterviewList;
/**提交访视*/
extern NSString *const Api_CommitInterview;
/**删除访视*/
extern NSString *const Api_deleteInterview;
/**打回访视*/
extern NSString *const Api_backInterview;
/**获取CrfValue */
extern NSString *const Api_SearchCrfValue;
/**获取访视类型*/
extern NSString *const Api_VisitType;
/**新建访视*/
extern NSString *const Api_CreateInterview;
/**修改访视名字和备注*/
extern NSString *const Api_UpdateVisitTimeAndComment;
/**获取录音列表*/
extern NSString *const Api_RecordList;
/**删除录音*/
extern NSString *const Api_RecordDelete;
/**修改录音名称*/
extern NSString *const Api_RecordReName;
/**添加录音记录*/
extern NSString *const Api_RecordAddKey;
/**上传录音记录*/
extern NSString *const Api_UploadAttachment;
/**添加录音记录*/
extern NSString *const Api_addRecordkey;

/***************************CRF相关**********************************/
/**获取crf列表*/
extern NSString *const Api_CrfList;
/**获取crf详情*/
extern NSString *const Api_CrfDetail;
/**获取指标数据*/
extern NSString *const Api_IndexValue;
/**保存数据*/
extern NSString *const Api_SaveCrfData;
/**标记是否sdv*/
extern NSString *const Api_MarkCrfSDV;
/**标记是否已经清理*/
extern NSString *const Api_MarkCrfClean;
/**关联知识库的数据源*/
extern NSString *const Api_RelevanceKnowledgeData;
/**crf或者crf附件的上传附件*/
extern NSString *const Api_CrfAccessoryUpload;

/******************************图表*******************************/
/**入组趋势*/
extern NSString *const Api_TendencyGroup;
/**入组总数排行*/
extern NSString *const Api_TotalRank;
/**描述性分析指标个数*/
extern NSString *const Api_QuotaAnalyse;
/**描述性分析指标详情*/
extern NSString *const Api_QuotaInformation;
/**图表的外层列表r*/
extern NSString *const Api_DashboardTabs;
/**获取tmpCollection*/
extern NSString *const Api_DashboardTmpCollection;
/**获取listInvestigationChartsItem*/
extern NSString *const Api_DashboardListInvestigationChartsItem;
/**获取dashboard的每个图表的具体数据*/
extern NSString *const Api_DashboardChartsItemReportData;
/**获取筛选条件*/
extern NSString *const Api_DashboardPatientFilterCodes;
/**获取筛选条件搜索*/
extern NSString *const Api_DashboardQueryKnowledgeFuzzy;
/**获取生存曲线的url*/
extern NSString *const Api_Survivalplots;


/***************************留言相关**********************************/
/**我的留言*/
extern NSString *const Api_MyMsg;
/**项目留言*/
extern NSString *const Api_CooMsg;

/***************************服务相关**********************************/
/**服务相关*/
extern NSString *const Api_Service;
/**技术支持历史*/
extern NSString *const Api_QueryTechnicalSupportHistory;

/**四大板块介绍*/
extern NSString *const Api_AppIntroduce;
/**分享*/
extern NSString *const Api_AppShare;
/**获取通知明细*/
extern NSString *const Api_NotificationDetail;
/**通知项目列表*/
extern NSString *const Api_NotificationProjectList;
/**通知合作列表*/
extern NSString *const Api_NotificationCooperationList;
/**通知批量删除*/
extern NSString *const Api_NotificationDelete;
/**通知批量已读*/
extern NSString *const Api_NotificationRead;
/**通知未读*/
extern NSString *const Api_NotificationUnRead;
/**通知未读数量*/
extern NSString *const Api_NotificationUnReadCount;
/**清空角标*/
extern NSString *const Api_NotificationClearUserAppBadge;
/**检查访视提醒对应的访视或病例是否创建过*/
extern NSString *const Api_NotificationVisitExist;
/**检查CRF提醒对应的访视或者病例是否创建过*/
extern NSString *const Api_NotificationCrfExist;

@interface ServerApi : NSObject

/**获取服务器列表*/
- (NSMutableArray*)baseUrlList;
/**设置服务器:debug环境*/
- (BOOL)setupDebugBaseUrl:(NSInteger)index;
/**设置服务器:release环境*/
- (void)setupReleaseBaseUrl;

@end

