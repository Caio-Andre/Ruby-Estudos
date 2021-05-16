def foo
    local = 'local é acessada apenas dentro deste método'
    p local
end 

foo

local = "\nMesmo nome de variável e n ocorre erro"
puts local