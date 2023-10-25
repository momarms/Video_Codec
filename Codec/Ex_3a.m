% Initialize
R = [];
D = [];
figure('name', 'D(R) Curve');

% Read 1st frame of the sequence
img =  imread('flowergarden_cif_frame1.tif');

% Display D(R) curve for all JPEG qualities
for i = 0 : 100
    
    %Store the frame as JPEG
    imwrite(img, 'flowergarden_cif_frame1.jpg', 'Quality', i);
    
    % Load the JPEG image
    jpg_img = imread('flowergarden_cif_frame1.jpg');
    
    % Calculate file size in bits
    file_size = get_image_filesize('flowergarden_cif_frame1.jpg');

    % Calculate rate in bits per pixel & distortion in dB
    R(i + 1) = file_size / (size(jpg_img, 1) * size(jpg_img, 2));
    D(i + 1) = psnr_of_frame(img, jpg_img);
    
    % Plot the D(R) curve
    plot(R, D);
    title('Distortion - Rate Curve');
    xlabel('Rate (bits / pixel)');
    ylabel('PSNR (dB)');
    pause(0.1)
    
end


