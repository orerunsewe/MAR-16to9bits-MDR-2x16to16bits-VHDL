function output = runsewe_16to16bitmdr() 

fileID_in = fopen('runsewe_16to16bitmdrin.txt', 'w'); 
fileID_out = fopen('runsewe_16to16bitmdrout.txt', 'w'); 

%This block of code generates input and output test vectors for a 16-bit
% input and 9 bit output memory address register with synchronous reset controls 


 for x = 0:3 
    reset2 = '1'; 
    enable2 = '0';   
    op_a2 = dec2bin(x, 16);
    op_a3 = dec2bin(3-x, 16);
    fprintf(fileID_in, '%s\r\n', [reset2 ' ' enable2 ' ' op_a2 ' ' op_a3]);
    fprintf(fileID_out, '%s\r\n', dec2bin(0, 16));
end 

for y = 4:7 
    reset2 = '0'; 
    enable2 = dec2bin(mod(y, 2), 1);
    op_a2 = dec2bin(y, 16);
    op_a3 = dec2bin(7-y, 16);
    fprintf(fileID_in, '%s\r\n', [reset2 ' ' enable2 ' ' op_a2 ' ' op_a3]);
    
    if enable2 == '1'
        s_d2 = op_a2;
        
    else 
        s_d2 = op_a3;
    end 
    fprintf(fileID_out, '%s\r\n', s_d2);
end 

for z = 8:(2^16 - 1) 
    reset2 = '0';
    enable2 = '1'; 
    op_a2 = dec2bin(z,16);
    op_a3 = dec2bin((2^16-1)-z, 16);
    
    fprintf(fileID_in, '%s\r\n', [reset2, ' ' enable2 ' ' op_a2 ' ' op_a3]);
     fprintf(fileID_out, '%s\r\n', op_a2);
end 
