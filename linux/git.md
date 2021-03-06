# Git #


## Environment ##

```
linux:~ $ git config --global user.name 'owner' # 設定使用者名稱 
linux:~ $ git config --global user.email 'owner@localhost' # 設定email 
linux:~ $ git config --global core.editor vim # 設定文字編輯器 
linux:~ $ git config --global merge.tool vimdiff # 設定比較工具 
linux:~ $ git config --global color.ui true # 設定顯示顏色 
linux:~ $ git config --global apply.whitespace nowarn # 忽略空白的變化, 空白對有些語言是有影響的 (像是 Ruby) 
linux:~ $ git config --global alias.log-pretty 'log --graph --oneline --decorate --date-order' # 設定別名
linux:~ $ git config --list # 顯示當前設定

linux:~ $ cat ~/.gitconfig 
[user] 
    name = owner 
    email = owner@localhost 
[core] 
    editor = vim 
    pager =
[merge] 
    tool = vimdiff 
[color] 
    ui = true 
[alias] 
    commit-show = commit -v -uno
    branch-all = branch -avv

    log-pretty = log --graph --oneline --decorate --date-order
#    log-pretty = log --graph --oneline --boundary --decorate --all --date-order
    log-full= log -C --stat --decorate
```


## Normal ##

```
# download project
linux:~ $ git clone git@github.com:user/sandbox.git # 下載 project 
linux:~ $ git clone git@github.com:user/sandbox.git newproejct # 下載 project 並改名為 newproject 

# file status
linux:~/project $ git add file                # 檔案納入控制系統 
linux:~/project $ git rm [--cache|-f] file    # 檔案移出制系統
linux:~/project $ git mv src_file des_file    # 檔案移出制系統

linux:~/project $ git commit -m 'my comment'  # 提交到控制系統 
linux:~/project $ git commit --amend          # 修改/編輯 commit

linux:~/project $ git reset HEAD~             # 狀態改成前一次 commit

linux:~/project $ git status # version記錄 

linux:~/project $ git log                     # commit記錄 
linux:~/project $ git log -1                  # show HEAD
linux:~/project $ git log --graph --oneline --all --decorate 
linux:~/project $ git log --graph --oneline --all --decorate --boundary --date-order 

# branch, checkout, fetch
linux:~/project $ git branch          # 顯示 branch
linux:~/project $ git branch --all    # 顯示所有 branch (包括 remote)
linux:~/project $ git branch b1       # 新增 branch
linux:~/project $ git branch -d b1    # 刪除 branch

linux:~/project $ git checkout -b b1  # 新增 branch
linux:~/project $ git checkout b1     # 切換 branch

linux:~/project $ git fetch
linux:~/project $ git fetch --all

# push, pull
linux:~/project $ git push
linux:~/project $ git pull
```


## Merge

```
   b1              b1 
   /     =>      /    \ 
v1 - v2       v1 - v2 - v3
```

```
linux:~/project $ git checkout v2 
linux:~/project $ git merge b1
```


## Rebase

```
   b1 
   /     => 
v1 - v2       v1 - v2 - v3
```

```
linux:~/project $ git checkout v2 
linux:~/project $ git rebase b1
```


## Reset

| option 	 | HEAD 	 | index | workdir 	 |
| ---------- | --------- | ----- | --------- |
| --soft 	 | Y		 | 		 | 			 |
| --mixed 	 | Y 		 | Y 	 | 			 |
| --hard 	 | Y 		 | Y 	 | Y 		 |

```
linux:~/project $ git reset HEAD
linux:~/project $ git reset --mixed HEAD # 同上
linux:~/project $ git reset --soft HEAD
linux:~/project $ git reset --hard HEAD
```


## Stash

```
linux:~/project $ git stash      # 先將以改修改過的 code 存入 stash
linux:~/project $ git pull
linux:~/project $ git stash pop  # 再將以改修改過的 code 從 stash 寫回

# pull code step:
linux:~/project $ git stash
linux:~/project $ git show stash
linux:~/project $ git pull --rebase
linux:~/project $ git stash pop

# push code step:
linux:~/project $ git show --pretty="" --name-only 53bd8b2
linux:~/project $ git stash
linux:~/project $ git pull --rebase
linux:~/project $ git push
linux:~/project $ git log
linux:~/project $ git stash pop
```

## Multi User

### push commit to remote server

`condition`

```bash
# user1
centos:~/project $ git add file1
centos:~/project $ git commit -m "Add file1"
centos:~/project $ git push

# user2
centos:~/project $ git add file2
centos:~/project $ git commit "Add file2"
centos:~/project $ git push
 ! [rejected]        master -> master (fetch first)
```

`action1`

```bash
*    (HEAD, master) Merge branch 'master'
|\
* |  Add file2
| *  (origin/master, origin/HEAD) Add file1
|/
*

# user2
centos:~/project $ git pull
centos:~/project $ git push

*  (HEAD, origin/master, origin/HEAD, master) Add 1
*  Add file1
*  first commit

centos:~/project $ git reset <hash add file1>
centos:~/project $ git pull
centos:~/project $ git add file2
centos:~/project $ git commit "Add file2"
centos:~/project $ git push
```

`action2`

```bash
# user2
centos:~/project $ git reset <hash Add file1>
centos:~/project $ git pull
centos:~/project $ git add file2
centos:~/project $ git commit "Add file2"
centos:~/project $ git push
```

`action3`

```bash
# user2
centos:~/project $ git stash
centos:~/project $ git stash list
centos:~/project $ git pull

centos:~/project $ git reset --hard <hash master>
centos:~/project $ git stash pop [<hash stash>]

# if Merge conflict in filex
centos:~/project $ vi filex
centos:~/project $ git stash drop [<hash stash>]
centos:~/project $ git add file2 filex
centos:~/project $ git commit "Add file2"
centos:~/project $ git push
```

---

## Tag

```bash
# add tag
linux:~/project # git tag <tag_name>

# del tag
linux:~/project # git tag -d <tag_name>

# push tag to remote
linux:~/project # git push origin <tag_name>    # one tag
linux:~/project # git push origin --tags        # all tag

# remove tag to remote
linux:~/project # git push -d origin <tag_name>
```
