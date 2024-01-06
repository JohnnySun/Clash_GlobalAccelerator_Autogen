# Clash Global Accelerator Config Autogen
Latest generate status: [![Update Clash Gists](https://github.com/JohnnySun/Clash_GlobalAccelerator_Autogen/actions/workflows/update_clash_gists.yml/badge.svg)](https://github.com/JohnnySun/Clash_GlobalAccelerator_Autogen/actions/workflows/update_clash_gists.yml)

“Clash 全球网络加速服务”配置自动生成/发布工具，充分利用机场节点，提供全球最优路由选择

按IP地址自动选择最优路由配置，不同于主流Clash配置文件，无需各种规则分流，自动选择最优路由。

由于该路由规则依赖精准的GeoIP数据库，建议搭配 [Ipinfo.io MMDB Database](https://github.com/JohnnySun/geoip) 使用

Android用户，可以使用 [Ipinfo.io MMDB Database Android](https://github.com/JohnnySun/ClashForAndroid-Geoip/releases)。安装后，在Clash/ClashMate Android 的 `旁加载GeoIP` 中配置 Source

# 特点
1. 无需复杂的规则分流，该配置基于IPLocation自动实现最优路由选择
2. 默认按IP所在大洲/国家配置默认路由，充分利用机场提供的各种落地节点，实现就近流量出口，尽可能减少数据包在公网中传递过长的距离
3. 支持路由降级，当最优节点出现单点故障时，支持路由降级策略，优先保证可用性
4. 支持Cloudflare Warp，当整个机场被DDOS时，出现大面积可用性降级时，支持优先Fallback到CloudFlare Wrap
5. 支持Anycast最优路由，判断AnycastIP，实现就近路由
6. 支持CI自动化发布配置，配合clash定时更新，实现配置远端发布
7. 支持广告过滤/拦截
8. Encrypted GeoDNS Support，国内域名的DNS查询能确保匹配到最近的CDN，海外域名尽可能匹配HK/TW的CDN地址
8. 优化过的Domain/IP过滤器，优先匹配Domain其次是IP，避免手写配置时由于排序混乱导致的匹配的Domain被提前进行DNS解析导致的耗时问题

# 配置方法
1. Fork该工程
2. 前往 [Gist](https://gist.github.com) 去创建一个新的 Secret Gist
3. 获取 GistID，获取方法为，点击刚刚创建的gist，分析URL https://gist.github.com/UserName/GistID
4. 前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增一个 `GIST_ID`，值为上一步中的 GistID
5. 去Github生成两个Token（或者是一个Token）包含 Gist权限 私有Repo访问权限
6. 前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增两个Token， 分别为`GIST_TOKEN` `REPO_ACCESS_TOKEN`
7. 前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增两个Token， 分别为`CF_WARP_PRIVATE_KEY` `CF_WARP_PUBLIC_KEY`, 值分别为 CloudFlare Warp 的 Private/Public Key
8. 前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增`DLER_SUBSCRIBE_TOKEN` 值为 [Dlercloud](https://dlercloud.com) 所提供的SUBSCRIBE_TOKEN
9. (Optional) 如需设置私人的配置复写，可以新建一个私有工程，创建私有工程后前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增 `PERSONAL_PROXIES_GIT` 并设置值为 `USERNAME/YOURPROJECT.git` 私有工程下的目录结构和本工程相同，生成配置前，CI会先将私人工程中的文件与本工程合并，并生成最终的配置文件
10. 手动Commit一次该工程，CI会自动运行，并将结果发布到你的Secret Gist中

# Personal Config Override
(Optional) 如需设置私人的配置复写，可以新建一个私有工程，创建私有工程后前往 `Settings->Security->Secrets and variables->Action->Repository secrets` 中新增 `PERSONAL_PROXIES_GIT` 并设置值为 `USERNAME/YOURPROJECT.git` 私有工程下的目录结构和本工程相同，生成配置前，CI会先将私人工程中的文件与本工程合并，并生成最终的配置文件

## 项目 Star 数增长趋势
[![Stargazers over time](https://starchart.cc/JohnnySun/Clash_GlobalAccelerator_Autogen.svg)](https://starchart.cc/JohnnySun/Clash_GlobalAccelerator_Autogen)

