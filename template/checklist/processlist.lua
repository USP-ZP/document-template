-----------------------------------------------------------------------------------------------
--  USP-DOC
--  Template para documentos técnicos das USP
--
--  Copyright (c) 2023 Estevão Soares dos Santos
-----------------------------------------------------------------------------------------------

local function process_checklist_create_output_table(file_name)
    local line_number = 0
    local table_is_open = false
    local table_counter = 1
    local otp = {}

    local f = io.open(file_name, 'r')
    for ln in f:lines() do
        line_number = line_number + 1

        -- Remove leading and trailing spaces
        local line = string.gsub(ln, '^%s*(.-)%s*$', '%1')
        -- change backslash to forwardslash because of latex macros
        line = string.gsub(line, '\\', '/')

        -- if line is empty, we just ignore it
        if (line == nil or line == '') then
            goto continue
        end

        -- get the first character of string
        local first_char = string.sub(line, 1, 1)

        -- if the char is # and a table is NOT open, then it's a section
        if (first_char == '#') then
            -- count # at the start, for section level
            local chars_at_start = string.match(line, '^[#]+')
            local level = chars_at_start:len()

            -- remove the #
            line = string.gsub(line, '^[#]+ *', '')

            if (table_is_open == true) then
                -- A table was opened, so we need to close it
                table.insert(otp, {tipo="table_close", text=""})
                table_is_open = false
            end

            -- print a section
            local foo = {tipo="section", level=level, text=line}
            table.insert(otp, foo)

	        -- we turn inside_section = true
            -- we continue...
	        goto continue
        end


        -- if it matches `^\d+ ` (number dot space), it's a checlist item
        if (string.match(line, '^%d+%. ') ~= nil) then
	        -- we need to check if it's opening a table
	        if (table_is_open == false) then
	            -- first item of a new table
	            local foo = {tipo="table_header", text=""}
	            table.insert(otp, foo)
	            table_is_open = true
	        end

	        -- remove the numbers
	        line = string.gsub(line, '^%d+%. +', '')

            -- insert into otp list
            local foo = {tipo="checklist_item", num=table_counter, text=line}
	        table.insert(otp, foo)
	        table_counter = table_counter + 1

	        goto continue
        end

        -- if we reached here, then is part of multiline (either section of checklist item)
        if (otp[#otp].tipo ~= 'table_header' and otp[#otp].tipo ~= 'table_close') then
	        otp[#otp].text = otp[#otp].text .. ' ' .. line
        end

        ::continue::
    end

    f:close()

    -- we reached the end of the file, so if we have any opened tables, we must closed them
    if (table_is_open == true and otp[#otp].tipo ~= 'table_close') then
	    table.insert(otp, {tipo="table_close", text=""})
    end

    return otp
end

local function process_checklist_make_section(text, level)
    if (level == 1) then
        tex.print('\\subsection{' .. text .. '}')
	else
	    tex.print('\\subsubsection{' .. text .. '}')
    end

end

local function process_checklist_make_table_header()
    tex.print("\\begin{flushleft}")
    tex.print("\\rowcolors{2}{gray!25}{white}")
    tex.print("\\begin{tabularx}{\\textwidth}{|c|X|c|c|c|}")
    tex.print("\\hline")
    tex.print("  & \\textbf{Item} & \\textbf{S} & \\textbf{N} & \\textbf{N/A} \\\\")
    tex.print("\\hline")
end

local function process_checklist_make_checklist_item(num, text)
    tex.print(num .. " & " .. text .. " &  &  & \\\\")
    tex.print("\\hline")
end

local function process_checklist_make_table_close()
    tex.print("\\end{tabularx}\n\\end{flushleft}")
end

local function process_checklist_print_stuff(tab)
    for i,line in ipairs(tab) do
        if (line.tipo == 'section') then
    	    process_checklist_make_section(line.text, line.level)
    	elseif (line.tipo == 'table_header') then
    	    process_checklist_make_table_header()
    	elseif (line.tipo == 'checklist_item') then
            process_checklist_make_checklist_item(line.num, line.text)
    	elseif (line.tipo == 'table_close') then
            process_checklist_make_table_close()
        end
    end
end


function process_checklist(file_name)
    local otp = process_checklist_create_output_table(file_name)
    process_checklist_print_stuff(otp)
end
