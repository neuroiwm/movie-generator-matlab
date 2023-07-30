%% MovieGenerator for MATLAB
% Seitaro Iwama, Asst. Prof. Keio Univ.
% 2023-07-30

classdef MovieGenerator < handle
properties
    is_file_open = 0
    profile = 'MPEG-4'; % default
    FrameRate = 10; 
    file_movie
    obj_movie        
end

methods (Access = public)
    function self = MovieGenerator(path_movie,config)                
        self.set_obj_movie(path_movie)
        if nargin == 2
            self.set_config(config);            
        end
    end

    function self = add_frame(self)
        if self.is_file_open
            frame = getframe(gcf);
            writeVideo(self.obj_movie,frame);
        else
            fprintf('set file before\n');
        end
    end

    function self = close(self)
        if self.is_file_open == 1
            close(self.obj_movie)
            self.is_file_open = 0;
        end
    end
end

methods (Access = protected)

    function set_config(self,config)
        fnames = fieldnames(config);
        for i_name = 1 : numel(fnames)
            try
                self.(fnames{i_name}) = config.(fnames{i_name});
            catch
                fprintf('undefined config: %s \n',fnames{i_name});
            end
        end
    end

    function set_obj_movie(self,path_movie)
        self.file_movie = path_movie;
        self.obj_movie = VideoWriter(path_movie,self.profile);
        self.obj_movie.FrameRate = self.FrameRate;
        open(self.obj_movie);
        self.is_file_open = 1;
    end
end

end