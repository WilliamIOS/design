//
//  ConceptSchemeListVC.m
//  design
//
//  Created by panwei on 7/9/20.
//

#import "ConceptSchemeListVC.h"
#import "LoadingFileTVC.h"
#import "UIView+Extension.h"
#import "Macro.h"
#import "ConceptSchemeHistoryListVC.h"

@interface ConceptSchemeListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *fileListTV;
@property (weak, nonatomic) IBOutlet UIView *loadingFileView;
@property (weak, nonatomic) IBOutlet UIView *checkHistoryFileView;

@end

@implementation ConceptSchemeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettings];
}

- (void)setupSettings{
    self.navigationItem.title = @"我的项目";
    self.fileListTV.delegate = self;
    self.fileListTV.dataSource = self;
    [self.loadingFileView setRoundedView:self.loadingFileView cornerRadius:10 borderWidth:4 borderColor:PWColor(33, 136, 184)];
    [self.checkHistoryFileView setRoundedView:self.checkHistoryFileView cornerRadius:10 borderWidth:4 borderColor:PWColor(33, 136, 184)];
    UITapGestureRecognizer *loadingFileViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadingFileViewGesture:)];
    [self.loadingFileView addGestureRecognizer:loadingFileViewTap];
    UITapGestureRecognizer *checkHistoryFileViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkHistoryFileViewGesture:)];
    [self.checkHistoryFileView addGestureRecognizer:checkHistoryFileViewTap];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadingFileTVC *loadingFileTVC = [LoadingFileTVC cellWithTableView:tableView cellidentifier:@"LoadingFileTVCWithConceptScheme"];
    return loadingFileTVC;
}

- (void)loadingFileViewGesture:(UITapGestureRecognizer*)recognizer {
    
}

- (void)checkHistoryFileViewGesture:(UITapGestureRecognizer*)recognizer {
    ConceptSchemeHistoryListVC *conceptSchemeHistoryListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ConceptSchemeHistoryListVC"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:conceptSchemeHistoryListVC animated:true];
}




@end
