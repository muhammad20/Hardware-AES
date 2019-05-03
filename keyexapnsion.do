---------------------Nk = 4
force -freeze sim:/keyexpansion/Nk 4'h4 0
force -freeze sim:/keyexpansion/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/keyexpansion/rst 1'h1 0
force -freeze sim:/keyexpansion/key 256'h2b7e151628aed2a6abf7158809cf4f3c 0
run

force -freeze sim:/keyexpansion/rst 1'h0 0
run

---------------------Nk = 6
force -freeze sim:/keyexpansion/Nk 4'h6 0
force -freeze sim:/keyexpansion/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/keyexpansion/rst 1'h1 0
force -freeze sim:/keyexpansion/key 256'h8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b 0
run

force -freeze sim:/keyexpansion/rst 1'h0 0
run


------------------Nk = 8
force -freeze sim:/keyexpansion/Nk 4'h8 0
force -freeze sim:/keyexpansion/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/keyexpansion/rst 1'h1 0
force -freeze sim:/keyexpansion/key 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4 0
run

force -freeze sim:/keyexpansion/rst 1'h0 0
run





