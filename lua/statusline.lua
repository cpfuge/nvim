-- statusline configuration
local statusline_modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function get_mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", statusline_modes[current_mode]):upper()
end

local function update_mode_colors()
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_color = "%#StatusLineAccent#"

    if current_mode == "n" then
        mode_color = "%#StatuslineAccent#"
    elseif current_mode == "i" or current_mode == "ic" then
        mode_color = "%#StatuslineInsertAccent#"
    elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        mode_color = "%#StatuslineVisualAccent#"
    elseif current_mode == "R" then
        mode_color = "%#StatuslineReplaceAccent#"
    elseif current_mode == "c" then
        mode_color = "%#StatuslineCmdLineAccent#"
    elseif current_mode == "t" then
        mode_color = "%#StatuslineTerminalAccent#"
    end

    return mode_color
end

local function get_file_path()
    local file_path = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")

    if file_path == "" or file_path == "." then
        return " "
    end

    return string.format(" %%<%s/", file_path)
end

local function get_file_name()
    local file_name = vim.fn.expand "%:t"
    
    if file_name == "" then
        return ""
    end
    
    return file_name .. " "
end

local function get_file_type()
    return string.format(" %s ", vim.bo.filetype):upper()
end

local function get_line_info()
    if vim.bo.filetype == "alpha" then
        return ""
    end

    return " %P %l:%c "
end

Statusline = {}

Statusline.active = function()
    return table.concat {
        "%#Statusline#",
        update_mode_colors(),
        get_mode(),
        get_file_path(),
        get_file_name(),
        "%=%#StatusLineExtra#",
        get_file_type(),
        get_line_info(),
    }
end

function Statusline.inactive()
    return " %F"
end

function Statusline.short()
    return "%#StatusLineNC# NvimTree"
end

vim.api.nvim_exec([[
    augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
    au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
    au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
    augroup END
]], false)
