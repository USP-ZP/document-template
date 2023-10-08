-----------------------------------------------------------------------------------------------
--  USP-DOC
--  Template para documentos técnicos das USP
--
--  Copyright (c) 2023 Estevão Soares dos Santos
-----------------------------------------------------------------------------------------------

-- LuaTeX has the lfs library built in
if (lfs == nil) then
	lfs = require("lfs")
end

Directory = {}

Directory.detect_os = function ()
    local p = package.config:sub(1,1)
    if (p == '\\') then
        return 'WIN'
    else
        return 'UNIX'
    end
end

Directory.normalize_path = function (path)
    local cwd = lfs.currentdir()

    -- If the path is not absolute, make it so
    if (string.match(path, "^%./")) then
        -- relative path with dot
        path = string.gsub(path, "^./", "")
        path = cwd .. "/" .. path

    elseif (not string.match(path, "^/") and not string.match(path, "^[A-Za-z]:[\\/]")) then
        -- relative path
        path = cwd .. "/" .. path
    end

    -- make windows UNIX Style paths
    path = string.gsub(path, "\\", "/")

    if (not string.match(path, "/$")) then
        path = path .. '/'
    end

    return path
end

---Directory.exists
---Check if a path is a directory. Return false if it's not, and nil if it doesn't exist.
---Does not perform any transformation on the path, namely normalization or
---turning a relative into an aboslute path
---@param path string path to directory to check
Directory.is_dir = function (path)
    local attr = lfs.attributes(path)
    return attr and attr.mode == "directory"
end

---Directory.exists
---Check if directory exists and is a directory. Normalizes the path and transforms relative into absolute paths
---@param path string path to directory to check
Directory.exists = function (path)
    path = Directory.normalize_path(path)
    local test = Directory.is_dir(path)

    if test == true then
        return true
    else
        return false
    end
end

---Directory.is_empy
---Check if directory is empty. Normalizes paths
---@param path string path to directory to check
Directory.is_empty = function (path)
    path = Directory.normalize_path(path)

    if (Directory.exists(path) == false) then
        return nil
    end

    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            return false -- Found a file or directory other than "." or ".."
        end
    end
    return true
end


Directory.get_file_list = function (path, ext)
    path = Directory.normalize_path(path)

    local texFiles = {}
    ext = ext or 'tex'
    local pattern = "%." .. ext .. "$" -- Check if the filename ends with ".ext" (ex: .tex)

    for file in lfs.dir(path) do
        if file:match(pattern) then
            table.insert(texFiles, file)
        end
    end

    return texFiles
end


Directory.tex = {}

Directory.tex.include_all_tex_files = function (path, options)

    if (type(options) ~= "table") then
        options = {
            normalize_path = true,
            with_page_breaks = true
        }
    end

    if (options.normalize_path) then
        path = Directory.normalize_path(path)
    else
        if (not string.match(path, "/$")) then
            path = path .. '/'
        end
    end

    local list = Directory.get_file_list(path, 'tex')

    for _,file in ipairs(list) do
        tex.print("\\input{" .. path .. file .. "}")
        if (options.with_page_breaks) then
            tex.print("\\newpage")
        end
    end

end

return Directory
