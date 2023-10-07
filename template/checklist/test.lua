-----------------------------------------------------------------------------------------------
--  USP-DOC
--  Template para documentos técnicos das USP
--
--  Copyright (c) 2023 Estevão Soares dos Santos
-----------------------------------------------------------------------------------------------

Actual = ''
Expected = ''

function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

function cwd()
    local str = io.popen("cd"):read()
    str = string.gsub(str, '\\', '/')
    return str
end

local function read_file()
    local f = io.open("template/checklist/test.otp", 'r')
    local otp = ''
    for line in f:lines() do
        --line = string.gsub(line, '^%s*(.-)%s*$', '%1')
        otp = otp .. line .. '\n'
    end
    f:close()
    return otp
end

function string:split(delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(self, delimiter, from, true)
    while delim_from do
        if (delim_from ~= 1) then
            table.insert(result, string.sub(self, from, delim_from-1))
        end
        from = delim_to + 1
        delim_from, delim_to = string.find(self, delimiter, from, true)
    end
    if (from <= #self) then table.insert(result, string.sub(self, from)) end
    return result
end

local function compare_line_by_line(str_a, str_b)
    local a = string.split(str_a, '\n')
    local b = string.split(str_b, '\n')
    local max = 0

    if (#a > #b) then max = #a else max = #b end

    for i = 1, max, 1 do
	    if (a[i] ~= b[i]) then
	        print(i, a[i], b[i])
        end
    end
end


-- mock tex object
tex = {}

tex.print = function (s)
    Actual = Actual .. '\n' .. s
end

dofile(cwd() .. "/template/checklist/processlist.lua")
process_checklist("template/checklist/test.src")

Expected = read_file()

Expected = string.gsub(Expected, '^%s*(.-)%s*$', '%1')
Actual = string.gsub(Actual, '^%s*(.-)%s*$', '%1')

-- Test if it's working
if pcall(function () assert(Expected == Actual, "Does not match") end) then
    print("Funcionou como esperado")
else
    print("Existem diferenças no output")
    print('n', 'expected', 'actual')
    compare_line_by_line(Expected, Actual)
end



