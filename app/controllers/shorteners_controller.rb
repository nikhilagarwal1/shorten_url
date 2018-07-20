class ShortenersController < ApplicationController
  before_action :set_shortener, only: [:show, :edit, :update, :destroy]


  # GET /shorteners
  # GET /shorteners.json
  def index
    @shorteners = Shortener.all
    render json: @shorteners and return unless request.format.html?
  end

  # GET /shorteners/1
  # GET /shorteners/1.json
  def show
    if @shortener.present?
      render json: @shortener and return unless request.format.html?
    else
      render :json => { :errors => "Shortner doesn't exists with this id" }
    end
  end

  def original_redirect
    @shortener = Shortener.find_by_shorten_url(params['shorten_url'])
    redirect_to @shortener.sanitized_url
  end
  # GET /shorteners/new
  def new
    @shortener = Shortener.new
  end

  # GET /shorteners/1/edit
  def edit
  end

  def fetch_original_url
    @shortner = Shortener.find_by_shorten_url(params['shorten_url'].gsub("#{request.base_url}/", ''))
    if @shortner.present?
      render json: {original_url: @shortner.url}
    else
      render :json => { :errors => "Shorten Url doesn't exists" }
    end
  end

  # POST /shorteners
  # POST /shorteners.json
  def create
    @shortener = Shortener.new(shortener_params)
    @shortener.sanitize
    respond_to do |format|
      if @shortener.new_url?
        if @shortener.save
          format.html { redirect_to @shortener, notice: 'Shortener was successfully created.' }
          format.json { render :show, status: :created, location: @shortener }
        else
          format.html { render :new }
          format.json { render json: @shortener.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @shortener, notice: 'Shortener was already there.' }
      end
    end
  end

  # PATCH/PUT /shorteners/1
  # PATCH/PUT /shorteners/1.json
  def update
    respond_to do |format|
      if @shortener.update(shortener_params)
        format.html { redirect_to @shortener, notice: 'Shortener was successfully updated.' }
        format.json { render :show, status: :ok, location: @shortener }
      else
        format.html { render :edit }
        format.json { render json: @shortener.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /shorteners/1
  # DELETE /shorteners/1.json
  def destroy
    if @shortener.present?
      @shortener.destroy
      respond_to do |format|
        format.html { redirect_to shorteners_url, notice: 'Shortener was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      render :json => { :errors => "Shortner doesn't exists with this id" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shortener
      @shortener = Shortener.where(id: params[:id]).last
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shortener_params
      params.require(:shortener).permit(:url, :shorten_url, :sanitized_url)
    end
end
