# Shoutout: https://jigarius.com/blog/multiple-git-remote-repositories

# Syntax to add a git remote
git remote add REMOTE-ID REMOTE-URL

# Add remote 1: GitHub.
git remote add origin git@github.com:jigarius/toggl2redmine.git
# Add remote 2: BitBucket.
git remote add upstream git@bitbucket.org:jigarius/toggl2redmine.git

# Change local branch.
git checkout BRANCH
# Configure local branch to track a remote branch.
git branch -u origin/BRANCH

# Change remote syntax is: git remote set-url REMOTE-ID REMOTE-URL
git remote set-url upstream git@foobar.com:jigarius/toggl2redmine.git

# List all remotes
git remote -v
# origin	    git@github.com:jigarius/toggl2redmine.git (fetch)
# origin	    git@github.com:jigarius/toggl2redmine.git (push)
# upstream    git@bitbucket.org:jigarius/toggl2redmine.git (fetch)
# upstream    git@bitbucket.org:jigarius/toggl2redmine.git (push)

# Remove remote syntax is: git remote remove REMOTE-ID
git remote remove upstream

# Push to multiple remotes
# Create a new remote called "all" with the URL of the primary repo.
git remote add all git@github.com:jigarius/toggl2redmine.git
# Re-register the remote as a push URL.
git remote set-url --add --push all git@github.com:jigarius/toggl2redmine.git
# Add a push URL to a remote. This means that "git push" will also push to this git URL.
git remote set-url --add --push all git@bitbucket.org:jigarius/toggl2redmine.git
# Replace BRANCH with the name of the branch you want to push.
git push all BRANCH

# Fetch from multi remotes
git fetch --all