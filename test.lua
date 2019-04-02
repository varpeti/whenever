-- init
local whenever = require("whenever")
math.randomseed(os.time())

buffer = {}
function buffer.add(str) buffer.str=buffer.str..str end
function buffer.clear() buffer.str="" end
local goal = ""

function test(input,goal)
    buffer.clear()
    whenever.print = buffer.add
    whenever.start(input)
    print(buffer.str)
    print(buffer.str == goal,"\n")
end


-- test t1
local t1 = 
{
    {3,{"",3,"d","N","G","H","d","N","D","d","R"," ",3,"P"}},
    {1,{"1 ","P"}},
    {2,{" ",2,0,1,"N","E","H",3,"d","I","P"}},
    {"d",{1}},
    
}
test(t1,"1 2 3 4")


-- test count100downto1
local count100downto1 =
{
    {"szam",{1}},
    {"print",{" ","szam","N","sok","N",0,"E","H","P",1,"szam","R","szam","N"}},
    {"sok",{99,"szam","I",0}},
}
test(count100downto1,"100 99 98 97 96 95 94 93 92 91 90 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 ")


-- test fibo
local fibo = 
{
    -- 1 1
    {"numA",{1}},
    {"numB",{1}},
    --   if !(numaA<X) then halt, die else print numaA,  c = numB, numB+=numA,           numaA-=numaA=0,      numA=c,   stay alive
    {"fibo",{"numA","N",99,"G","H"," ","numA","N","P","numB","N","numA","N","numB","I","numA","N","numA","R","numA","I",1}},
    --   if fibo exist then halt, saty alive else remove all numA and numB, print end
    {"end",{"end",0,"fibo","N","E","H","numA","N","numA","R","numB","N","numB","R","P"}}
}
test(fibo,"1 1 2 3 5 8 13 21 34 55 89 end")