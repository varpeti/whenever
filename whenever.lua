local whenever = {}
whenever.print = io.write
whenever.maxRound = nil

local function list2todo(id)
    table.insert(whenever.todo,{whenever.list[id][1],whenever.list[id][2]})
end

local function run(cmd)
    if     cmd=="P" then -- print whole stack
        for i=0,#whenever.stack-1 do
            whenever.print(whenever.stack[#whenever.stack-i])
        end
        whenever.stack = {}
        
    elseif cmd=="N" then -- get 1 value from stack and return the count of every occurence in the todo.
        local p1 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        local c = 0
        for i,v in ipairs(whenever.todo) do
            if (v[1])==(p1) then c=c+1 end
        end
        table.insert(whenever.stack,c)
    elseif cmd=="G" then -- get 2 value from stack and if the 1st is grater than the 2nd push 1 to stack othervise 0
        local p1 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        local p2 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        p1 = tonumber(p1)
        p2 = tonumber(p2)
        if p1 and p2 and p1>p2 then 
            table.insert(whenever.stack,1)
        else
            table.insert(whenever.stack,0)
        end
    elseif cmd=="E" then -- get 2 value from stack and if it is equals push 1 to stack othervise 0
        local p1 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        local p2 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        if p1==p2 then
            table.insert(whenever.stack,1)
        else
            table.insert(whenever.stack,0)
        end
    elseif cmd=="H" then -- get 1 value from stack if its 0 halt
        local p1 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        if p1==0 then return false end
    elseif cmd=="I" then -- get 2 value from stack and insert the [p1] instruction(s) of list into todo [p2] times
        local p1 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        local p2 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        p2 = tonumber(p2)
        for i,v in ipairs(whenever.list) do
            if v[1]==p1 then
                for j=1,p2 do
                    list2todo(i)
                end
            end
        end
    elseif cmd=="R" then -- get 2 value from stack and remove the [p1] instruction of todo [p2] times
        local p1 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        local p2 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        p2 = tonumber(p2)
        for j=1,p2 do
            for i,v in ipairs(whenever.todo) do
                if v[1]==p1 then
                    whenever.todo[i]={0,{0}} -- spawn a zombi
                    break
                end      
            end
        end
    elseif cmd=="D" then -- get 1 value from stack and push it twice
        local p1 = whenever.stack[#whenever.stack] table.remove(whenever.stack,#whenever.stack)
        table.insert(whenever.stack,p1)
        table.insert(whenever.stack,p1)
    else
        table.insert(whenever.stack,cmd)
    end
    return true
end

function whenever.start(list)
    whenever.list = list
    whenever.todo = {}
    for i,v in ipairs(list) do
        list2todo(i)
    end

    while #whenever.todo>0 do
        local r = math.random(1,#whenever.todo)
        --io.write("\n"..whenever.todo[r][1]..":")

        -- run every command
        whenever.stack = {}
        for i,v in ipairs(whenever.todo[r][2]) do
            if not run(v) then break end
        end

        if #whenever.stack==0 or whenever.stack[#whenever.stack]==0 then
            table.remove(whenever.todo,r)
        end

        --io.write(":") for i,v in ipairs(whenever.todo) do io.write(" "..v[1]) end
        if whenever.maxRound then
            if whenever.maxRound==0 then 
                whenever.maxRound=nil
                break 
            else
                whenever.maxRound=whenever.maxRound-1
            end
        end
    end
end

return whenever