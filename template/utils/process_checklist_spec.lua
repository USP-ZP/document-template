-----------------------------------------------------------------------------------------------
--  USP-DOC
--  Template para documentos técnicos das USP
--
--  Copyright (c) 2023 Estevão Soares dos Santos
-----------------------------------------------------------------------------------------------
require("busted")

local function read_file()
    local f = io.open("template/utils/test.otp", 'r')
    local otp = ''
    for line in f:lines() do
        --line = string.gsub(line, '^%s*(.-)%s*$', '%1')
        otp = otp .. line .. '\n'
    end
    f:close()
    return otp
end

describe("Checklist TestCase:", function()
    dofile("template/utils/process_checklist.lua")

    expose("process_checklist", function()
        local actual = ""
        _G.tex = {
            print = function (s)
                actual = actual .. '\n' .. s
            end
        }

        it("should parse a file and produce a correct output", function()
            local expected = read_file()
            process_checklist("template/utils/test.src")
            expected = string.gsub(expected, '^%s*(.-)%s*$', '%1')
            actual = string.gsub(actual, '^%s*(.-)%s*$', '%1')
            assert.are.equal(actual, expected)
        end)

        it("should throw if given a non existant file", function()
            assert.has_error(
                function() process_checklist("template/foo.txt") end,
                "File template/foo.txt not found!"
            )
        end)

    end)
end)
