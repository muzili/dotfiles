-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- 只导入核心语言包，其他按需延迟加载
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.json" },
  -- 延迟加载的语言包
  { 
    import = "astrocommunity.pack.rust", 
    cond = function() 
      return vim.fn.glob("*.rs") ~= "" or vim.fn.glob("Cargo.toml") ~= "" 
    end 
  },
  { 
    import = "astrocommunity.pack.cpp", 
    cond = function() 
      return vim.fn.glob("*.{cpp,cc,c,h,hpp}") ~= "" or vim.fn.glob("CMakeLists.txt") ~= "" 
    end 
  },
  { 
    import = "astrocommunity.pack.java", 
    cond = function() 
      return vim.fn.glob("*.java") ~= "" or vim.fn.glob("pom.xml") ~= "" 
    end 
  },
  { 
    import = "astrocommunity.pack.bash", 
    cond = function() 
      return vim.fn.glob("*.{sh,bash}") ~= "" 
    end 
  },
  { 
    import = "astrocommunity.pack.cmake", 
    cond = function() 
      return vim.fn.glob("CMakeLists.txt") ~= "" 
    end 
  },
  { 
    import = "astrocommunity.pack.hurl", 
    cond = function() 
      return vim.fn.glob("*.hurl") ~= "" 
    end 
  },
}
