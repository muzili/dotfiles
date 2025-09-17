-- AI Provider Configuration for CodeCompanion
-- This file contains configuration for various AI providers
-- API keys are retrieved using GPG

---@type table
local M = {}

-- 缓存已解密的 API 密钥
local _key_cache = {}

-- Function to decrypt GPG-encrypted API key
---@param key_name string
---@return string|nil
local function get_gpg_api_key(key_name)
  -- 检查缓存
  if _key_cache[key_name] ~= nil then
    return _key_cache[key_name]
  end
  
  local gpg_id = os.getenv("GPG_ID") or "default"
  local key_file = os.getenv("HOME") .. "/." .. key_name .. ".gpg"
  
  -- Check if the key file exists
  local file = io.open(key_file, "r")
  if not file then
    _key_cache[key_name] = false
    return nil
  end
  file:close()
  
  -- Decrypt the key using gpg
  local handle = io.popen(string.format("gpg --quiet --decrypt %s 2>/dev/null", key_file))
  if not handle then
    _key_cache[key_name] = false
    return nil
  end
  
  local api_key = handle:read("*a"):gsub("\n", "")
  handle:close()
  
  local result = api_key ~= "" and api_key or nil
  _key_cache[key_name] = result
  return result
end

-- Function to get API key from environment or GPG
---@param provider string
---@return string|nil
local function get_api_key(provider)
  -- First try environment variable
  local env_key = os.getenv(string.format("%s_API_KEY", provider:upper()))
  if env_key and env_key ~= "" then
    return env_key
  end
  
  -- Then try GPG
  return get_gpg_api_key(provider)
end

-- 延迟初始化配置，避免启动时的 GPG 操作
local _config_cache = nil

local function get_config_lazy()
  if _config_cache then
    return _config_cache
  end
  
  _config_cache = {
    -- Zhipu AI Configuration (Primary)
    zhipu = {
      api_key = function() return get_api_key("zhipu") end,
      model = "glm-4-flash",
      endpoint = "https://open.bigmodel.cn/api/paas/v4",
      max_tokens = 4000,
      temperature = 0.1,
      headers = {
        ["Content-Type"] = "application/json",
      },
    },
    
    -- Bailian AI Configuration (Backup)
    bailian = {
      api_key = function() return get_api_key("bailian") end,
      app_id = function() return os.getenv "BAILIAN_APP_ID" or get_gpg_api_key("bailian_app_id") end,
      model = "qwen-turbo",
      endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
      max_tokens = 4000,
      temperature = 0.1,
      headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = function() 
          local key = get_api_key("bailian")
          return key and "Bearer " .. key or nil
        end,
      },
    },
    
    -- OpenAI Configuration (fallback)
    openai = {
      api_key = function() return get_api_key("openai") end,
      model = "gpt-4",
      endpoint = "https://api.openai.com/v1",
      max_tokens = 4000,
      temperature = 0.1,
    },
    
    -- Anthropic Claude Configuration
    anthropic = {
      api_key = function() return get_api_key("anthropic") end,
      model = "claude-3-sonnet-20240229",
      endpoint = "https://api.anthropic.com",
      max_tokens = 4000,
      temperature = 0.1,
    },
    
    -- Google Gemini Configuration
    gemini = {
      api_key = function() return get_api_key("gemini") end,
      model = "gemini-pro",
      endpoint = "https://generativelanguage.googleapis.com/v1",
      max_tokens = 4000,
      temperature = 0.1,
    },
    
    -- Local LLM Configuration (Ollama)
    ollama = {
      api_key = "ollama",  -- Not used for local models
      model = "codellama",
      endpoint = "http://localhost:11434",
      max_tokens = 4000,
      temperature = 0.1,
    },
  }
  
  return _config_cache
end

M.config = setmetatable({}, {
  __index = function(_, key)
    return get_config_lazy()[key]
  end
})

-- Function to get configuration for a specific provider
---@param provider string
---@return table|nil
M.get_config = function(provider)
  local config = M.config[provider]
  if not config then return nil end
  
  -- 解析函数类型的配置项
  local resolved_config = {}
  for k, v in pairs(config) do
    if type(v) == "function" then
      resolved_config[k] = v()
    else
      resolved_config[k] = v
    end
  end
  
  return resolved_config
end

-- Function to check if a provider is configured
---@param provider string
---@return boolean
M.is_configured = function(provider)
  local config_template = get_config_lazy()[provider]
  if not config_template then return false end
  
  -- Special check for ollama (no API key needed)
  if provider == "ollama" then
    return true
  end
  
  -- 检查 API 密钥，但不立即解析
  local api_key_func = config_template.api_key
  if type(api_key_func) == "function" then
    local key = api_key_func()
    return key and key ~= ""
  end
  
  return false
end

-- Function to get primary provider with fallback
---@return string|nil
M.get_primary_provider = function()
  -- Priority order: zhipu > bailian > openai > anthropic > gemini > ollama
  local priority = { "zhipu", "bailian", "openai", "anthropic", "gemini", "ollama" }
  
  for _, provider in ipairs(priority) do
    if M.is_configured(provider) then
      return provider
    end
  end
  
  return nil
end

-- Function to list available providers
---@return string[]
M.list_providers = function()
  local providers = {}
  for provider, _ in pairs(M.config) do
    if M.is_configured(provider) then
      table.insert(providers, provider)
    end
  end
  return providers
end

return M