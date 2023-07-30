fs = 30;
path_movie = './test_movie.mp4';
num_frame = 60;
sz_mat = 30;
t = 1/fs:1/fs:num_frame/fs;

config = struct;
config.FrameRate = fs;
config.profile = 'MPEG-4';

movie_generator = MovieGenerator(path_movie,config);

figure;
hs = imagesc(zeros(sz_mat));
colormap("gray");
caxis([-1 1])
axis off;
movie_generator.add_frame;
for i_frame = 1 : num_frame
    hs.CData = ones(sz_mat).*sin(2*pi*1*t(i_frame)) + rand(sz_mat);
    drawnow;
    movie_generator.add_frame;
    pause(1/30);
end

movie_generator.close;

