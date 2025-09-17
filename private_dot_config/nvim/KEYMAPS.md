# Neovim 快捷键参考

## Snacks.nvim 快捷键

### 文件和缓冲区
- `<leader><space>` - 智能文件查找
- `<leader>,` - 缓冲区列表
- `<leader>e` - 文件资源管理器
- `<leader>fb` - 缓冲区列表
- `<leader>fc` - 查找配置文件
- `<leader>ff` - 查找文件
- `<leader>fg` - Git 文件查找
- `<leader>fp` - 项目列表
- `<leader>fr` - 最近文件

### 搜索
- `<leader>/` - 全局搜索
- `<leader>sg` - 全局搜索
- `<leader>sw` - 搜索当前单词/选中文本
- `<leader>sb` - 缓冲区内搜索
- `<leader>sB` - 在打开的缓冲区中搜索

### Git
- `<leader>gb` - Git 分支
- `<leader>gl` - Git 日志
- `<leader>gL` - Git 行日志
- `<leader>gs` - Git 状态
- `<leader>gS` - Git 储藏
- `<leader>gd` - Git 差异
- `<leader>gf` - Git 文件日志
- `<leader>gB` - Git 浏览器
- `<leader>gg` - Lazygit

### 实用工具
- `<leader>z` - 禅模式
- `<leader>Z` - 缩放模式
- `<leader>.` - 临时缓冲区
- `<leader>S` - 选择临时缓冲区
- `<leader>un` - 关闭所有通知
- `<leader>N` - Neovim 新闻
- `<c-/>` - 切换终端

### 切换选项 (Toggle)
- `<leader>us` - 拼写检查
- `<leader>uw` - 自动换行
- `<leader>uL` - 相对行号
- `<leader>ud` - 诊断信息
- `<leader>ul` - 行号
- `<leader>uc` - 隐藏级别
- `<leader>uT` - Treesitter
- `<leader>ub` - 深色背景
- `<leader>uh` - 内联提示
- `<leader>ug` - 缩进指示
- `<leader>uD` - 暗化模式
- `<leader>uC` - 颜色主题

### 搜索和选择器
- `<leader>s"` - 寄存器
- `<leader>s/` - 搜索历史
- `<leader>sa` - 自动命令
- `<leader>sc` - 命令历史
- `<leader>sC` - 命令列表
- `<leader>sd` - 诊断信息
- `<leader>sD` - 缓冲区诊断
- `<leader>sh` - 帮助页面
- `<leader>sH` - 高亮组
- `<leader>si` - 图标
- `<leader>sj` - 跳转列表
- `<leader>sk` - 键盘映射
- `<leader>sl` - 位置列表
- `<leader>sm` - 标记
- `<leader>sM` - 手册页
- `<leader>sp` - 插件规格
- `<leader>sq` - 快速修复列表
- `<leader>sR` - 恢复上次选择器
- `<leader>su` - 撤销历史

## Code 相关快捷键 (`<leader>c`)

### LSP 功能
- `<leader>cd` - LSP 定义
- `<leader>cr` - LSP 引用
- `<leader>ci` - LSP 实现
- `<leader>cs` - LSP 文档符号
- `<leader>cw` - LSP 工作区符号
- `<leader>ct` - Treesitter 符号

### 搜索和导航
- `<leader>cg` - 在光标下的单词进行实时搜索
- `<leader>cf` - 查找文件
- `<leader>cb` - 查找缓冲区

### AI 功能 (CodeCompanion)

#### 主要功能
- `<leader>ca` - AI 动作面板 (Actions)
- `<leader>cc` - 切换 AI 聊天窗口 (Chat Toggle)
- `<leader>ci` - 行内 AI 助手 (Inline)
- `<leader>cn` - 新建聊天会话 (New Chat)
- `<leader>cC` - 添加选中内容到聊天 (Add to Chat)

#### 快速操作
- `<leader>ce` - 解释代码 (Explain)
- `<leader>cr` - 重构代码 (Refactor)
- `<leader>cd` - 生成文档 (Document)
- `<leader>ct` - 生成测试 (Tests)
- `<leader>cf` - 修复代码 (Fix)
- `<leader>co` - 优化性能 (Optimize)

#### 工作流
- `<leader>cwr` - 代码审查工作流 (Code Review)
- `<leader>cwb` - Bug 分析工作流 (Bug Analysis)

> 📖 详细使用说明请查看 [CODECOMPANION_GUIDE.md](./CODECOMPANION_GUIDE.md)

### 文件操作
- `<leader>cR` - 重命名文件

## 全局 LSP 导航
- `gd` - 跳转到定义
- `gD` - 跳转到声明
- `gr` - 查看引用
- `gI` - 跳转到实现
- `gy` - 跳转到类型定义

## 单词导航
- `]]` - 下一个引用
- `[[` - 上一个引用

## 缓冲区导航
- `]b` - 下一个缓冲区
- `[b` - 上一个缓冲区
- `<leader>,` - 下一个缓冲区
- `<leader>bd` - 从标签栏关闭缓冲区

## 命令和历史
- `<leader>:` - 命令历史
- `<leader>n` - 通知历史