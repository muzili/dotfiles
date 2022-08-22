local M = {}

M.setup = function() -- {{{
    local fd_opts = {
        '--exclude', '.cache',
        '--exclude', 'tmp',
        '--exclude', '.config',
    }
    require('which-key').register({
        f = {
            p = {string.format('<Cmd>lua require("telescope").extensions.repo.list({fd_opts=%s})<CR>', vim.inspect(fd_opts)), 'projects'},
            P = {'<Cmd>lua require("telescope").extensions.repo.cached_list()<CR>', 'projects (cached)'},
        },
    }, {prefix = '<leader>'})
end -- }}}

return M
