-----------------------------------------------------------------------------------------------
--  USP-DOC
--  Template para documentos técnicos das USP
--
--  Copyright (c) 2023 Estevão Soares dos Santos
-----------------------------------------------------------------------------------------------
require("busted")
package.path = './template/utils/?.lua;' .. package.path

local function cwd()
    local str = io.popen("cd"):read()
    str = string.gsub(str, '\\', '/')
    return str
end

describe("Directory TestCase:", function()
    local Directory = require("directory")

    describe("Directory", function()

        describe(".is_empty()", function ()

            setup(function()
                lfs.mkdir("./template/utils/mock_dir")
            end)

            it("should return true for empty dir", function()
                local path = "./template/utils/mock_dir"
                assert.is_true(Directory.is_empty(path))
            end)

            it("should return false for non empty dir", function()
                local path = "./template/utils/"
                assert.is_false(Directory.is_empty(path))
            end)

            it("should return nil if directory does not exist", function()
                local path = "./template/utils/nhecos"
                assert.is_nil(Directory.is_empty(path))
            end)

            teardown(function()
                lfs.rmdir("./template/utils/mock_dir")
            end)

        end)


        describe(".exists()", function()

            describe("[UNIX style]", function()

                it("should treat ./path/ as relative", function()
                    local path = "./template/"
                    assert.is_true(Directory.exists(path))
                end)

                it("should treat naked left paths (path/something/) as relative", function()
                    local path = "template/utils"
                    assert.is_true(Directory.exists(path))
                end)

                it("should find paths relative to cwd", function()
                    local path = "./template/"
                    assert.is_true(Directory.exists(path))
                end)

            end)

            describe("[WIN style]", function()
                it("should find paths relative to cwd", function()
                    local path = "template\\utils"
                    assert.is_true(Directory.exists(path))
                end)
            end)

            describe("[all]", function()
                it("should return false if directory does not exist", function()
                    local path = "foo/bar"
                    assert.is_false(Directory.exists(path))
                end)
                it("should return false if it's a file", function()
                    local path = "template/utils/directory_exists.lua"
                    assert.is_false(Directory.exists(path))
                end)
            end)
        end)

        describe(".normalize_path()", function ()
            it("should change all \\ to /", function()
                local path = "C:\\foo\\bar/baz/"
                assert.are.equals("C:/foo/bar/baz/", Directory.normalize_path(path))
            end)

            it("should not modify abolsute paths with / that end with /", function()
                local path = "C:/foo/bar/baz/"
                assert.are.equals(path, Directory.normalize_path(path))
            end)

            it("should add / to end of path", function()
                local path = "C:/foo/bar/baz"
                assert.are.equals("C:/foo/bar/baz/", Directory.normalize_path(path))
            end)

        end)

        describe(".is_dir()", function ()

            setup(function()
                lfs.mkdir("./template/utils/mock_dir")
            end)

            it("should return true for a directory", function()
                local path = "./template/utils"
                assert.is_true(Directory.is_dir(path))
            end)

            it("should return true for an empty dir", function()
                local path = "./template/utils/mock_dir"
                assert.is_true(Directory.is_dir(path))
            end)

            it("should return nil for a non existing dir", function()
                local path = "./template/utils/foobar"
                assert.is_nil(Directory.is_dir(path))
            end)

            it("should return false for a file", function ()
                local path = "./template/utils/directory_spec.lua"
                assert.is_false(Directory.is_dir(path))
            end)

            teardown(function()
                lfs.rmdir("./template/utils/mock_dir")
            end)

        end)

    end)
end)



