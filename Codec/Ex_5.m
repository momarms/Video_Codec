% Ex 5.1

verify_blockbased_dct_on_image;

% Ex 5.2

verify_blockbased_idct_on_image;

% Ex 5.3

verify_generate_zigzag_permutation_matrix

% Ex 5.4

width = 8;
height = 8;

permutation_matrix = generate_zigzag_permutation_matrix(width, height);
zigzag_scanned = encoding_to_zigzag_scanned(permutation_matrix);

% Ex 5.5

output_image = decoding_from_zigzag_scanned(zigzag_scanned, width, height);

% Ex 5.6

verify_blockbased_encoding_to_zigzag_scanned;

% Ex 5.7

verify_blockbased_decoding_from_zigzag_scanned;

%%

% Ex 5.8

verify_encoding_to_runlevel_representation;

% Ex 5.9

verify_decoding_from_runlevel_representation;

% Ex 5.10

verify_blockbased_encoding_to_runlevel_representation;

% Ex 5.11

verify_blockbased_decoding_from_runlevel_representation;

% Ex 5.12 & Ex 5.13

qp = [6 8 10 15 20 35];
verify_intra_coding(qp);