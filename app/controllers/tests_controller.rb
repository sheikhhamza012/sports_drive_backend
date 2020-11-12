class TestsController < ApplicationController 
    def index 
        byebug       
        @path_to_file='excel.xlsx'
        redirect_to RankmiExcelReview::Engine.routes.url_helpers.review_index_path(:path_to_file=>@path_to_file)
    end
    def form
    end
end
