# CodeCompanion AI Cookbook

> 🍳 实用的 AI 编程助手使用技巧和配方集合

## 📖 目录

- [日常开发场景](#日常开发场景)
- [代码质量提升](#代码质量提升)
- [学习和探索](#学习和探索)
- [调试和问题解决](#调试和问题解决)
- [项目管理](#项目管理)
- [高级技巧](#高级技巧)

## 🛠️ 日常开发场景

### 1. 快速理解陌生代码

**场景**: 接手新项目或阅读他人代码

**操作流程**:
```vim
1. 打开文件
2. 选中关键函数或类
3. <leader>ce (解释代码)
```

**提问技巧**:
```
"这个函数的主要作用是什么？"
"这个设计模式的优势在哪里？"
"这段代码的执行流程是怎样的？"
```

**示例对话**:
```
用户: /buffer 这个文件的整体架构是什么？各个部分的职责是什么？

AI: 这个文件实现了一个用户认证系统，主要包含以下几个部分：

1. **AuthService 类** - 核心认证逻辑
   - login() - 处理用户登录
   - logout() - 处理用户登出
   - validateToken() - 验证 JWT 令牌

2. **中间件函数**
   - authMiddleware() - Express 中间件，验证请求
   - roleCheck() - 角色权限检查

3. **工具函数**
   - hashPassword() - 密码加密
   - generateToken() - 生成 JWT 令牌
```

### 2. API 设计和实现

**场景**: 设计 RESTful API 或 GraphQL 接口

**工作流**:
```vim
1. 描述需求 → <leader>cc (打开聊天)
2. 生成接口设计
3. 选中设计 → <leader>ci (生成实现代码)
4. 选中实现 → <leader>ct (生成测试)
```

**提问模板**:
```
"设计一个用户管理系统的 REST API，包括：
- 用户注册/登录
- 用户信息 CRUD
- 权限管理
- 数据验证

请提供完整的接口设计和实现代码。"
```

### 3. 数据库设计优化

**场景**: 设计或优化数据库结构

**操作步骤**:
```vim
1. /file schema.sql  # 包含现有结构
2. 描述业务需求
3. 请求优化建议
```

**示例查询**:
```sql
-- 选中这个查询
SELECT u.*, p.title, COUNT(o.id) as order_count
FROM users u
LEFT JOIN profiles p ON u.id = p.user_id  
LEFT JOIN orders o ON u.id = o.user_id
WHERE u.created_at > '2023-01-01'
GROUP BY u.id
ORDER BY order_count DESC;

-- 然后 <leader>co (优化)
```

## 🎯 代码质量提升

### 1. 代码审查自动化

**工作流**: 提交前的自动检查

```vim
" 创建自动命令
autocmd BufWritePre *.js,*.ts,*.py lua vim.cmd("CodeCompanionActions review")
```

**审查清单**:
```
<leader>cwr → 触发完整审查，包括：
✓ 代码风格和规范
✓ 性能优化机会  
✓ 安全漏洞检查
✓ 最佳实践建议
✓ 可维护性评估
```

### 2. 重构策略

**渐进式重构**:
```vim
# 步骤 1: 分析现状
选中大函数 → <leader>ce → "分析这个函数的职责，是否违反单一职责原则？"

# 步骤 2: 制定计划  
<leader>cc → "基于分析结果，提供重构计划和步骤"

# 步骤 3: 逐步实施
选中小块代码 → <leader>cr → 逐个重构

# 步骤 4: 验证结果
<leader>ct → 生成测试确保功能不变
```

**重构模式**:
```javascript
// 原始代码 - 选中后 <leader>cr
function processUserData(userData) {
  // 验证数据
  if (!userData.email || !userData.name) {
    throw new Error('Invalid data');
  }
  
  // 格式化数据
  userData.email = userData.email.toLowerCase();
  userData.name = userData.name.trim();
  
  // 保存到数据库
  database.save(userData);
  
  // 发送邮件
  emailService.sendWelcome(userData.email);
  
  return userData;
}

// AI 重构后的代码
class UserProcessor {
  validate(userData) {
    if (!userData.email || !userData.name) {
      throw new ValidationError('Email and name are required');
    }
  }
  
  format(userData) {
    return {
      ...userData,
      email: userData.email.toLowerCase(),
      name: userData.name.trim()
    };
  }
  
  async process(userData) {
    this.validate(userData);
    const formattedData = this.format(userData);
    
    const savedUser = await database.save(formattedData);
    await emailService.sendWelcome(savedUser.email);
    
    return savedUser;
  }
}
```

### 3. 性能优化

**性能分析流程**:
```vim
1. 选中性能关键代码
2. <leader>co (优化)
3. 对比前后性能差异
```

**优化场景**:

#### 算法优化
```python
# 原始代码 - O(n²) 复杂度
def find_duplicates(arr):
    duplicates = []
    for i in range(len(arr)):
        for j in range(i + 1, len(arr)):
            if arr[i] == arr[j] and arr[i] not in duplicates:
                duplicates.append(arr[i])
    return duplicates

# 选中后 <leader>co，AI 优化为 O(n)
def find_duplicates(arr):
    seen = set()
    duplicates = set()
    
    for item in arr:
        if item in seen:
            duplicates.add(item)
        else:
            seen.add(item)
    
    return list(duplicates)
```

#### 数据库查询优化
```sql
-- 原始查询 - 选中后 <leader>co
SELECT * FROM users u
WHERE u.id IN (
    SELECT user_id FROM orders 
    WHERE created_at > '2023-01-01'
);

-- AI 优化后
SELECT DISTINCT u.* FROM users u
INNER JOIN orders o ON u.id = o.user_id
WHERE o.created_at > '2023-01-01';
```

## 📚 学习和探索

### 1. 新技术学习

**学习新框架**:
```vim
<leader>cc → "我想学习 React Hooks，请提供：
1. 核心概念解释
2. 常用 Hooks 示例
3. 最佳实践
4. 常见陷阱和解决方案"
```

**代码示例生成**:
```vim
"请提供一个完整的 React 组件示例，展示：
- useState 管理状态
- useEffect 处理副作用  
- 自定义 Hook
- 错误边界处理"
```

### 2. 设计模式学习

**模式识别**:
```vim
选中代码 → <leader>ce → "这里使用了什么设计模式？为什么这样设计？"
```

**模式应用**:
```vim
<leader>cc → "在这个场景下，应该使用什么设计模式？请提供实现示例。"

场景描述：
- 需要创建不同类型的数据库连接
- 支持 MySQL、PostgreSQL、MongoDB
- 要求统一的接口
- 支持连接池管理
```

### 3. 算法和数据结构

**算法实现**:
```vim
<leader>cc → "实现一个 LRU 缓存，要求：
- O(1) 时间复杂度的 get 和 put 操作
- 支持泛型
- 线程安全
- 包含完整的测试用例"
```

**复杂度分析**:
```vim
选中算法代码 → <leader>ce → "分析这个算法的时间和空间复杂度，并解释推导过程。"
```

## 🐛 调试和问题解决

### 1. Bug 分析工作流

**系统性调试**:
```vim
<leader>cwb → 触发 Bug 分析工作流

包含以下步骤：
1. 问题现象描述
2. 错误日志分析
3. 可能原因推测
4. 调试策略制定
5. 修复方案建议
6. 预防措施
```

**错误日志分析**:
```vim
# 复制错误日志到聊天
<leader>cc → 粘贴日志 → "分析这个错误的原因和解决方案"

示例日志：
```
TypeError: Cannot read property 'map' of undefined
    at UserList.render (UserList.js:25:18)
    at finishClassComponent (react-dom.js:17160:31)
    at updateClassComponent (react-dom.js:17110:24)
```

### 2. 性能问题诊断

**性能瓶颈定位**:
```vim
<leader>cc → "这个应用响应很慢，请帮我分析可能的性能瓶颈：

/file src/api/users.js
/file src/components/UserList.js

用户反馈：
- 页面加载需要 5+ 秒
- 滚动时卡顿
- 内存使用持续增长"
```

**数据库性能优化**:
```sql
-- 选中慢查询
EXPLAIN ANALYZE 
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.id) > 10;

-- <leader>co 获取优化建议
```

### 3. 代码质量问题

**代码异味检测**:
```vim
选中可疑代码 → <leader>cf → "检查这段代码是否存在以下问题：
- 代码重复
- 过长的函数
- 过多的参数
- 复杂的条件逻辑
- 紧耦合"
```

## 📋 项目管理

### 1. 文档生成

**API 文档**:
```vim
选中 API 函数 → <leader>cd → 生成包含以下内容的文档：
- 功能描述
- 参数说明
- 返回值格式
- 错误码说明
- 使用示例
```

**README 生成**:
```vim
<leader>cc → "为这个项目生成 README.md，包括：

/file package.json
/file src/index.js

项目信息：
- Node.js Web API 服务
- 使用 Express 框架
- MongoDB 数据库
- JWT 认证
- Docker 部署"
```

### 2. 测试策略

**测试用例生成**:
```vim
选中函数 → <leader>ct → 生成全面的测试，包括：
- 单元测试
- 集成测试  
- 边界条件测试
- 错误处理测试
```

**测试覆盖率分析**:
```vim
<leader>cc → "分析这个模块的测试覆盖率，识别未测试的代码路径：

/file src/auth.js
/file tests/auth.test.js"
```

### 3. 代码审查准备

**PR 描述生成**:
```vim
<leader>cc → "为这个 Pull Request 生成描述：

变更内容：
- 添加了用户权限管理功能
- 重构了认证中间件
- 修复了内存泄漏问题
- 更新了 API 文档

请包括：
- 变更摘要
- 测试说明
- 部署注意事项
- 破坏性变更说明"
```

## 🚀 高级技巧

### 1. 自定义工作流

**创建专用工作流**:
```lua
-- 在配置中添加
workflows = {
  ["Security Audit"] = {
    strategy = "chat",
    description = "安全审计流程",
    prompts = {
      {
        role = "system",
        content = [[你是一个安全专家，请对代码进行全面的安全审计，包括：
1. SQL 注入风险
2. XSS 攻击防护
3. CSRF 防护
4. 身份认证安全
5. 数据加密
6. 输入验证
7. 权限控制]]
      },
      {
        role = "user",
        content = function(context)
          return "请对以下代码进行安全审计：\n" .. context.selection
        end
      }
    }
  }
}
```

### 2. 上下文增强技巧

**多文件上下文**:
```vim
<leader>cc → 输入以下内容获得完整上下文：

/file src/models/User.js
/file src/controllers/userController.js  
/file src/routes/users.js
/file tests/user.test.js

"基于这些文件，帮我设计一个用户角色权限系统"
```

**项目结构分析**:
```vim
<leader>cc → "分析这个项目的架构：

/file package.json
/file src/index.js
/file src/config/database.js
/file src/models/
/file src/controllers/
/file src/routes/

请提供：
1. 架构模式识别
2. 目录结构优化建议
3. 潜在的架构问题
4. 扩展性改进建议"
```

### 3. 批量操作

**批量重构**:
```vim
# 使用 Telescope 或 grep 找到所有相似代码
:Telescope live_grep

# 选中第一个实例
<leader>cr → 获取重构模式

# 应用到其他实例
<leader>cc → "请将这个重构模式应用到项目中的其他类似代码"
```

**批量测试生成**:
```vim
<leader>cc → "为这个目录下的所有模块生成测试用例：

/file src/utils/
包含：validation.js, formatting.js, encryption.js

要求：
- 统一的测试结构
- 完整的覆盖率
- Mock 外部依赖"
```

### 4. 集成开发环境

**与 Git 集成**:
```vim
# 提交前检查
:!git diff --cached | <leader>cc "审查这些变更，检查是否有问题"

# 提交信息生成
<leader>cc → "基于这些变更生成 Git 提交信息：
$(git diff --cached --stat)"
```

**与 CI/CD 集成**:
```vim
<leader>cc → "为这个项目设计 CI/CD 流水线：

技术栈：
- Node.js + Express
- PostgreSQL 数据库
- Docker 容器化
- AWS 部署

要求：
- 自动测试
- 代码质量检查
- 安全扫描
- 自动部署"
```

## 💡 实用技巧总结

### 快速参考

| 场景 | 快捷键 | 说明 |
|------|--------|------|
| 理解代码 | `<leader>ce` | 解释选中代码 |
| 重构代码 | `<leader>cr` | 重构选中代码 |
| 修复问题 | `<leader>cf` | 修复代码问题 |
| 性能优化 | `<leader>co` | 优化性能 |
| 生成测试 | `<leader>ct` | 生成测试用例 |
| 生成文档 | `<leader>cd` | 生成文档 |
| 代码审查 | `<leader>cwr` | 完整审查流程 |
| Bug 分析 | `<leader>cwb` | Bug 分析流程 |

### 最佳实践

1. **提供充分上下文** - 使用 `/file` 和 `/buffer` 命令
2. **分步骤处理** - 复杂问题拆分成小步骤
3. **验证结果** - 生成代码后要测试和审查
4. **保持学习** - 让 AI 解释其推理过程
5. **安全意识** - 不要提交敏感信息给 AI

---

这个 Cookbook 会持续更新，添加更多实用的场景和技巧。Happy coding! 🎉