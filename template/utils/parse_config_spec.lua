-----------------------------------------------------------------------------------------------
---  USP-DOC
---  Template para documentos técnicos das USP
---
---  Copyright (c) 2023 Estevão Soares dos Santos
-----------------------------------------------------------------------------------------------
require("busted")

describe("Checklist TestCase:", function()
    dofile("template/utils/parse_config.lua")

    expose("process_checklist", function()
        local actual = ""
        _G.tex = {
            print = function (s)
                actual = actual .. '\n' .. s
            end
        }



    end)

end)