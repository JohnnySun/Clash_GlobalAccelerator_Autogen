# clash-config-autogen
按IP地址自动选择最优路由配置，万能Clash配置，无需各种规则分流，自动选择最优路由。

由于该路由规则依赖精准的GeoIP数据库，建议搭配 [Ipinfo.io MMDB Database](https://github.com/JohnnySun/geoip) 使用

Android用户，可以使用 [Ipinfo.io MMDB Database Android](https://github.com/JohnnySun/ClashForAndroid-Geoip/releases)。安装后，在Clash/ClashMate Android 的 `旁加载GeoIP` 中配置 Source

# 特点
1. 无需复杂的规则分流，该配置基于IPLocation自动实现最优路由选择
2. 支持路由降级，当最优节点出现单点故障时，支持路由降级策略，优先保证可用性
3. 支持Anycast最优路由，判断AnycastIP，实现就近路由

# 配置方法
1. Fork该工程
2. 前往 [Gist](https://gist.github.com) 去创建一个新的 Secret Gist
3. 获取 GistID，获取方法为，点击刚刚创建的gist，分析URL https://gist.github.com/UserName/GistID
4. 前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增一个 `GIST_ID`，值为上一步中的 GistID
5. 去Github生成两个Token（或者是一个Token）包含 Gist权限 私有Repo访问权限
6. 前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增两个Token， 分别为`GIST_TOKEN` `REPO_ACCRSS_TOKEN`
7. 前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增`DLER_SUBSCRIBE_TOKEN` 值为 [Dlercloud](https://dlercloud.com) 所提供的SUBSCRIBE_TOKEN
8. (Optional) 如需设置私有的个人代理配置，可以参考 `/proxies` 文件夹下的格式，新建一个私有工程，创建私有工程后前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增 `PERSONAL_PROXIES_GIT` 并设置值为 `USERNAME/YOURPROJECT.git`
9. 手动Commit一次该工程，CI会自动运行，并将结果发布到你的Secret Gist中
