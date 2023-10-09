-----------------------------------------------------------------------------------------------
---  USP-DOC
---  Template para documentos técnicos das USP
---
---  Copyright (c) 2023 Estevão Soares dos Santos
-----------------------------------------------------------------------------------------------

local tipo_de_documento = {
    {letra = "D", extenso="documento"},         -- 1 Documento
    {letra = "R", extenso="recomendacao"},      -- 2 Recomendação
    {letra = "P", extenso="procedimento"},      -- 3 Procedimento
    {letra = "I", extenso="instrucaotrabalho"}, -- 4 Instrução de Trabalho
    {letra = "C", extenso="checklist"}          -- 5 Lista de Verificação
}

local config_keys = {
    "tipoDeDocumento",
    "titulo",
    "id",
    "ano",
    "major",
    "minor",
    "patch",
    "dataElaboracao",
    "dataRevisao",
    "dataAprovacao",
    "pchave",
    "destinatarios",
    "local",
    "contacto",
    "proposta",
    "equipaRedatora",
    "equipaRevisora",
    "equipaConsultora"
}

function parse_config(path)
    local yaml = require("tinyyaml")
    local file = io.open(path, "r")
    local yaml_content = file:read("*all")
    file:close()
    local cfg = yaml.parse(yaml_content)

    -- validate config
    for _,key in ipairs(config_keys) do

        if (cfg[key] ==nil ) then error("O ficheiro config.yml não tem a chave '" .. key .."'") end

        if (string.match(key, "^data") and cfg[key] == "")then
            cfg[key] = os.date("%Y-%m-%d")
        end

    end

    -- add numero e versao
    cfg.versao = cfg.major .. '.' .. cfg.minor .. '.' .. cfg.patch
    cfg.numero = tipo_de_documento[cfg.tipoDeDocumento].letra .. cfg.id .. '.' .. cfg.ano

    -- create variable for tipodocumento (verbose version of tipoDeDocumento, because it's more readable in LaTeX)
    cfg.tipodocumento = tipo_de_documento[cfg.tipoDeDocumento].extenso

    for key,val in pairs(cfg) do
        if (type(val) == "table") then
            val = table.concat(val,", ")
        end
        tex.print("\\newcommand{\\".. key .."}{" .. val .."}")
    end

    return cfg
end
