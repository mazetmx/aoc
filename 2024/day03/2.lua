local function parse_input(file, input_table)
    local f = io.open(file, "r")

    for line in f:lines() do
        table.insert(input_table, line)
    end

    f:close()
end

local function main()
    local input = {}

    parse_input("./2.txt", input)

    comp = true
    accum = 0
    for _, str in pairs(input) do
        for i = 1, #str do
            local char = str:sub(i, i)

            -- do() instruction
            if char == "d" and i < #str - 3 then
                local char_o = str:sub(i+1, i+1)
                local char_bro = str:sub(i+2, i+2)
                local char_brc = str:sub(i+3, i+3)
                if char_o == "o" and char_bro == "(" and char_brc == ")" then
                    comp = true
                end
            end

            -- don't() instruction
            if char == "d" and i < #str - 6 then
                local char_o = str:sub(i+1, i+1)
                local char_n = str:sub(i+2, i+2)
                local char_aps = str:sub(i+3, i+3)
                local char_t = str:sub(i+4, i+4)
                local char_bro = str:sub(i+5, i+5)
                local char_brc = str:sub(i+6, i+6)
                if char_o == "o" and char_n == "n" and char_aps == "'" and char_t == "t" and char_bro == "(" and char_brc == ")" then
                    comp = false
                end
            end

            -- mul() instruction
            if not comp then goto continue end

            local j = i
            local substr = ""
            if char == "m" then
                local char_u = str:sub(i+1, i+1)
                local char_l = str:sub(i+2, i+2)
                local char_op = str:sub(i+3, i+3)

                if char_u ~= "u" or char_l ~= "l" or char_op ~= "(" then goto continue end

                substr = ""
                local next_char = "m"
                while #substr <= 12 and next_char ~= " " do
                    substr = substr .. next_char
                    next_char = str:sub(j+1, j+1)
                    j = j + 1
                    if next_char == ")" then substr = substr .. next_char; break end
                end

                for mul_unit in string.gmatch(substr, "mul%(%d+,%d+%)") do
                    local operands = {}
                    for num in string.gmatch(mul_unit, "%d+") do
                        table.insert(operands, num)
                    end
                    if comp then 
                        accum = accum + (operands[1] * operands[2])
                    end
                end
            end

            ::continue::
        end
    end

    print(accum) --> 100411201
end

main()