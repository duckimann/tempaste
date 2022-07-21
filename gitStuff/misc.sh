# Init
git init # normal repo
git init --bare # bare repo

# current working branch
git branch
git branch --show-current
# new branch
git checkout -b [new_branch_name] [root_branch]
# rename current branch
git branch -m [new_name]
# go to previous branch
git checkout -
# reset --hard 1 file to specific commit
git checkout [commit_id] -- ./file_name.txt

# Bisect
git bisect --help

# log
git log
git log --oneline --graph --decorate

# cherry
git cherry commit_id

# status
git status

# add files
git add [path/file]
git add . # add all

# commit
git commit -m "commit messsage"
git commit -am "msg" # commit all files added
git commit --amend -m "msg" # update the last commit & last commit msg (if you not push it to github yet)
git commit --amend --no-edit # same as above BUT this one doesn't edit the commit msg
git commit -sm "commit msg" # sign commit

# push
git push -u [local] [remote] # update
git push -f [local] [remote] # force push

# subtree
git subtree push --prefix [folder] [repo/origin] [branch_name] # prefix -> bring the folder to root

# pull (update local version)
git pull

# add remote origin 
git remote add origin [path]
# git remote add https://github.com/duckimann/tempaste
# git remote add C:/some/localGit

# fetch
git fetch [remote] [branch]
git fetch --all

# rebase
# https://ehkoo.com/bai-viet/git-workflow-phan-nhanh-va-chia-viec-trong-nhom
# apply current branch commits after commits of other branch
git checkout feature # make sure you at feature branch
git rebase dev # start to apply commits from "feature" after "dev"
# then you can merge "feature" to "dev"
git rebase [branch]
git rebase [branch] -i # rebase interactively
git rebase -i HEAD~N
git rebase -i --root
# reword (r): apply commit & edit commit msg
# edit (e): apply commit but pause the rebase to fix the code
# squash (s): append current commit to the previous commit
# fixup (f): same with squash but remote commit msg
# exec (x): run shell command
# drop (d): drop commit


# Merge
git merge [merge_X_to_current_branch] # can't differentiate commits
git merge [merge_X_to_current_branch] --no-ff


# Reflog (show all git activities)
git reflog
# purge reflog
git reflog expire --expire=90.days.ago --expire-unreachable=now --all

# Reset
git reset
git reset --hard
git reset --hard HEAD~1
# reset hard single file
git reset HEAD -- [file]

# Revert
git revert

# Restore (restore changing to last commit)
git restore .
git restore path_to_file

# Stash
git stash
git stash pop # get back the code before stash
# stash by name
git stash save [name]
git stash list # list stashes
git stash pop [index]
git stash drop -q [name]

git stash list [<log-options>]
git stash show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]
git stash drop [-q|--quiet] [<stash>]
git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
git stash branch <branchname> [<stash>]
git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
	     [--] [<pathspec>…​]]
git stash clear
git stash create [<message>]
git stash store [-m|--message <message>] [-q|--quiet] <commit>

# Show (show commit details)
git show [commit_id]
# Show file details in commit
git show [commit_id]:[path_to_file] # git show HEAD:dashboard.html

# List files
git ls-tree --full-tree -r [commit_id_or_HEAD]

git ls-files -ci --exclude-standard


# List configs
git config --global alias
git config --list | grep alias

# git alias cho phép bạn đặt tên thay thế cho các câu lệnh thường dùng. Thay vì phải gõ dài dòng như git commit --amend -s, bạn có thể dùng git config --global alias.cmsa "commit --amend -s", và bùm, từ nay chỉ cần git cmsa là xong.
# Dưới đây là một số alias mà Ehkoo thường dùng:

git config --global alias.a "add"

# Đánh dấu tất cả tập tin trong thư mục hiện tại, chuẩn bị commit
git config --global alias.aa "add . -A"

git config --global alias.c "commit"

# Commit và đặt chữ ký
git config --global alias.cms "commit -s"

# Kết hợp với commit trước đó và đặt chữ ký
git config --global alias.ca "commit --amend -s"

git config --global alias.d "diff"
git config --global alias.ds "diff --stat"

# Hiển thị thay đổi với những tập tin đã được staged
git config --global alias.dc "diff --cached"

git config --global alias.s "status -s"
git config --global alias.co "checkout"

# Checkout  một nhánh mới
git config --global alias.cob "checkout -b"

# Ehkoo đặc biệt thích git lg này:
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Với git log bình thường, bạn sẽ có lịch sử như hình bên trái. Nhưng với git lg, các commit sẽ được gom lại và hiển thị theo dạng đồ thị. Dễ nhìn hơn nhiều.
# Bạn có thể xem thêm các aliases khác ở GitAlias/gitalias. À, đừng quên git yolo!

# Git Hooks
# it's in $GIT_DIR/hooks/
