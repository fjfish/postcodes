class LsoaMatchersController < ApplicationController
  before_action :set_lsoa_matcher, only: %i[ show edit update destroy ]

  # GET /lsoa_matchers or /lsoa_matchers.json
  def index
    @lsoa_matchers = LsoaMatcher.all
  end

  # GET /lsoa_matchers/1 or /lsoa_matchers/1.json
  def show
  end

  # GET /lsoa_matchers/new
  def new
    @lsoa_matcher = LsoaMatcher.new
  end

  # GET /lsoa_matchers/1/edit
  def edit
  end

  # POST /lsoa_matchers or /lsoa_matchers.json
  def create
    @lsoa_matcher = LsoaMatcher.new(lsoa_matcher_params)

    respond_to do |format|
      if @lsoa_matcher.save
        format.html { redirect_to lsoa_matcher_url(@lsoa_matcher), notice: "Lsoa matcher was successfully created." }
        format.json { render :show, status: :created, location: @lsoa_matcher }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lsoa_matcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lsoa_matchers/1 or /lsoa_matchers/1.json
  def update
    respond_to do |format|
      if @lsoa_matcher.update(lsoa_matcher_params)
        format.html { redirect_to lsoa_matcher_url(@lsoa_matcher), notice: "Lsoa matcher was successfully updated." }
        format.json { render :show, status: :ok, location: @lsoa_matcher }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lsoa_matcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lsoa_matchers/1 or /lsoa_matchers/1.json
  def destroy
    @lsoa_matcher.destroy

    respond_to do |format|
      format.html { redirect_to lsoa_matchers_url, notice: "Lsoa matcher was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lsoa_matcher
      @lsoa_matcher = LsoaMatcher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lsoa_matcher_params
      params.require(:lsoa_matcher).permit(:name, :match_strings, :extra_postcodes)
    end
end
