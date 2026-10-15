# 植物解码 iOS 封装

本工程将 `App/Resources/index.html` 嵌入 iOS `WKWebView`，无需网络服务。代码从 XcodeGen `project.yml` 生成 Xcode 项目。

## 在 GitHub Actions 中编译
1. 新建 GitHub 仓库，将这里的所有文件和文件夹 **解压后上传** 至仓库根目录（包括 `.github/workflows/build-ios.yml`）。
2. 打开 Actions → Build iOS IPA → Run workflow。
3. 在运行成功页面下方的 Artifacts 下载 `PVZDecoder-unsigned-IPA`。

**注意**：这生成的是 **未签名** IPA，无法直接安装到未经签名部署的 iPhone。需要通过正规开发者证书/描述文件完成签名；如果使用 Mac + Xcode 个人团队，也可以直接运行到已连接的 iPhone（个人团队有时限和限制）。

## 重要：手机端验证
原始 HTML 通过 Blob URL 创建 Web Worker，并将局次保存在 localStorage。由于 `WKWebView` 本地文件的安全策略与桌面浏览器不同，必须在真实 iPhone 上测试“开始推理”和退出重开后的历史保存。若 Worker 无法启动，应改为应用内 localhost 服务或将推理迁移到受支持的原生逻辑；不要误判为 IPA 安装或签名问题。导出/导入 JSON 在 WKWebView 内也可能需要原生下载/文件选择桥接。

## 本地 Mac 构建
```sh
brew install xcodegen
xcodegen generate
open PVZDecoder.xcodeproj
```
在 Xcode 中设置 Signing & Capabilities 的 Team，使用唯一的 Bundle Identifier 后选中自己的 iPhone 运行。

## 许可
网页中包含来自 `Gzh0821/pvzg_site` 的 Apache-2.0 衍生代码，保留了网页内的许可证声明与署名。公开分发前请确认第三方代码的 NOTICE 要求。

## v2 可变解码设置
基础植物数量和密码长度均可设置为 3–10，按编号 `1 2 3 4 5 6 7 8 9 0` 的前 N 种植物生成合法融合。密码长度不能超过可用的不重复合法融合数量。修改设置会清空当前局记录；JSON v2 导出包含两个设置，且支持导入旧版 10×10 的 v1 记录。
