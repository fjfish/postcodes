class PostcodeQueryController < ApplicationController
  def index
    @postcode = params[:postcode]
    @lsoa_matcher = LsoaMatcher.find_by(id: params[:lsoa_matcher_id])
    @found = @lsoa_matcher&.has_postcode(@postcode) if @postcode
  end
end
