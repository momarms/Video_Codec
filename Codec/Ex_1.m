width = 352;
height = 288;

for i = 1:5
    output_img = yuv_read_one_frame('flowergarden_short_cif.yuv', i, width, height);
    imshow(output_img(1))
    pause(2)
end