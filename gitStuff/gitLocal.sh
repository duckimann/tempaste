# Local repo
git init
git remote add origin ...
git add .
git commit -am "msg"
git push -u origin master


# Remote Repo
git init --bare
# List files
git ls-tree --full-tree -r HEAD
# View file contents
git show HEAD:[path_to_file] # git show HEAD:dashboard.html