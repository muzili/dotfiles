-- 轻量级 AI 配置，避免启动时的性能影响
local M = {}

-- 简单的提供商检查，不执行任何 I/O 操作
M.get_primary_provider = function()
  -- 优先级顺序，但不立即检查 API 密钥
  local providers = { "zhipu", "openai", "ollama" }
  return providers[1] -- 默认返回第一个
end

M.list_providers = function()
  return { "zhipu", "openai" } -- 简化的提供商列表
end

M.get_config = function(provider)
  -- 返回基本配置，API 密钥在实际使用时再获取
  local configs = {
    zhipu = {
      model = "glm-4-flash",
      endpoint = "https://open.bigmodel.cn/api/paas/v4",
      max_tokens = 4000,
      temperature = 0.1,
    },
    openai = {
      model = "gpt-4",
      endpoint = "https://api.openai.com/v1",
      max_tokens = 4000,
      temperature = 0.1,
    },
    ollama = {
      model = "codellama",
      endpoint = "http://localhost:11434",
      max_tokens = 4000,
      temperature = 0.1,
    },
  }
  
  return configs[provider]
end

return M