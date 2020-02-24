### 使用.gitignore插件，首先进行安装 找到.ignore下载并安装
    .idea/workspace.xml
    .idea
    *.iml
    git/src/
    src/
    
    如果已经将本地的文件提交到了远端，那么需要将远端提交的文件给删掉，删除指令为：
    git rm -r --cached .idea 
    
    
    直接在 editor fileTypes 写死
    *.iml;*.idea;*.gitignore;*.sh;*.classpath;*.project;*.settings;target;
    