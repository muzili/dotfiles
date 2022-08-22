local M = {}

M.config = function()
    local actions = {
        ["i"] = {
            ["<A-c>"] = 'create',
            ["<A-r>"] = 'rename',
            ["<A-m>"] = 'move',
            ["<A-y>"] = 'copy',
            ["<A-d>"] = 'remove',
            ["<C-o>"] = 'open',
            ["<C-g>"] = 'goto_parent_dir',
            ["<C-e>"] = 'goto_home_dir',
            ["<C-w>"] = 'goto_cwd',
            ["<C-t>"] = 'change_cwd',
            ["<C-f>"] = 'toggle_browser',
            ["<C-h>"] = 'toggle_hidden',
            ["<C-s>"] = 'toggle_all',
        },
        ["n"] = {
            ["c"] = 'create',
            ["r"] = 'rename',
            ["m"] = 'move',
            ["y"] = 'copy',
            ["d"] = 'remove',
            ["o"] = 'open',
            ["g"] = 'goto_parent_dir',
            ["e"] = 'goto_home_dir',
            ["w"] = 'goto_cwd',
            ["t"] = 'change_cwd',
            ["f"] = 'toggle_browser',
            ["h"] = 'toggle_hidden',
            ["s"] = 'toggle_all',
        },
    }

    local function get_action(action)
        return function(prompt_bufnr)
            vim.cmd(string.format([[noautocmd lua require("telescope").extensions.file_browser.actions.%s(%d)]], action, prompt_bufnr))
        end
    end

    local mappings = {}
    for _, mode in ipairs({'i', 'n'}) do
        local keys = {}
        for key, action in pairs(actions[mode]) do
            keys[key] = get_action(action)
        end
        mappings[mode] = keys
    end

    require("telescope").setup({
        extensions = {
            file_browser = {
                mappings = mappings,
            },
        },
    })
end

return M
