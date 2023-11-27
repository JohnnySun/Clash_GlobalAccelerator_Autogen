# clash-config-autogen
clash配置自动生成脚本

# 配置方法
1. Fork该工程
2. 前往 [Gist](https://gist.github.com) 去创建一个新的 Secret Gist
3. 获取 GistID，获取方法为，点击刚刚创建的gist，分析URL https://gist.github.com/UserName/GistID
4. 前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增一个 `GIST_ID`，值为上一步中的 GistID
5. 去Github生成两个Token（或者是一个Token）包含 Gist权限 私有Repo访问权限
6. 前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增两个Token， 分别为`GIST_TOKEN` `REPO_ACCRSS_TOKEN`
7. 前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增`DLER_SUBSCRIBE_TOKEN` 值为 [Dlercloud](dlercloud.com) 所提供的SUBSCRIBE_TOKEN
8. (Optional) 如需设置私有的个人代理配置，可以参考 `/proxies` 文件夹下的格式，新建一个私有工程，创建私有工程后前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增 `PERSONAL_PROXIES_GIT` 并设置值为 `USERNAME/YOURPROJECT.git`
9. 手动Commit一次该工程，CI会自动运行，并将结果发布到你的Secret Gist中
