local function parse_input(file, input_table)
    local f = io.open(file, "r")

    for line in f:lines() do
        table.insert(input_table, line)
    end

    f:close()
end

local function main()
    local input = {}

    parse_input("./1.txt", input)

    accum = 0
    for _, str in pairs(input) do
        for mul_unit in string.gmatch(str, "mul%(%d+,%d+%)") do
            local operands = {}
            for num in string.gmatch(mul_unit, "%d+") do
                table.insert(operands, num)
            end
            accum = accum + (operands[1] * operands[2])
        end
    end
    print(accum) --> 174103751
end

main()