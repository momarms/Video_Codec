function [outputArg1,outputArg2] = plot_geometries(Cell_array)
%PLOT_GEOMETRIES Summary of this function goes here
%   Detailed explanation goes here

Cell_array = cell(5,2);

Cell_array{1,1}='point';
Cell_array{2,1}='line';
Cell_array{3,1}='triangle';
Cell_array{4,1}='rectangle';
Cell_array{5,1}='cuboid';

Cell_array{2,1}=[];
Cell_array{2,2}=[];
Cell_array{2,3}=[];
Cell_array{2,4}=[];
Cell_array{2,5}=[];

end

