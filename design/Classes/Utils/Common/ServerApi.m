//
//  ServerApi.m
//
//
//  Created by William on 15/3/23.
//
//

#import "ServerApi.h"

/**本地服务器*/
//NSString *const Base_URL_Project = @"http://192.168.10.167:12000/facade/";
//NSString *const Base_URL_H5 = @"http://192.168.10.167:12000/";

/**开发服务器*/
//NSString *const Base_URL_Project = @"http://192.168.10.203:12200/facade/";
//NSString *const Base_URL_H5 = @"http://192.168.10.203:12200/";


/**开发调试服务器*/
//NSString *const Base_URL_Project = @"http://192.168.10.203:10020/facade/";
//NSString *const Base_URL_H5 = @"http://192.168.10.203:10020/";

/**3.0测试环境服务器*/
//NSString *const Base_URL_Project = @"http://wxtestmaster.ydata.org/facade/";
//NSString *const Base_URL_H5 = @"http://wxtestmaster.ydata.org/";

/**5.1测试环境服务器*/
//NSString *const Base_URL_Project = @"http://facade51.ydata.org/facade/";
//NSString *const Base_URL_H5 = @"http://facade51.ydata.org/";

/**模拟生产环境服务器*/
//NSString *const Base_URL_Project = @"http://wxmasteronline.ydata.org/facade/";
//NSString *const Base_URL_H5 = @"http://wxmasteronline.ydata.org/";

/**生产环境服务器*/
//NSString *const Base_URL_Project = @"http://masterwx.medbit.cn/facade/";
//NSString *const Base_URL_H5 = @"http://masterwx.medbit.cn/";

NSString * Base_URL_Project = @"";
NSString *Base_URL_H5 = @"";

/***************************个人相关**********************************/
/**版本、审核*/
NSString *const Api_CheckVersions = @"app/queryVersionInfoForIOS.do";
/**登录*/
NSString *const Api_Login = @"app/userLogin.do";
/**手机验证码登录*/
NSString *const Api_LoginMsgCode = @"app/userLoginByVerifyCode.do";
/**获取图形验证码*/
NSString *const Api_Captcha = @"app/captcha.do";
/**获取短信验证码*/
NSString *const Api_VerifyCode = @"app/verifyCode.do";
/**检验短信验证码*/
NSString *const Api_CheckVerifyCode = @"app/checkVerifyCode.do";
/**注册手机号码*/
NSString *const Api_registerPhone = @"app/registFromMobile.do";
/**忘记密码*/
NSString *const Api_ResetUserPassword = @"app/resetUserPassword.do";
/**获取用户基础信息*/
NSString *const Api_UserBaseInfo = @"app/selectUserBaseInfo.do";
/**修改手机号*/
NSString *const Api_ModifyUserMobile = @"app/modifyUserMobile.do";
/**修改密码*/
NSString *const Api_ModifyPassword = @"app/modifyPassword.do";
/**上传图片*/
NSString *const Api_UploadImage = @"obj/uploadImage.do";
/**根据关键字搜索医院列表*/
NSString *const Api_HospitalList = @"app/queryHospitalByProvCityAndName.do";
/**根据科室列表*/
NSString *const Api_departmentList = @"app/list.do";
/**修改用户信息*/
NSString *const Api_UpdateUserBaseInfo = @"app/updateUserInfo.do";
/**在线反馈*/
NSString *const Api_Feedback = @"app/createTechnicalSupport.do";
/**修改邮箱*/
NSString *const Api_UpdateEmail = @"app/modifyEmail.do";
/**修改姓名*/
NSString *const Api_UpdateUserCompellation = @"app/modifyUserCompellation.do";
/**修改机构名称*/
NSString *const Api_UpdateCompayName = @"app/updateUserCompayName.do";
/**修改部门名称*/
NSString *const Api_UpdateDepartmentName = @"app/updateUserDepartmentName.do";
/**查看用户信息*/
NSString *const Api_SelectUserBaseInfoByUserId = @"app/selectUserBaseInfoByUserId.do";
/**修改身份类型*/
NSString *const Api_UserIdentityType = @"app/updateUserIdentityType.do";
/**升级版上传图片*/
NSString *const Api_UploadImageSingle = @"app/uploadUserImage.do";
/**查询图片*/
NSString *const Api_CheckImageSingle = @"app/searchUserImage.do";
/**上传附件*/
NSString *const Api_UploadFiles = @"app/uploadFiles.do";

/**更换手机号*/
NSString *const Api_UpdatePhone = @"app/modifyUserMobileByPwd.do";
/**检查手机号是否存在*/
NSString *const Api_CheckPhoneExist = @"app/checkUserMobileExist.do";
/**验证密码的准确性*/
NSString *const Api_CheckPwd = @"app/checkUserMobileByPwd.do";

/**获取用户订阅学科疾病*/
NSString *const Api_SubjectDiseaseSubscribe = @"app/searchUserSubjectDiseaseSubscribe.do";
/**获取用户订阅学科疾病*/
NSString *const Api_InsertSubjectDiseaseSubscribe = @"app/addUserSubjectDiseaseSubscribe.do";

/**上传附件*/
NSString *const Api_AddFeedback = @"app/addFeedback.do";

/***************************项目相关**********************************/
/**项目列表*/
NSString *const Api_ProjectList = @"app/listSubjectProject.do";
/**真实项目列表*/
NSString *const Api_ListMyProject = @"project/listMyProject.do";
/**疾病树形结构*/
NSString *const Api_DiseaseTree = @"app/querySubjectDiseaseTree.do";

/**查询用户研究中心角色*/
NSString *const Api_ResearchCenterRole = @"investigation/listInvestigationRoleByInvestigationIdAndUser.do";

/**查询用户研究中心列表*/
NSString *const Api_ResearchCenterList = @"investigation/listInvestigationSiteByInvestigationIdAndUserAndInvestigationRoleId.do";
/**获取城市列表*/
NSString *const Api_CityList = @"region/queryRegionGroupByPinyin.do";
/**获取项目、合作*/
NSString *const Api_ProjectAndCooperationList = @"project/queryProjectList.do";
/**我的项目*/
NSString *const Api_MyProjectList = @"app/listSubjectProject.do";
/**删除我的项目*/
NSString *const Api_DeleteMyProjectList = @"project/deleteJoinRequirement.do";
/**我的发布*/
NSString *const Api_MyCooperationList = @"project/listMyProjectCooperation.do";
/**删除我的发布*/
NSString *const Api_DeleteMyCooperation = @"project/deleteProjectCooperation.do";
/**修改我的合作详情中的项目阶段*/
NSString *const Api_UpdateProjectStatus = @"project/updateProjectStatus.do";
/**项目详情*/
NSString *const Api_ProjectDetailInfo = @"project/viewProject.do";
/**申请加入项目：通过资料*/
NSString *const Api_ApplyProjectByInfo = @"project/createJoinRequirement.do";
/**申请加入项目：通过邀请码*/
NSString *const Api_ApplyProjectByCode = @"investigation/verifySN.do";
/**申请加入项目：是否已经收到限制*/
NSString *const Api_CheckVerifySnLimitedByCode = @"investigation/checkVerifySnLimited.do";
/**查询项目合作列表（根据外链项目ID查询）*/
NSString *const Api_SearchProjectByRelateProjectId = @"project/searchProjectByRelateProjectId.do";
/**创建合作意向*/
NSString *const Api_CreateCooperationRequirement = @"project/createCooperationRequirement.do";
/**发布合作*/
NSString *const Api_CreateCooperation = @"project/createProject.do";
/**是否可以关联项目权限判断*/
NSString *const Api_RelateJurisdiction = @"roleIntf/checkRoleIsExist.do";
/**收藏*/
NSString *const Api_AddFavorite = @"project/addProjectFavorite.do";
/**取消收藏*/
NSString *const Api_CancelFavorite = @"project/cancelProjectFavorite.do";
/**查询我的收藏*/
NSString *const Api_MyFavoriteList = @"project/queryMyFavoriteProjectList.do";
/**删除收藏*/
NSString *const Api_DeleteProjectFavorite = @"project/deleteProjectFavorite.do";
/**置顶*/
NSString *const Api_StickMyProject = @"project/addProjectTop.do";
/**取消置顶*/
NSString *const Api_CancelStickMyProject = @"project/deleteProjectTop.do";
/**添加项目默认登录*/
NSString *const Api_AddProjectDefaultLogin = @"project/addDefaultLogin.do";
/**删除项目默认登录*/
NSString *const Api_DeleteProjectDefaultLogin = @"project/deleteDefaultLogin.do";
/**查询项目默认登录*/
NSString *const Api_SearchProjectDefaultLogin = @"project/searchDefaultLogin.do";
/**获取计划入组数、实际入组数*/
NSString *const Api_SelectInvestigationByProjectName = @"app/selectInvestigationByProjectName.do";

/***************************病例相关**********************************/
/**查看配置字段*/
NSString *const Api_CaseConfigurationField = @"patient/queryPatientInfoDefineList.do";
/**病例列表*/
NSString *const Api_CaseList = @"patient/searchPatients.do";
/**提交病例*/
NSString *const Api_CaseSubmit = @"patient/commitPatients.do";
/**删除病例*/
NSString *const Api_CaseDelete = @"patient/deletePatients.do";
/**打回病例*/
NSString *const Api_CaseBack = @"patient/turnDownPatients.do";
/**获取病例基本信息*/
NSString *const Api_BaseCase = @"patient/getInvestigationPatientBaseInfo.do";
/**新建病例*/
NSString *const Api_InsertCase = @"patient/addPatient.do";
/**编辑病例*/
NSString *const Api_EditCase = @"crf/modifyPatientData.do";


/***************************权限相关**********************************/
/**查询权限*/
NSString *const Api_SearchRight = @"roleIntf/getRoleAuthorityFromIntfIds.do";

/***************************访视相关**********************************/
/**访视列表*/
NSString *const Api_InterviewList = @"patient/listVisits.do";
/**提交访视*/
NSString *const Api_CommitInterview = @"patient/commitVisit.do";
/**删除访视*/
NSString *const Api_deleteInterview = @"patient/deleteVisit.do";
/**打回访视*/
NSString *const Api_backInterview = @"patient/turnDownVisit.do";
/**获取CrfValue*/
NSString *const Api_SearchCrfValue = @"crf/searchCrfValue.do";
/**获取访视类型*/
NSString *const Api_VisitType = @"patient/searchVisitType.do";
/**新建访视*/
NSString *const Api_CreateInterview = @"patient/addVisit.do";
/**修改访视名字和备注*/
NSString *const Api_UpdateVisitTimeAndComment = @"patient/updateVisit.do";
/**获取录音列表*/
NSString *const Api_RecordList = @"crf/queryModuleDefineAudioByPatient.do";
/**删除录音*/
NSString *const Api_RecordDelete = @"crf/deleteModuleDefineAudio.do";
/**修改录音名称*/
NSString *const Api_RecordReName = @"crf/updateModuleDefineAudioName.do";
/**添加录音记录*/
NSString *const Api_RecordAddKey = @"crf/addModuleDefineAudio.do";
/**上传录音数据*/
NSString *const Api_UploadAttachment = @"obj/uploadAttachment.do";
/**添加录音记录*/
NSString *const Api_addRecordkey = @"crf/addModuleDefineAudio.do";

/***************************crf相关**********************************/
/**获取crf列表*/
NSString *const Api_CrfList = @"crf/queryModuleTreeIsNotFormByName.do";
/**获取crf数据结构*/
NSString *const Api_CrfDetail = @"crf/queryModuleTreeIsCrfByModuleDefineId.do";
/**获取指标数据*/
NSString *const Api_IndexValue = @"crf/searchCrfValue.do";
/**保存数据*/
NSString *const Api_SaveCrfData = @"crf/saveData.do";
/**标记是否sdv*/
NSString *const Api_MarkCrfSDV = @"crf/modifyCrfSdvState.do";
/**标记是否已经清理*/
NSString *const Api_MarkCrfClean = @"crf/modifyCrfState.do";
/**关联知识库的数据源*/
NSString *const Api_RelevanceKnowledgeData = @"medical/queryMedicalCode.do";
/**crf或者crf附件的上传附件*/
NSString *const Api_CrfAccessoryUpload = @"fileData/upLoadCrfFile.do";

/*************************************************************/
/**入组趋势 /*/
NSString *const Api_TendencyGroup = @"invProject/searchPatientGroupTrend.do";
/**入组总数排行*/
NSString *const Api_TotalRank = @"invProject/searchPatientGroupRank.do";
/**描述性分析指标个数*/
NSString *const Api_QuotaAnalyse = @"invProject/searchQuotaAnalyse.do";
/**描述性分析指标详情*/
NSString *const Api_QuotaInformation = @"invProject/searchQuotaInformation.do";
/**图表的外层列表r*/
NSString *const Api_DashboardTabs = @"invProject/listInvestigationCharts.do";
/**获取tmpCollection*/
NSString *const Api_DashboardTmpCollection = @"invProject/searchInvestigationChartsTmpCollection.do";
/**获取listInvestigationChartsItem*/
NSString *const Api_DashboardListInvestigationChartsItem = @"invProject/listInvestigationChartsItem.do";
/**获取dashboard的每个图表的具体数据*/
NSString *const Api_DashboardChartsItemReportData = @"invProject/viewChartsItemReportData.do";
/**获取筛选条件*/
NSString *const Api_DashboardPatientFilterCodes = @"invProject/queryPatientFilterCodes.do";
/**获取筛选条件搜索*/
NSString *const Api_DashboardQueryKnowledgeFuzzy = @"invProject/queryKnowledgeFuzzy.do";
/**获取生存曲线的url*/
NSString *const Api_Survivalplots = @"invProject/getSurvivalplotsImage.do";


/***************************留言相关**********************************/
/**我的留言*/
NSString *const Api_MyMsg = @"project/listMyCooperationRequirement.do";
/**项目留言*/
NSString *const Api_CooMsg = @"project/listCooperationRequirement.do";

/***************************服务相关**********************************/
/**服务相关*/
NSString *const Api_Service = @"app/createTechnicalSupport.do";
/**技术支持历史*/
NSString *const Api_QueryTechnicalSupportHistory = @"app/queryTechnicalSupportHistory.do";

/**四大板块介绍*/
NSString *const Api_AppIntroduce = @"app/queryAppAboutMenu.do";

/**分享*/
NSString *const Api_AppShare = @"app/queryDownLoadHtmlUrl.do";

/**通知明细*/
NSString *const Api_NotificationDetail = @"todo/queryUserToDoById.do";
/**通知项目列表*/
NSString *const Api_NotificationProjectList = @"todo/queryUserToDoForProject.do";
/**通知合作列表*/
NSString *const Api_NotificationCooperationList = @"todo/queryUserToDoForCooperation.do";
/**通知批量删除*/
NSString *const Api_NotificationDelete = @"todo/batchClearUserToDo.do";
/**通知批量已读*/
NSString *const Api_NotificationRead = @"todo/batchUpdateUserToDoToHaveRead.do";
/**通知未读*/
NSString *const Api_NotificationUnRead = @"todo/batchUpdateUserToDoToUnread.do";
/**通知未读数量*/
NSString *const Api_NotificationUnReadCount = @"todo/queryUserToDoUnReadCount.do";
/**清空角标*/
NSString *const Api_NotificationClearUserAppBadge = @"todo/clearUserAppBadge.do";
/**检查访视提醒对应的访视或病例是否创建过*/
NSString *const Api_NotificationVisitExist = @"patient/checkUserToDoVisitExist.do";
/**检查CRF提醒对应的访视或者病例是否创建过*/
NSString *const Api_NotificationCrfExist = @"patient/checkVisitExist.do";

@implementation ServerApi

/**获取服务器列表*/
- (NSMutableArray*)baseUrlList{
    NSMutableArray *baseUrlList = [NSMutableArray array];
    // 51测试服务器
    NSMutableArray *Base_URL_Project_001MutableArray = [NSMutableArray array];
    NSString *Base_URL_Project_001 = @"http://facade51.ydata.org/facade/";
    NSString *Base_URL_H5_001 = @"http://facade51.ydata.org/";
    [Base_URL_Project_001MutableArray addObject:Base_URL_Project_001];
    [Base_URL_Project_001MutableArray addObject:Base_URL_H5_001];
    [baseUrlList addObject:Base_URL_Project_001MutableArray];
    // 开发服务器
    NSMutableArray *Base_URL_Project_002MutableArray = [NSMutableArray array];
    NSString *Base_URL_Project_002 = @"http://192.168.10.203:51000/facade/";
    NSString *Base_URL_H5_002 = @"http://192.168.10.203:51000/";
//    NSString *Base_URL_Project_002 = @"http://192.168.10.13:30000/facade/";
//    NSString *Base_URL_H5_002 = @"http://192.168.10.13:30000/";
    [Base_URL_Project_002MutableArray addObject:Base_URL_Project_002];
    [Base_URL_Project_002MutableArray addObject:Base_URL_H5_002];
    [baseUrlList addObject:Base_URL_Project_002MutableArray];
    // 3.0测试服务器
    NSMutableArray *Base_URL_Project_003MutableArray = [NSMutableArray array];
    NSString *Base_URL_Project_003 = @"http://wxtestmaster.ydata.org/facade/";
    NSString *Base_URL_H5_003 = @"http://wxtestmaster.ydata.org/";
    [Base_URL_Project_003MutableArray addObject:Base_URL_Project_003];
    [Base_URL_Project_003MutableArray addObject:Base_URL_H5_003];
    [baseUrlList addObject:Base_URL_Project_003MutableArray];
    // online
    NSMutableArray *Base_URL_Project_004MutableArray = [NSMutableArray array];
    NSString *Base_URL_Project_004 = @"http://wxmasteronline.ydata.org/facade/";
    NSString *Base_URL_H5_004 = @"http://wxmasteronline.ydata.org/";
    [Base_URL_Project_004MutableArray addObject:Base_URL_Project_004];
    [Base_URL_Project_004MutableArray addObject:Base_URL_H5_004];
    [baseUrlList addObject:Base_URL_Project_004MutableArray];
    
    return baseUrlList;
}

/**设置服务器:不包含正式版本IP*/
- (BOOL)setupDebugBaseUrl:(NSInteger)index{
    BOOL suc = NO;
    NSMutableArray *baseUrlList = [self baseUrlList];
    NSMutableArray *baseUrl = baseUrlList[index];
    Base_URL_Project = baseUrl[0];
    Base_URL_H5 = baseUrl[1];
    if (![Base_URL_Project isEqualToString:@""] && ![Base_URL_H5 isEqualToString:@""] && Base_URL_Project != nil && Base_URL_H5 != nil) {
        suc = YES;
    }
    return suc;
}

/**设置服务器:上线IP*/
- (void)setupReleaseBaseUrl{
    Base_URL_Project = @"http://masterwx.medbit.cn/facade/";
    Base_URL_H5 = @"http://masterwx.medbit.cn/";
}

@end

