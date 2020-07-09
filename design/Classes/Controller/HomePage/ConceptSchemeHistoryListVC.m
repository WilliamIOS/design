//
//  ConceptSchemeHistoryListVC.m
//  design
//
//  Created by panwei on 2020/7/9.
//

#import "ConceptSchemeHistoryListVC.h"
#import "LoadingFileTVC.h"
#import "UIView+Extension.h"
#import "Macro.h"

@interface ConceptSchemeHistoryListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *fileListTV;
@property (weak, nonatomic) IBOutlet UIView *loadingFileView;

@end

@implementation ConceptSchemeHistoryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = @"我的项目";
    self.fileListTV.delegate = self;
    self.fileListTV.dataSource = self;
    [self.loadingFileView setRoundedView:self.loadingFileView cornerRadius:10 borderWidth:4 borderColor:[UIColor lightGrayColor]];
    UITapGestureRecognizer *loadingFileViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadingFileViewGesture:)];
    [self.loadingFileView addGestureRecognizer:loadingFileViewTap];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadingFileTVC *loadingFileTVC = [LoadingFileTVC cellWithTableView:tableView cellidentifier:@"LoadingFileTVCWithConceptSchemeHistory"];
    return loadingFileTVC;
}

- (void)loadingFileViewGesture:(UITapGestureRecognizer*)recognizer {
    
}

@end
