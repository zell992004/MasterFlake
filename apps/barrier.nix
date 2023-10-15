{
 services.barrier.client = {
    enable = true;
    enableDragDrop = true;
    server = "192.168.1.154:24800";
    extraFlags = ["
        -a 192.168.1.154
        --display zell
        --disable-crypto
        -c ~/Documents/test"
    ];
    };
 
}