#  Typescript/Go Fullstack Monolith
Just clone and rebrand it.
```shell
git clone git@github.com:samintheshell/fullstack.git MY_NEW_APP && cd $_
bash bin/rebrand.sh github.com/samintheshell/fullstack MY_GO_MODULE
```

Updating the repo:
```shell
git add -A &&
GIT_AUTHOR_DATE="1970-01-01T00:00:00Z" GIT_COMMITTER_DATE="1970-01-01T00:00:00Z" \
    git commit --amend --date="1970-01-01T00:00:00Z" -m "A monolithic fullstack repo using Typescript/Go. Just clone and rebrand it." &&
git push --force origin
```
