function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

function cwd()
    local str = io.popen("cd"):read()
    str = string.gsub(str, '\\', '/')
    return str
end

-- mock tex object
tex = {}
tex.print = function (s)
    print(s)
end

dofile(cwd() .. "/template/checklist/processlist.lua")
process_checklist("template/checklist/test.src")
