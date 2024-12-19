function mock
        if test (count $argv) -gt 2
                set method $argv[3]
        else
                set method PUT
        end
        if test (count $argv) -gt 1
                set body $argv[2]
        else
                set body ''
        end
        if test (count $argv) -eq 0
                return
        end
        curl --noproxy '*' -X $method -H "Content-Type: application/json" http://localhost:8080/$argv[1] -d $body
        echo curl --noproxy '*' -X $method -H "Content-Type: application/json" http://localhost:8080/$argv[1] -d $body
end
