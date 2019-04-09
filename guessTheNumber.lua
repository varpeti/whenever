local we = require("whenever")

we.debug=false
we.maxRound=nil

local list =
{   
    -- INIT
    --        Init b=1000 s=0 guess=500                  remove all controll command (except ask)                                              num=0                 div=0                 ret=0                     print the init message
    {"start",{999,"b","I",1,"s","R",499,"guess","I",    "get","D","N","S","R","l","D","N","S","R","g","D","N","S","R","e","D","N","S","R",    "num","D","N","S","R","div","D","N","S","R","ret","D","N","S","R",    "Pick a number between 1-999, and I'll find it!\n","P"}},
    
    -- VARIABLES
    -- biger number
    {"b",{1}},
    -- smaller number
    {"s",{1}},
    -- guess number
    {"guess",{1}},

    -- CONTROLLS
    --                                  b=0                    b+=guess                 guess=0                    num+=(b+s/2)
    {"l",{"","start","N",0,"E","H",    "b","D","N","S","R",    "guess","N","b","I",    "guess","D","N","S","R",    "b","N","num","I","s","N","num","I",2,"div","I",    0}},
    --                                  s=0                    s+=guess                 guess=0                    num+=(b+s/2)
    {"g",{"","start","N",0,"E","H",    "s","D","N","S","R",    "guess","N","s","I",    "guess","D","N","S","R",    "b","N","num","I","s","N","num","I",2,"div","I",    0}},
    --                                 print won               remove evrything
    {"e",{"","start","N",0,"E","H",    "Yayy I won!\n","P",    "guess","D","N","S","R","b","D","N","S","R","s","D","N","S","R",    0}},
    --                                   ask the guess                                                              add get controll command
    {"ask",{"","start","N",0,"E","H",    " Is it (l)ess, (g)reat or (e)qual?\n","guess","N","My guess is: ","P",    1,"get","I",    0}},
    --                                   get the answer from the user and insert into te todolist
    {"get",{"","start","N",0,"E","H",    1,"L","I",    0}},

    -- FUNCTIONS
    -- function (in: num,div out: guess) while num>=div do ret++ num-=div end guess+=ret num=0 div=0 ret=0 end ||| function (in: num,div out: guess) guess+=(num/div) end
    {"num",{"","start","N",0,"E","H",    "","div","N","num","N","G","H",    1,"ret","I",    "div","N","num","R",    1}}, -- num%div != 0
    {"div",{"","start","N",0,"E","H",    "","div","N","num","N","E","H",    1,"ret","I",    "div","N","num","R",    1}}, -- num%div == 0
    {"ret",{"","start","N",0,"E","H",    "","num","N","div","N","G","H",    "ret","N","guess","I",1,"ask","I",    "num","D","N","S","R",    "div","D","N","S","R",    "ret","D","N","S","R"}},
}

we.start(list)