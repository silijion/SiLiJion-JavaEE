### 1.先到官网下载git安装包进行安装，安装好之后，找到安装路径下的git-bash.exe,打开，输入命令：
    ssh-keygen -t rsa -C 邮箱地址
   

### 2.然后在C盘users中找到如下文件：
    证明ssh key已经生成成功
    打开刚刚生成的id_rsa.pub文件，复制里面的内容，然后登录自己的GitHub账号，把粘贴的内容复制到下图的key中

### 3.通过git-bash.exe操作
    git init
    git add .
    git commit -m '注释说明'
    git remote add origin 仓库链接地址 （再github上面创建仓库）
    git push -u origin master
    
