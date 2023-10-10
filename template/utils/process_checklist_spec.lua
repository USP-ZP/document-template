-----------------------------------------------------------------------------------------------
--  USP-DOC
--  Template para documentos técnicos das USP
--
--  Copyright (c) 2023 Estevão Soares dos Santos
-----------------------------------------------------------------------------------------------
require("busted")

local function read_file(path)
    local f = io.open(path, 'r')
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
        local base_path = "./template/utils/testfiles/process_checklist/"
        local actual = ""
        _G.tex = {
            print = function (s)
                actual = actual .. '\n' .. s
            end
        }
        before_each(function()
            actual = ""
        end)

        it("should parse \\pagebreaks", function ()
            local expected = read_file(base_path .. "pagebreak.otp")
            process_checklist(base_path .."pagebreak.src")
            expected = string.gsub(expected, '^%s*(.-)%s*$', '%1')
            actual = string.gsub(actual, '^%s*(.-)%s*$', '%1')
            assert.are.equal(expected, actual)
        end)

        it("should parse \\sections", function ()
            local expected = read_file(base_path .."section.otp")
            process_checklist(base_path .. "section.src")
            expected = string.gsub(expected, '^%s*(.-)%s*$', '%1')
            actual = string.gsub(actual, '^%s*(.-)%s*$', '%1')
            assert.are.equal(expected, actual)
        end)

        it("should parse \\tables", function ()
            local expected = read_file(base_path .."table.otp")
            process_checklist(base_path .. "table.src")
            expected = string.gsub(expected, '^%s*(.-)%s*$', '%1')
            actual = string.gsub(actual, '^%s*(.-)%s*$', '%1')
            assert.are.equal(expected, actual)
        end)

        it("should parse a file and produce a correct output", function()
            local expected = read_file(base_path .. "complete_test.otp")
            process_checklist(base_path .. "complete_test.src")
            expected = string.gsub(expected, '^%s*(.-)%s*$', '%1')
            actual = string.gsub(actual, '^%s*(.-)%s*$', '%1')
            assert.are.equal(expected, actual)
        end)

        it("should parse a file and produce a correct output", function()
            local expected = read_file(base_path .. "complete_test.otp")
            process_checklist(base_path .. "complete_test.src")
            expected = string.gsub(expected, '^%s*(.-)%s*$', '%1')
            actual = string.gsub(actual, '^%s*(.-)%s*$', '%1')
            assert.are.equal(expected, actual)
        end)

        it("should parse º characters correctly", function()
            local expected = read_file(base_path .. "simbolo_grau.otp")
            process_checklist(base_path .. "simbolo_grau.src")
            expected = string.gsub(expected, '^%s*(.-)%s*$', '%1')
            actual = string.gsub(actual, '^%s*(.-)%s*$', '%1')
            assert.are.equal(expected, actual)
        end)

        after_each(function()
            actual = ""
        end)


        it("should throw if given a non existant file", function()
            assert.has_error(
                function() process_checklist("template/foo.txt") end,
                "File template/foo.txt not found!"
            )
        end)

    end)
end)
